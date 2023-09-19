import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class PetHotelScreen extends StatelessWidget {
  const PetHotelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    _appBar(height) => PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
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
                      const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
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
                child: AppBar(
                  elevation: 1,
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
              )
            ],
          ),
        );

    return Scaffold(appBar: _appBar(AppBar().preferredSize.height));
  }
}
