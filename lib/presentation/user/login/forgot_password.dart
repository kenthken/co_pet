import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _email = TextEditingController();
  bool validateEmail = false;
  bool isEmailSent = false;
  Widget inputEmail() {
    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.grey,
                ))
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Text(
              'Input your email address',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 10.sp, color: const Color.fromARGB(255, 158, 159, 159)),
            ),
          ],
        ),
        const SizedBox(height: 20),
        TextFormField(
          controller: _email,
          autocorrect: true,
          decoration: InputDecoration(
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color.fromARGB(255, 198, 198,
                      198)), // Set the desired underline color here
            ),
            errorText: validateEmail ? "Email Can't Be Empty" : null,
            labelText: 'Email',
            suffixIcon: Icon(
              Icons.mail,
              color: const Color.fromARGB(255, 141, 141, 141),
              size: 16.sp,
            ),
            labelStyle: TextStyle(
                color: const Color.fromARGB(255, 154, 154, 154),
                fontSize: 10.sp),
          ),
        ),
        const SizedBox(height: 57),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 0, 162, 255)),
                // You can set other properties like padding, textStyle, etc. here
              ),
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                // try {
                //   FirebaseAuth.instance.currentUser
                //       ?.sendEmailVerification();
                // } catch (e) {
                //   debugPrint('resend email error $e');
                // }
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget emailSent() {
    return Column(
      children: [
        SizedBox(
            height: 50.w,
            width: 50.w,
            child: Image.asset("assets/pet-service/verification/verif.png")),
        const Text(
          "We have sent reset password link to your email address, check for further details",
          style: TextStyle(color: Colors.grey),
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
                const Color.fromARGB(255, 0, 162, 255)),
            // You can set other properties like padding, textStyle, etc. here
          ),
          child: const Text(
            'Back to login page',
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removeViewPadding(
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
                                  Text("Reset Password",
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
                                                  "Reset password link will be sent to your email address",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w300)),
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
                      isEmailSent ? emailSent() : inputEmail()
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
