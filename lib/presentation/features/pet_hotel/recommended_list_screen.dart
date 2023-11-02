import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecommendedListScreen extends StatelessWidget {
  const RecommendedListScreen({super.key});

  Widget card() {
    Widget servicesIndicator() {
      return Container(
          margin: EdgeInsets.only(right: 5),
          padding: EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color.fromARGB(255, 0, 162, 255),
          ),
          child: const Text(
            "Grooming",
            style: TextStyle(color: Colors.white),
          ));
    }

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/petHotel/toko.jpg",
                    height: 20.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jansen PetShop",
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  "4.5 (3)",
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 161, 161, 161),
                                    fontSize: 10.sp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Services",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.sp),
                                ),
                                Row(
                                  children: [
                                    servicesIndicator(),
                                    servicesIndicator()
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Start from",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.sp),
                                ),
                                Text(
                                  "Rp 50.000",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
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
        title: Text(
          "Recommended",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 0, 162, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: ((context, index) {
              return card();
            })),
      ),
    );
  }
}
