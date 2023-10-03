library detail_item_card;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'tab_services.dart';
part 'tab_review.dart';

class DetailItemCardScree extends StatefulWidget {
  const DetailItemCardScree({super.key});

  @override
  State<DetailItemCardScree> createState() => _DetailItemCardScreeState();
}

class _DetailItemCardScreeState extends State<DetailItemCardScree>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int tabCounter = 0;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          leading: backButton(context),
          expandedHeight: 30.h,
          flexibleSpace: FlexibleSpaceBar(
            background:
                Image.asset("assets/petHotel/toko.jpg", fit: BoxFit.cover),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              width: 100.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jansen PetShop",
                              style: TextStyle(
                                  fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.yellow,
                                      size: 20.sp,
                                    ),
                                    Text(
                                      "4.5 (3)",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 161, 161, 161),
                                          fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 162, 255),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            child: const Text(
                              "Book",
                              style: TextStyle(color: Colors.white),
                            ))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Description",
                          style: TextStyle(
                              color: Color.fromARGB(255, 78, 78, 78),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam et tortor lectus. Maecenas sed facilisis libero, et dictum sem. Praesent volutpat ultrices est quis fringilla. Suspendisse id quam molestie, ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 189, 189, 189),
                              fontSize: 13.sp),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Location",
                            style: TextStyle(
                                color: Color.fromARGB(255, 78, 78, 78),
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Jl Kemangisan no 32",
                            style: TextStyle(
                              color: Color.fromARGB(255, 189, 189, 189),
                              fontSize: 13.sp,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                TabBar(
                    labelPadding: const EdgeInsets.symmetric(vertical: 10),
                    automaticIndicatorColorAdjustment: true,
                    unselectedLabelColor: Color.fromARGB(255, 188, 188, 188),
                    controller: _tabController,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: Color.fromARGB(255, 78, 78, 78),
                    indicatorColor: const Color.fromARGB(255, 72, 179, 255),
                    onTap: ((value) {}),
                    labelStyle: SizerUtil.deviceType == DeviceType.mobile
                        ? TextStyle(
                            fontSize: 12.sp, fontWeight: FontWeight.bold)
                        : TextStyle(
                            fontSize: 9.sp, fontWeight: FontWeight.bold),
                    tabs: const [
                      Tab(text: "Services"),
                      Tab(text: "Review"),
                    ]),
                TabBarView(
                    controller: _tabController,
                    //lengket widget per tabF
                    physics: const NeverScrollableScrollPhysics(),
                    clipBehavior: Clip.none,
                    children: const [TabServices(), TabReview()])
              ],
            ),
          ),
        )
      ],
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }
}
