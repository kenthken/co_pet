import 'dart:async';

import 'package:co_pet/domain/models/user/user_register_request_model.dart';
import 'package:co_pet/domain/repository/pet-service/register_pet_service.dart';
import 'package:co_pet/domain/repository/user/user_register_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:gif_view/gif_view.dart';
import 'package:sizer/sizer.dart';

class EmailVerificationScreen extends StatefulWidget {
  final UserRegisterRequestModel data;
  final bool isPetService;
  const EmailVerificationScreen(
      {Key? key, required this.data, required this.isPetService})
      : super(key: key);

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen>
    with TickerProviderStateMixin {
      
  bool isEmailVerified = false;
  Timer? timer;
  final controller = GifController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.currentUser?.sendEmailVerification();

    timer =
        Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());
  }

  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    bool response = false;
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });

    if (isEmailVerified) {
      if (widget.isPetService) {
        response = await PetServiceRegisterRepository()
            .registerPetServiceBE(widget.data);
      } else {
        debugPrint("uid ${widget.data.uid}");
        response = await UserRegisterRepository().registerUserBE(widget.data);
      }
      print("Register response : $response");
      if (response) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Email Successfully Verified")));

        timer?.cancel();
      } else {
        FirebaseAuth.instance.currentUser!.delete();
        Navigator.pop(context);

        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Please try again")));
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          FirebaseAuth.instance.currentUser!.delete();
          return true;
        },
        child: MediaQuery.removeViewPadding(
          removeTop: true,
          context: context,
          child: Center(
            child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 40.h,
                    width: 100.w,
                    child: Stack(
                      children: [
                        SizedBox(
                            width: 100.w,
                            height: 100.h,
                            child: Image.asset(
                              "assets/register/Vector 3.png",
                              fit: BoxFit.fill,
                            )),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 5.w),
                          width: 100.w,
                          height: 100.h,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 40.w,
                                height: 100.h,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Email Verification",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.sp,
                                          height: 1.5,
                                        )),
                                    const SizedBox(height: 20),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(fontSize: 14.sp),
                                          children: const [
                                            TextSpan(
                                                text:
                                                    "Verify your email to continue account registration",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                          ]),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                  width: 30.w,
                                  height: 100.h,
                                  child: Image.asset(
                                    "assets/register/email.png",
                                  )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 35),
                        const SizedBox(height: 30),
                        const SizedBox(height: 8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: Center(
                            child: Text(
                              'We have sent you a Email on  ${FirebaseAuth.instance.currentUser?.email}',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: const Color.fromARGB(255, 73, 75, 75)),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Center(
                            child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 0, 162, 255),
                        )),
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32.0),
                          child: Center(
                            child: Text(
                              'Verifying email....',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(height: 57),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color.fromARGB(255, 0, 162, 255)),
                              // You can set other properties like padding, textStyle, etc. here
                            ),
                            child: const Text(
                              'Resend',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              try {
                                FirebaseAuth.instance.currentUser
                                    ?.sendEmailVerification();
                              } catch (e) {
                                debugPrint('resend email error $e');
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
