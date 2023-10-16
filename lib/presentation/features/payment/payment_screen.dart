import 'package:co_pet/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:timer_count_down/timer_count_down.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Duration defaultDuration = Duration(minutes: 30);
  final defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  String status = "Waiting Payment";
  String virtualAccount = "2232323232323";
  int totalPayment = 101000;
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Container(),
        centerTitle: true,
      ),
      body: Container(
          color: Color.fromARGB(255, 0, 162, 255),
          width: 100.w,
          height: 100.h,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(4.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Must Pay Within",
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer_sharp,
                              color: Colors.white,
                            ),
                            SlideCountdownSeparated(
                              decoration:
                                  BoxDecoration(color: Colors.transparent),
                              showZeroValue: true,
                              shouldShowDays: (p0) => false,
                              shouldShowHours: (p0) => true,
                              separator: ":",
                              separatorStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.bold),
                              duration: defaultDuration,
                              padding: defaultPadding,
                            ),
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Status :",
                          style:
                              TextStyle(color: Colors.white, fontSize: 13.sp),
                        ),
                        Text(status,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 13.sp,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(
                              20.0), // Adjust the radius as needed
                        ),
                      ),
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        children: [
                          Padding(
                            padding: EdgeInsets.all(4.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Payment Method",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: 20.w,
                                      height: 10.w,
                                      margin: EdgeInsets.only(
                                          right: 20, top: 20, bottom: 20),
                                      child: Image.asset(
                                        "assets/checkOut/bca.png",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                    Text(
                                      "BCA Virtual Account",
                                      style: TextStyle(fontSize: 10.sp),
                                    )
                                  ],
                                ),
                                Container(
                                  color: Color.fromARGB(255, 233, 233, 233),
                                  margin: EdgeInsets.only(bottom: 20),
                                  width: 100.w,
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          virtualAccount,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 17.sp),
                                        ),
                                        GestureDetector(
                                          onTap: () {},
                                          child: Icon(
                                            Icons.copy,
                                            color: Color.fromARGB(89, 0, 0, 0),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Total Payment",
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    Text(
                                      currencyFormatter.format(totalPayment),
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color:
                                              Color.fromARGB(255, 0, 162, 255),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order ID",
                                      style: TextStyle(fontSize: 12.sp),
                                    ),
                                    Text(
                                      "OR29102923838388",
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Color.fromARGB(
                                              255, 177, 177, 177),
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          Container(
                            width: 100.w,
                            color: Color.fromARGB(255, 241, 241, 241),
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      width: 30.w,
                                      height: 20.w,
                                      child: Image.asset(
                                        "assets/petHotel/toko.jpg",
                                        fit: BoxFit.cover,
                                      )),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Jansen Petshop",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12.sp),
                                      ),
                                      Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          children: [
                                            Text(
                                              "Duration",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 202, 202, 202),
                                                  fontSize: 10.sp),
                                            ),
                                            Text(
                                              "2 Days",
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 137, 137, 137),
                                                  fontSize: 10.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        "Detail Package",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 202, 202, 202),
                                            fontSize: 10.sp),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Small Size 10x10",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 137, 137, 137),
                                                fontSize: 10.sp),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Text(
                                            "1x",
                                            style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 173, 173, 173),
                                                fontSize: 10.sp),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                          height: 60,
                                          width: 60,
                                          margin: EdgeInsets.only(bottom: 10),
                                          child: ElevatedButton(
                                              onPressed: () {},
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.all(0),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      width: 0.50,
                                                      color: Colors.white),
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                              ),
                                              child: Icon(
                                                Icons.chat,
                                                color: Colors.grey,
                                              ))),
                                      Text(
                                        "Chat",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: Colors.black,
                                            fontSize: 10.sp),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10.w,
                          ),
                          Padding(
                            padding: EdgeInsets.all(5.w),
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Color.fromARGB(255, 0, 162, 255),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                onPressed: () {
                                  // Navigator.of(context).popUntil((route) => route.isFirst);
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Return main menu ",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Cancel Booking",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )))
            ],
          )),
    );
  }
}
