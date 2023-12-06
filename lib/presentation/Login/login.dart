import 'package:co_pet/cubits/user/user_session/user_login_cubit.dart';
import 'package:co_pet/presentation/login/register.dart';
import 'package:co_pet/presentation/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController(),
      _password = TextEditingController();
  bool obsecureText = true, validateEmail = false, validatePass = false;
  bool loading = false;
  UserCubit userCubit = UserCubit();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCubit.isTokenEmpty();
    _email.text = "lok@mail.com";
    _password.text = "123123";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder(
        bloc: userCubit,
        builder: (context, state) {
          if (state is UserLoading) {
            loading = true;
          } else if ((state is UserCheckToken && state.isTokenEmpty == false) ||
              state is UserLogin) {
            Future.delayed(Duration.zero, () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Navbar()),
                  (route) => false);
            });
          } else if (state is UserError) {
            loading = false;
          }
          return MediaQuery.removeViewPadding(
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
                                "assets/login/Vector 8.png",
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                            style: TextStyle(fontSize: 14.sp),
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
                              "Login",
                              style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      const Color.fromARGB(255, 0, 162, 255)),
                            ),
                          ),
                          SizedBox(
                            width: 100.w,
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20),
                                  child: TextFormField(
                                    controller: _email,
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color.fromARGB(255, 198, 198,
                                                198)), // Set the desired underline color here
                                      ),
                                      errorText: validateEmail
                                          ? "Email Can't Be Empty"
                                          : null,
                                      labelText: 'Email',
                                      suffixIcon: Icon(
                                        Icons.mail,
                                        color: const Color.fromARGB(
                                            255, 141, 141, 141),
                                        size: 16.sp,
                                      ),
                                      labelStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 154, 154, 154),
                                          fontSize: 14.sp),
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  controller: _password,
                                  obscureText: obsecureText,
                                  decoration: InputDecoration(
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 198, 198,
                                              198)), // Set the desired underline color here
                                    ),
                                    errorText: validatePass
                                        ? "Password Can't Be Empty"
                                        : null,
                                    labelText: 'Password',
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        // Based on passwordVisible state choose the icon
                                        obsecureText
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                        color: const Color.fromARGB(
                                            255, 141, 141, 141),
                                        size: 16.sp,
                                      ),
                                      onPressed: () {
                                        // Update the state i.e. toogle the state of passwordVisible variable
                                        setState(() {
                                          obsecureText = !obsecureText;
                                        });
                                      },
                                    ),
                                    labelStyle: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 154, 154, 154),
                                        fontSize: 14.sp),
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
                                        color: const Color.fromARGB(
                                            255, 0, 162, 255)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 70.w,
                            height: 6.h,
                            child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    validateEmail = _email.text.isEmpty;
                                    validatePass = _password.text.isEmpty;
                                  });
                                  if (!validateEmail && !validatePass) {
                                    await userCubit.login(
                                        _email.text, _password.text);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 0, 162, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: loading
                                    ? SpinKitWave(
                                        size: 20.sp,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return const DecoratedBox(
                                              decoration: BoxDecoration(
                                                  color: Colors.white));
                                        },
                                      )
                                    : Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold),
                                      )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(bottom: 12, top: 30),
                      width: 100.w,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Register())));
                        },
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
                      ),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    _password.dispose();
  }
}
