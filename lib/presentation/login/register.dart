import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class Register extends StatelessWidget {
  const Register({super.key});

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
                      Expanded(
                        child: Container(
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
                                    Text("Let’s create your account first!",
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
                                                text: "Register your account ",
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
                                width: 50.w,
                                height: 100.h,
                                child: Image.asset(
                                  "assets/register/register.png",
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 40),
                        width: 100.w,
                        child: Text(
                          "Register",
                          style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 0, 162, 255)),
                        ),
                      ),
                      SizedBox(
                        width: 100.w,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Username',
                                  suffixIcon: Icon(
                                    Icons.person,
                                    color: const Color.fromARGB(
                                        255, 141, 141, 141),
                                    size: 16.sp,
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 154, 154, 154),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Phone',
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    color: Color.fromARGB(255, 141, 141, 141),
                                    size: 16.sp,
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 154, 154, 154),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Email',
                                  suffixIcon: Icon(
                                    Icons.mail,
                                    color: Color.fromARGB(255, 141, 141, 141),
                                    size: 16.sp,
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 154, 154, 154),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Password',
                                  suffixIcon: Icon(
                                    Icons.remove_red_eye,
                                    color: Color.fromARGB(255, 141, 141, 141),
                                    size: 16.sp,
                                  ),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 154, 154, 154),
                                      fontSize: 14.sp),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 30),
                        child: SizedBox(
                          width: 70.w,
                          height: 6.h,
                          child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 162, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.only(bottom: 12, top: 30),
                  width: 100.w,
                  child: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 14.sp, color: Colors.black),
                        children: const [
                          TextSpan(
                              text: "Already have an Account? ",
                              style: TextStyle(fontWeight: FontWeight.w300)),
                          TextSpan(
                              text: "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ))
                        ]),
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
