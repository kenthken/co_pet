import 'package:co_pet/presentation/pet-service/trainer/manage_services/trainer_manage_service_screen.dart';
import 'package:co_pet/presentation/user/activity/activity_screen.dart';
import 'package:co_pet/presentation/user/chat/chat_lobby_screen.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';

class TrainerServiceScreen extends StatefulWidget {
  const TrainerServiceScreen({super.key});

  @override
  State<TrainerServiceScreen> createState() => _TrainerServiceScreenState();
}

class _TrainerServiceScreenState extends State<TrainerServiceScreen> {
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
    id = await SecureStorageService().readData("trainer_id");
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
                  const Icon(
                    Icons.settings,
                    color: Colors.grey,
                  ),
                  "Manage Service",
                  TrainerManageServiceScreen(
                    isAdmin: false,
                    id: id,
                  )),
              createMenuButton(
                  context,
                  const Icon(
                    Icons.library_books_rounded,
                    color: Colors.grey,
                  ),
                  "Activity",
                  HistoryScreen(user: userType)),
              createMenuButton(
                  context,
                  const Icon(
                    Icons.chat,
                    color: Colors.grey,
                  ),
                  "Chat",
                  const ChatLobbyScreen()),
            ],
          )
        ],
      ),
    );
  }
}
