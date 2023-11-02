import 'package:co_pet/presentation/profile/change_password_screen.dart';
import 'package:co_pet/presentation/profile/edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget accountList(String title, Widget page) {
      return GestureDetector(
        onTap: () => PersistentNavBarNavigator.pushNewScreen(
          context,
          screen: page,
          withNavBar: false,
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey.shade400,
                size: 13.sp,
              )
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Icon(Icons.person_outlined),
                    const SizedBox(
                      width: 10,
                    ),
                    Text("Account",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.sp))
                  ],
                ),
              ),
            ),
            Divider(
              height: 1.0,
              thickness: 0.5,
            ),
            accountList("Edit Profile", EditProfileScreen()),
            accountList("Change Password", ChangePasswordScreen()),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.red, fontSize: 14.sp),
                ))
          ],
        ),
      ),
    );
  }
}
