import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/pet-service/doctor/manage_services/doctor_manage_services_screen.dart';
import 'package:co_pet/presentation/pet-service/hotel_grooming/manage_services/hotel_grooming_manage_services_screen.dart';
import 'package:co_pet/presentation/user/activity/activity_screen.dart';
import 'package:co_pet/presentation/user/chat/chat_lobby_screen.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class DoctorServiceScreen extends StatefulWidget {
  const DoctorServiceScreen({super.key});

  @override
  State<DoctorServiceScreen> createState() => _DoctorServiceScreenState();
}

class _DoctorServiceScreenState extends State<DoctorServiceScreen> {
  String id = "";
  String userType = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getUserId();
      await getUserType();
      setState(() {});
    });
  }

  Future<void> getUserId() async {
    id = await SecureStorageService().readData("doctor_id");
  }

  Future<void> getUserType() async {
    userType = await SecureStorageService().readData("service_type");
  }

  Widget createMenuButton(
      BuildContext context, Icon icon, String menuTitle, Widget page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.all(10),
            child: ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: page,
                    withNavBar: false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: icon)),
        Text(
          menuTitle,
          style: TextStyle(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 10.sp),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Features",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
                color: Colors.grey),
          ),
          Row(
            children: [
              createMenuButton(
                  context,
                  Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  "Manage Service",
                  DoctorManageServiceScreen(
                    id: id,
                    isAdmin: false,
                  )),
              createMenuButton(
                  context,
                  Icon(
                    Icons.library_books_rounded,
                    color: Colors.grey,
                  ),
                  "Activity",
                  HistoryScreen(user: userType)),
              createMenuButton(
                  context,
                  Icon(
                    Icons.chat,
                    color: Colors.grey,
                  ),
                  "Chat",
                  ChatLobbyScreen()),
            ],
          )
        ],
      ),
    );
  }
}
