import 'package:co_pet/domain/models/user/user_register_request_model.dart';
import 'package:co_pet/domain/repository/user/user_register_repository.dart';
import 'package:co_pet/presentation/user/login/email_verification.dart';
import 'package:co_pet/presentation/user/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  UserRegisterRepository userRegisterRepository = UserRegisterRepository();

  TextEditingController _username = TextEditingController(),
      _phone = TextEditingController(),
      _email = TextEditingController(),
      _password = TextEditingController();
  String usernameErrorMessage = "";
  String phoneErrorMessage = "";
  String emailErrorMessage = "";
  String passErrorMessage = "";
  bool obsecureText = true,
      validateEmail = false,
      validatePass = false,
      validatePhone = false,
      validateUsername = false;
  bool loading = false;
  void clearTextField() {
    _username.clear();
    _phone.clear();
    _email.clear();
    _password.clear();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _username.text = "a";
    _email.text = "juniorkenth@gmail.com";
    _phone.text = "1";
    _password.text = "123123";
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
                                                  fontWeight: FontWeight.w300)),
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
                                controller: _username,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Username',
                                  errorText: validateUsername
                                      ? usernameErrorMessage
                                      : null,
                                  suffixIcon: Icon(
                                    Icons.person,
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: _phone,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ], // Only numbers can be entered
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Phone',
                                  errorText:
                                      validatePhone ? phoneErrorMessage : null,
                                  suffixIcon: Icon(
                                    Icons.phone,
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: _email,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Email',
                                  errorText:
                                      validateEmail ? emailErrorMessage : null,
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
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: TextFormField(
                                controller: _password,
                                obscureText: obsecureText,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  labelText: 'Password',
                                  errorText:
                                      validatePass ? passErrorMessage : null,
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
                              onPressed: () async {
                                validateUsername = _username.text.isEmpty;
                                validatePhone = _phone.text.isEmpty;
                                validateEmail = _email.text.isEmpty;
                                validatePass = _password.text.isEmpty;

                                if (validateUsername) {
                                  usernameErrorMessage =
                                      "Username can't be empty";
                                } else if (!validateUsername &&
                                    _username.text.length < 6) {
                                  validateUsername = true;
                                  usernameErrorMessage =
                                      "Minimum username 6 characters";
                                }

                                if (validatePhone) {
                                  phoneErrorMessage =
                                      "Insert valid phone number";
                                } else if (!validatePhone &&
                                        _phone.text.length < 7 ||
                                    _phone.text.length > 13) {
                                  validatePhone = true;
                                  phoneErrorMessage =
                                      "Insert valid phone number";
                                }

                                if (validateEmail) {
                                  emailErrorMessage = "Insert valid email";
                                }

                                if (!validateEmail &&
                                    !validatePass &&
                                    !validateUsername &&
                                    !validatePhone &&
                                    _username.text.length >= 6 &&
                                    _phone.text.length >= 7) {
                                  setState(() {
                                    loading = true;
                                  });

                                  final firebaseUserRegis =
                                      await userRegisterRepository.firebaseUser(
                                          _email.text, _password.text);

                                  UserRegisterRequestModel data =
                                      UserRegisterRequestModel(
                                          email: _email.text,
                                          nama: _username.text,
                                          gender: "Male",
                                          noTelp: _phone.text,
                                          password: _password.text,
                                          uid: firebaseUserRegis.uid);

                                  if (firebaseUserRegis.success) {
                                    clearTextField();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                EmailVerificationScreen(
                                                  data: data,
                                                  isPetService: false,
                                                )));
                                  } else if (firebaseUserRegis.message !=
                                          null &&
                                      firebaseUserRegis.message!
                                          .contains("email")) {
                                    validateEmail = true;
                                    emailErrorMessage =
                                        firebaseUserRegis.message.toString();
                                  } else if (firebaseUserRegis.message !=
                                          null &&
                                      firebaseUserRegis.message!
                                          .contains("password")) {
                                    validatePass = true;
                                    passErrorMessage =
                                        firebaseUserRegis.message.toString();
                                  }
                                  loading = false;
                                }
                                setState(() {});
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
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => const Login())));
                    },
                    child: RichText(
                      text: TextSpan(
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.black),
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
                ),
              ]),
        ),
      ),
    );
  }
}
