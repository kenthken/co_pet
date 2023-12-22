import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/pet-service/service_registration/pet_hotel_registration_screen.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({
    super.key,
  });

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  String? id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  Future<void> getUserId() async {
    id = await UserLoginRepository().getUserId();
    debugPrint("id $id");
  }

  int currentIndex = 0;
  final controller = PageController(viewportFraction: 1, keepPage: true);

  Widget pageOneContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 55.w,
          child: Image.asset(
            "assets/pet-service/service-register/toko.png",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(style: TextStyle(fontSize: 20.sp), children: const [
              TextSpan(
                  text: "Register your pet services, ",
                  style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: "Pet Hotel and Grooming.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))
            ]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            PetHotelandGroomingRegistration(penyediaId: id!),
                      ));
                },
                child: Text(
                  "Register Pet Hotel and Grooming ->",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget pageTwoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 55.w,
          child: Image.asset(
            "assets/onBoard/page2.png",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(style: TextStyle(fontSize: 18.sp), children: const [
              TextSpan(
                  text: "Where Healing Hands Meet Wagging Tails, ",
                  style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: "Pet Doctor.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))
            ]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Register Pet Doctor ->",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget pageThreeContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 55.w,
          child: Image.asset(
            "assets/pet-service/service-register/trainer.png",
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.w),
          child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(style: TextStyle(fontSize: 18.sp), children: const [
              TextSpan(
                  text: "Unleashing Joyful Connections Through Training, ",
                  style: TextStyle(color: Colors.white)),
              TextSpan(
                  text: "Pet Trainer.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white))
            ]),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
                onPressed: () {},
                child: Text(
                  "Register Pet Trainer ->",
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget pageOne() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 0,
            child: SizedBox(
                width: 80.w,
                height: 75.h,
                child: currentIndex == 0
                    ? pageOneContent()
                    : currentIndex == 1
                        ? pageTwoContent()
                        : pageThreeContent()))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: SizedBox(
                width: 100.w,
                height: 50.h,
                child: Image.asset("assets/onBoard/Vector 1.png",
                    fit: BoxFit.fill),
              ),
            ),
            SizedBox(
                height: 100.h,
                width: 100.w,
                child: Column(
                  children: [
                    Flexible(
                      flex: 5,
                      child: PageView.builder(
                          itemCount: 3,
                          controller: controller,
                          physics: const NeverScrollableScrollPhysics(),
                          onPageChanged: (int index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                          itemBuilder: (_, index) {
                            return pageOne();
                          }),
                    ),
                    Flexible(
                        flex: 1,
                        child: SizedBox(
                            height: 100.h,
                            child: Row(
                              children: [
                                Flexible(
                                    flex: 1,
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100.w,
                                      child: currentIndex > 0
                                          ? GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  controller.animateToPage(
                                                    currentIndex - 1,
                                                    duration: const Duration(
                                                        milliseconds: 300),
                                                    curve: Curves.easeInOut,
                                                  );
                                                });
                                              },
                                              child: const Text(
                                                "Previous",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : const SizedBox(),
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: SizedBox(
                                        width: 100.w,
                                        child: DotsIndicator(
                                            dotsCount: 3,
                                            position: currentIndex,
                                            decorator: DotsDecorator(
                                              activeColor: const Color.fromARGB(
                                                  255, 136, 213, 255),
                                              color: Colors.white,
                                              size: const Size.square(9.0),
                                              spacing: const EdgeInsets.all(2),
                                              activeSize: const Size(18.0, 9.0),
                                              activeShape:
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0)),
                                            )))),
                                Flexible(
                                    flex: 1,
                                    child: currentIndex < 2
                                        ? SizedBox(
                                            width: 25.w,
                                            height: 5.h,
                                            child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    controller.animateToPage(
                                                      currentIndex + 1,
                                                      duration: const Duration(
                                                          milliseconds: 300),
                                                      curve: Curves.easeInOut,
                                                    );
                                                  });
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          255, 136, 213, 255),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: const Text(
                                                  "Next",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                )),
                                          )
                                        : const SizedBox())
                              ],
                            )))
                  ],
                ))
          ],
        ),
      )),
    );
  }
}
