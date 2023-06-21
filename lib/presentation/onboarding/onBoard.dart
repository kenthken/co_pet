import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class onBoarding extends StatefulWidget {
  const onBoarding({super.key});

  @override
  State<onBoarding> createState() => _onBoardingState();
}

class _onBoardingState extends State<onBoarding> {
  int currentIndex = 0;
  final controller = PageController(viewportFraction: 1, keepPage: true);

  Widget pageOneContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 55.w,
          height: 40.h,
          child: Image.asset(
            "assets/onBoard/page1.png",
            width: 55.w,
            height: 40.h,
          ),
        ),
        RichText(
          text: TextSpan(style: TextStyle(fontSize: 20.sp), children: const [
            TextSpan(
                text: "Lorem ipsum dolor sit amet, ",
                style: TextStyle(color: Colors.white)),
            TextSpan(
                text: "consectetur adipiscing elit.",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.t.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget pageTwoContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 55.w,
          height: 40.h,
          child: Image.asset(
            "assets/onBoard/page2.png",
          ),
        ),
        RichText(
          text: TextSpan(style: TextStyle(fontSize: 20.sp), children: const [
            TextSpan(
                text: "Lorem ipsum dolor sit amet, ",
                style: TextStyle(color: Colors.white)),
            TextSpan(
                text: "consectetur.",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.t.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget pageThreeContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          child: Image.asset(
            "assets/onBoard/page3.png",
          ),
        ),
        RichText(
          text: TextSpan(style: TextStyle(fontSize: 20.sp), children: const [
            TextSpan(
                text: "Lorem ipsum dolor sit amet, ",
                style: TextStyle(color: Colors.white)),
            TextSpan(
                text: "consectetur adipiscing elit.",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white))
          ]),
        ),
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit.t.",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
        ),
      ],
    );
  }

  Widget pageOne() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Positioned(
            bottom: 0,
            child: Container(
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
          child: Container(
        height: 100.h,
        width: 100.w,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                width: 100.w,
                height: 50.h,
                child: Image.asset("assets/onBoard/Vector 1.png",
                    fit: BoxFit.fill),
              ),
            ),
            Container(
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
                        child: Container(
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
                                                "Back",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            )
                                          : const SizedBox(),
                                    )),
                                Flexible(
                                    flex: 1,
                                    child: Container(
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
                                  child: Container(
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
                                          backgroundColor: const Color.fromARGB(
                                              255, 136, 213, 255),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                        ),
                                        child: const Text(
                                          "Next",
                                          style: TextStyle(color: Colors.white),
                                        )),
                                  ),
                                )
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
