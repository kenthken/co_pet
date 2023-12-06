import 'package:co_pet/cubits/user/user_session/user_login_cubit.dart';
import 'package:co_pet/presentation/chat/chat_lobby_screen.dart';
import 'package:co_pet/presentation/features/doctor/doctor_screen.dart';
import 'package:co_pet/presentation/features/pet_hotel/pet_hotel_screen.dart';
import 'package:co_pet/presentation/features/pet_trainer/pet_trainer_screen.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String? username;
  @override
  void initState() {
    // TODO: implement initState
    UserCubit().isTokenEmpty();
    super.initState();
    getUsername();
  }

  void getUsername() async {
    username = await SecureStorageService().readData("username");
    setState(() {});
  }

  Widget createMenuButton(
      BuildContext context, Image iconImage, String menuTitle, Widget page) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Container(
            height: 60,
            width: 60,
            margin: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
                onPressed: () {
                  PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: page,
                    withNavBar: false,
                  );
                  // Navigator.push(context, MaterialPageRoute(
                  //   builder: (context) {
                  //     print("asdasdas");

                  //     showNavBarCubit.hideNavBar();

                  //     return PetHotelScreen();
                  //   },
                  // ));
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 0.50, color: Colors.white),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                child: iconImage)),
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
    return Scaffold(
      body: Container(
        width: 100.w,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 100.h,
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Hi,",
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          username != null
                              ? Text(
                                  username!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                )
                              : Shimmer.fromColors(
                                  baseColor:
                                      const Color.fromARGB(98, 184, 184, 184),
                                  highlightColor:
                                      const Color.fromARGB(255, 215, 215, 215),
                                  child: Container(
                                    color: Colors.white,
                                    height: 5.w,
                                    width: 15.w,
                                  )),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                              onTap: () {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: const ChatLobbyScreen(),
                                  withNavBar: false,
                                );
                              },
                              child: const Icon(
                                Icons.chat_outlined,
                                color: Color.fromARGB(255, 159, 159, 159),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: const Color.fromARGB(255, 0, 162, 255),
                  ),
                  width: 100.w,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.start,
                                    text: TextSpan(
                                        style: TextStyle(
                                            fontSize: 13.sp, letterSpacing: 1),
                                        children: const [
                                          TextSpan(
                                              text: "Manage your pet ",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                          TextSpan(
                                              text: "daily activity schedule ",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white)),
                                          TextSpan(
                                              text: "now ",
                                              style: TextStyle(
                                                  color: Colors.white)),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Start",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 0, 162, 255),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                child: Image.asset("assets/home/groupp.png")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 100.w,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Features",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 0, 162, 255),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.centerLeft,
                  width: double.infinity,
                  child: Wrap(
                    spacing: 25,
                    children: [
                      createMenuButton(
                          context,
                          Image.asset(
                            "assets/home/pethotel.png",
                          ),
                          "Pet Hotel",
                          const PetHotelScreen()),
                      createMenuButton(
                          context,
                          Image.asset("assets/home/pethotel.png"),
                          "Pet Doctor",
                          const DoctorScreen()),
                      createMenuButton(
                          context,
                          Image.asset("assets/home/pethotel.png"),
                          "Pet Trainer",
                          const PetTrainerScreen()),
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
