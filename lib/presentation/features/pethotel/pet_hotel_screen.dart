library pet_hotel;

import 'package:carousel_slider/carousel_slider.dart';

import 'package:co_pet/presentation/features/pethotel/detail_item_card/detail_item_card_screen.dart';
import 'package:co_pet/presentation/features/pethotel/recommended_list_screen.dart';
import 'package:co_pet/presentation/features/pethotel/search_pet_hotel_screen.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'image_carousel.dart';
part 'item_card.dart';

class PetHotelScreen extends StatefulWidget {
  const PetHotelScreen({super.key});

  @override
  State<PetHotelScreen> createState() => _PetHotelScreenState();
}

class _PetHotelScreenState extends State<PetHotelScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double headerHeight = AppBar().preferredSize.height + 100;

    _appBar(height) => Stack(
          children: <Widget>[
            Container(
              // Background

              color: const Color.fromARGB(255, 0, 162, 255),
              height: height + 75,
              width: MediaQuery.of(context).size.width,

              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      "Pet Hotel",
                      style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              // To take AppBar Size only
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SearchPetHotelScreen())),
                child: Material(
                  elevation: 3,
                  child: AppBar(
                    backgroundColor: Colors.white,
                    leading: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 162, 255),
                    ),
                    primary: false,
                    title: Text(
                      "Search",
                      style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );

    return DraggableHome(
      physics: PageScrollPhysics(),
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      title: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchPetHotelScreen())),
        child: Container(
          width: 100.w,
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
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
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
              ],
            ),
          ),
        ),
      ),
      headerWidget: _appBar(AppBar().preferredSize.height),
      headerExpandedHeight: headerHeight / screenHeight,
      body: [
        ImageCarousel(),
        Padding(
          padding: EdgeInsets.only(top: 4.h, left: 4.w, right: 4.w),
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
                      "Pet Hotel & Grooming",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 162, 255),
                        fontSize: 10.sp,
                      ),
                    )
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RecommendedListScreen(),
                      )),
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
        Container(
          height: 60.w,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(top: 0),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => ItemCard()),
        ),
      ],
      curvedBodyRadius: 0,
      backgroundColor: Colors.white,
      appBarColor: Color.fromARGB(255, 0, 162, 255),
    );
  }
}
