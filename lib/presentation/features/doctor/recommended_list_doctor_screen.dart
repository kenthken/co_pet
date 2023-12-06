import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecommendedDoctorListScreen extends StatefulWidget {
  const RecommendedDoctorListScreen({super.key});

  @override
  State<RecommendedDoctorListScreen> createState() =>
      _RecommendedDoctorListScreenState();
}

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
    height: 45.w,
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
            child: SizedBox(
              width: 35.w,
              child: Image.asset(
                "assets/petDoctor/doctor.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dr Michael Gowel",
                  style: TextStyle(fontSize: 12.sp),
                ),
                Text(
                  "10 Year Experience",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color.fromARGB(255, 181, 181, 181)),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("Specialize",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 181, 181, 181))),
                SizedBox(
                    height: 8.w,
                    width: 20.w,
                    child: ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        name.length,
                        (index) {
                          return specialize(name[index]);
                        },
                      ),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Text("No STR",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 181, 181, 181))),
                Text("1212121212121",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 181, 181, 181),
                        fontWeight: FontWeight.bold)),
              ],
            ),
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
              Text("/30 minute",
                  style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color.fromARGB(255, 181, 181, 181))),
            ],
          ),
        ],
      ),
    ),
  );
}

class _RecommendedDoctorListScreenState
    extends State<RecommendedDoctorListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.white,
        title: const Text(
          "Recommended Doctor",
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
