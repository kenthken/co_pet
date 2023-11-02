import 'package:co_pet/presentation/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  Duration defaultDuration = Duration(seconds: 10);
  final defaultPadding = EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  String status = "Waiting Payment";
  String virtualAccount = "2232323232323";
  int totalPayment = 101000;
  bool paymentComplete = false;
  bool orderComplete = false;
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

  Future showReviewDialog() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Feedback",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemSize: 30,
                  allowHalfRating: false,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 5.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: Color.fromARGB(255, 221, 221, 221))),
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration: InputDecoration.collapsed(
                            hintText: "Write a feedback..."),
                        minLines:
                            4, // any number you need (It works as the rows for the textarea)
                        keyboardType: TextInputType.multiline,
                        maxLines: 6,
                      )),
                ),
              ],
            ),
            actions: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  bottomLeft: Radius.circular(10))),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child:
                            Text("Cancel", style: TextStyle(fontSize: 10.sp)),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomRight: Radius.circular(10)))),
                          child: Text("OK", style: TextStyle(fontSize: 10.sp))),
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
                              onDone: () {
                                setState(() {
                                  status = "Success";
                                  orderComplete = true;
                                });
                              },
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
                            decoration: BoxDecoration(
                              border: Border.symmetric(
                                  horizontal: BorderSide(
                                      width: 1,
                                      color:
                                          Color.fromARGB(255, 211, 211, 211))),
                              color: status != "Success"
                                  ? Color.fromARGB(255, 241, 241, 241)
                                  : Colors.white,
                            ),
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
                                              onPressed: status != "Success"
                                                  ? null
                                                  : () {
                                                      if (orderComplete) {
                                                        showReviewDialog();
                                                      }
                                                    },
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
                                                orderComplete
                                                    ? Icons.star
                                                    : Icons.chat,
                                                color: status != "Success"
                                                    ? Colors.grey
                                                    : orderComplete
                                                        ? Colors.yellow
                                                        : Color.fromARGB(
                                                            255, 0, 162, 255),
                                              ))),
                                      Text(
                                        orderComplete ? "Review" : "Chat",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: status != "Success"
                                                ? Colors.grey
                                                : Color.fromARGB(
                                                    255, 0, 162, 255),
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
                          status != "Success"
                              ? GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      status = "Order Cancel";
                                      orderComplete = false;
                                      defaultDuration = Duration(seconds: 0);
                                    });
                                  },
                                  child: const Text(
                                    "Cancel Booking",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold),
                                  ))
                              : Container()
                        ],
                      )))
            ],
          )),
    );
  }
}
