library pet_doctor;

import 'package:co_pet/presentation/features/doctor/detail_doctor_screen.dart';
import 'package:co_pet/presentation/features/doctor/image_carousel.dart';
import 'package:co_pet/presentation/features/doctor/recommended_list_doctor_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'recommended_doctor_feed.dart';

class DoctorScreen extends StatefulWidget {
  const DoctorScreen({super.key});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: Text("Pet Doctor"),
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImageCarouselDoctorScreen(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: const Color.fromARGB(255, 0, 0, 0)
                                  .withOpacity(
                                      0.5), // Shadow color with opacity
                              spreadRadius: 0, // Spread radius
                              blurRadius: 1, // Blur radius
                              offset: Offset(0, 0.5), // Offset from the top
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Color.fromARGB(255, 0, 162, 255),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Search",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 0, 0, 0)
                              .withOpacity(0.5), // Shadow color with opacity
                          spreadRadius: 0, // Spread radius
                          blurRadius: 1, // Blur radius
                          offset: Offset(0, 0.5), // Offset from the top
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Icon(
                        Icons.chat,
                        color: Color.fromARGB(255, 0, 162, 255),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 2.h, left: 4.w, right: 4.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Recommended",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 162, 255),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Pet Doctor",
                          style: TextStyle(
                            color: Color.fromARGB(255, 0, 162, 255),
                            fontSize: 10.sp,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    RecommendedDoctorListScreen())));
                      },
                      child: Text(
                        "See All",
                        style: TextStyle(
                            color: Color.fromARGB(255, 0, 162, 255),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ]),
            ),
            RecommendedDoctorFeed()
          ],
        ),
      ),
    );
  }
}
