import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/pet-service/auth/login.dart';
import 'package:co_pet/presentation/pet-service/service_registration/onBoard.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ServiceRegistrationScreen extends StatefulWidget {
  const ServiceRegistrationScreen({super.key});

  @override
  State<ServiceRegistrationScreen> createState() =>
      _ServiceRegistrationScreenState();
}

class _ServiceRegistrationScreenState extends State<ServiceRegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                        "Confirmation",
                        style: TextStyle(fontSize: 12.sp),
                        textAlign: TextAlign.center,
                      ),
                      content: SizedBox(
                        width: 80.w,
                        child: Text(
                          "Do you want to logout from your account ?",
                          style: TextStyle(fontSize: 12.sp),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      actions: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: OutlinedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10))),
                                  side: const BorderSide(
                                      color: Color.fromRGBO(0, 172, 237, 1)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 40.sp),
                                ),
                                child: Text("Cancel",
                                    style: TextStyle(fontSize: 10.sp)),
                              ),
                              ElevatedButton(
                                  onPressed: () {
                                    UserLoginRepository()
                                        .deleteUserSession(true);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPetService()),
                                        (route) => false);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.symmetric(
                                          vertical: 15, horizontal: 40.sp),
                                      backgroundColor:
                                          const Color.fromRGBO(0, 172, 237, 1),
                                      shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(10),
                                              bottomRight:
                                                  Radius.circular(10)))),
                                  child: Text("OK",
                                      style: TextStyle(fontSize: 10.sp)))
                            ],
                          ),
                        ),
                      ],
                    );
                  });
            },
          )
        ],
      ),
      body: const OnBoarding(),
    );
  }
}
