import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController _username = TextEditingController(),
      _phone = TextEditingController(),
      _email = TextEditingController();
  SecureStorageService secureStorage = SecureStorageService();
  UserLoginRepository userRepo = UserLoginRepository();
  Widget field(String label, TextEditingController controller) {
    Icon? icon;

    if (label == "Username") {
      icon = Icon(
        Icons.person,
        color: const Color.fromARGB(255, 141, 141, 141),
        size: 16.sp,
      );
    } else if (label == "Phone") {
      icon = Icon(
        Icons.phone,
        color: const Color.fromARGB(255, 141, 141, 141),
        size: 16.sp,
      );
    } else if (label == "Email") {
      icon = Icon(
        Icons.email,
        color: const Color.fromARGB(255, 141, 141, 141),
        size: 16.sp,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198,
                    198)), // Set the desired underline color here
          ),
          labelText: label,
          suffixIcon: icon,
          labelStyle: TextStyle(
              color: const Color.fromARGB(255, 154, 154, 154), fontSize: 12.sp),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  void getData() async {
    _username.text = await secureStorage.readData("username");
    _phone.text = await secureStorage.readData("phone");
    _email.text = await secureStorage.readData("email");
    debugPrint("email ${_email.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              field("Username", _username),
              field("Phone", _phone),
              field("Email", _email),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: SizedBox(
                  width: 50.w,
                  height: 5.h,
                  child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
