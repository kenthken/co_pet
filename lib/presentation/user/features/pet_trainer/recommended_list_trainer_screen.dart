import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecommendedTrainerList extends StatefulWidget {
  const RecommendedTrainerList({super.key});

  @override
  State<RecommendedTrainerList> createState() => _RecommendedTrainerListState();
}

class _RecommendedTrainerListState extends State<RecommendedTrainerList> {
  final List<String> name = ["Dog", "Cat"];

  CurrencyFormarter currencyFormart = CurrencyFormarter();

  Widget specialize(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 162, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          textAlign: TextAlign.center,
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget card() {
    return Container(
      width: 100.w,
      height: 40.w,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0)
                .withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 0, // Spread radius
            blurRadius: 1, // Blur radius
            offset: const Offset(0, 0.5), // Offset from the top
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: 35.w,
                child: Image.asset(
                  "assets/petTrainer/person.jpg",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        "Michael Gowel",
                        style: TextStyle(fontSize: 12.sp),
                      ),
                      Text(
                        "10 Year Experience",
                        style: TextStyle(
                            fontSize: 10.sp,
                            color: const Color.fromARGB(255, 181, 181, 181)),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(currencyFormart.currency(50000),
                          style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 0, 162, 255))),
                      Text("/Session ",
                          style: TextStyle(
                              fontSize: 10.sp,
                              color: const Color.fromARGB(255, 181, 181, 181))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.white,
        title: const Text(
          "Recommended Trainer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        color: const Color.fromARGB(255, 241, 241, 241),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: ((context, index) {
              return card();
            })),
      ),
    );
  }
}
