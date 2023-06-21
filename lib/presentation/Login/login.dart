import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removeViewPadding(
        removeTop: true,
        context: context,
        child: Center(
          child: ListView(physics: BouncingScrollPhysics(), children: [
            SizedBox(
              width: 100.w,
              height: 100.h,
              child: Column(
                children: [
                  Flexible(
                      flex: 2,
                      child: SizedBox(
                        height: 100.h,
                        width: 100.w,
                        child: Stack(
                          children: [
                            SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: Image.asset(
                                  "assets/login/Vector 8.png",
                                  fit: BoxFit.fill,
                                )),
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                width: 100.w,
                                height: 100.h,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      width: 40.w,
                                      height: 100.h,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Hello!",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 28.sp),
                                          ),
                                          const SizedBox(height: 20),
                                          RichText(
                                            text: TextSpan(
                                                style:
                                                    TextStyle(fontSize: 14.sp),
                                                children: const [
                                                  TextSpan(
                                                      text:
                                                          "Sign In your account to start the ",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w300)),
                                                  TextSpan(
                                                      text: "Journey.",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.white))
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50.w,
                                      height: 100.h,
                                      child: Image.asset(
                                        "assets/login/login.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 3,
                      child: Container(
                        width: 100.w,
                        height: 100.h,
                        padding: EdgeInsets.symmetric(horizontal: 5.w),
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.only(bottom: 40),
                              width: 100.w,
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 0, 162, 255)),
                              ),
                            ),
                            Container(
                              width: 100.w,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255,
                                                  198,
                                                  198,
                                                  198)), // Set the desired underline color here
                                        ),
                                        labelText: 'Email',
                                        suffixIcon: Icon(
                                          Icons.mail,
                                          color: Color.fromARGB(
                                              255, 141, 141, 141),
                                        ),
                                        labelStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 154, 154, 154)),
                                      ),
                                    ),
                                  ),
                                  TextFormField(
                                    decoration: const InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(255, 198, 198,
                                                198)), // Set the desired underline color here
                                      ),
                                      labelText: 'Password',
                                      suffixIcon: Icon(
                                        Icons.remove_red_eye_rounded,
                                        color:
                                            Color.fromARGB(255, 141, 141, 141),
                                      ),
                                      labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 154, 154, 154)),
                                    ),
                                  ),
                                  Container(
                                    width: 100.w,
                                    alignment: Alignment.centerRight,
                                    padding: const EdgeInsets.only(
                                        top: 10, bottom: 30),
                                    child: Text(
                                      "Forgot Password?",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color:
                                              Color.fromARGB(255, 0, 162, 255)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 70.w,
                              height: 6.h,
                              child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Color.fromARGB(255, 0, 162, 255),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                          ],
                        ),
                      )),
                  Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.only(bottom: 12),
                        width: 100.w,
                        height: 100.h,
                        child: RichText(
                          text: TextSpan(
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.black),
                              children: const [
                                TextSpan(
                                    text: "Don’t have an Account? ",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w300)),
                                TextSpan(
                                    text: "Sign Up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ))
                              ]),
                        ),
                      ))
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
