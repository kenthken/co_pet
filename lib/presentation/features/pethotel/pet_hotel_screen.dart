library pet_hotel;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:co_pet/presentation/features/pethotel/detail_item_card/detail_item_card_scree.dart';
import 'package:co_pet/presentation/features/pethotel/detail_item_card/detail_item_card_screen.dart';
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
    _appBar(height) => PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, height),
          child: Stack(
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

              Container(), // Required some widget in between to float AppBar

              Positioned(
                // To take AppBar Size only
                top: 100.0,
                left: 20.0,
                right: 20.0,
                child: Material(
                  elevation: 3,
                  child: AppBar(
                    backgroundColor: Colors.white,
                    leading: const Icon(
                      Icons.search,
                      color: Color.fromARGB(255, 0, 162, 255),
                    ),
                    primary: false,
                    title: const TextField(
                        decoration: InputDecoration(
                            hintText: "Search",
                            border: InputBorder.none,
                            hintStyle: TextStyle(color: Colors.grey))),
                  ),
                ),
              )
            ],
          ),
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
      title: Container(
        margin: EdgeInsets.all(5),
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: const TextField(
            decoration: InputDecoration(
                hintText: "Search",
                icon: Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 0, 162, 255),
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey))),
      ),
      headerWidget: _appBar(AppBar().preferredSize.height),
      headerExpandedHeight: 0.15,
      fullyStretchable: true,
      body: [
        ImageCarousel(),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
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
            Text(
              "See All",
              style: TextStyle(
                  color: Color.fromARGB(255, 0, 162, 255),
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold),
            )
          ]),
        ),
        Container(
          width: 100.w,
          height: 28.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            itemBuilder: ((context, index) {
              return Container(
                child: ItemCard(),
              );
            }),
          ),
        )
      ],
      curvedBodyRadius: 0,
      backgroundColor: Colors.white,
      appBarColor: Color.fromARGB(255, 0, 162, 255),
    );
  }
}
