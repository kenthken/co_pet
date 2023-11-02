library pet_trainer;

import 'package:co_pet/presentation/features/pet_trainer/detail_trainer/detail_trainer_screen.dart';
import 'package:co_pet/presentation/features/pet_trainer/image_carousel.dart';
import 'package:co_pet/presentation/features/pet_trainer/recommended_list_trainer_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'recommended_trainer_feed.dart';

class PetTrainerScreen extends StatefulWidget {
  const PetTrainerScreen({super.key});

  @override
  State<PetTrainerScreen> createState() => _PetTrainerScreenState();
}

class _PetTrainerScreenState extends State<PetTrainerScreen> {
  Widget backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Color.fromARGB(255, 0, 162, 255),
          ),
          child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.white,
          title: Text("Pet Trainer"),
          backgroundColor: Color.fromARGB(255, 0, 162, 255),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ImageCarouselPetTrainerScreen(),
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
                            "Pet Trainer",
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
                                      RecommendedTrainerList())));
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
              RecommendedTrainerFeed()
            ],
          ),
        ));
  }
}
