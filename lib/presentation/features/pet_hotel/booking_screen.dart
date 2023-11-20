import 'package:co_pet/presentation/features/checkout/check_out_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int quantity1 = 0;
  int quantity2 = 0;
  int quantity3 = 0;

  Widget packageList(String sizeTitle, String size, int price, int quantity) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0.5.h),
            decoration: BoxDecoration(
                border: Border.all(
                  color: quantity != 0
                      ? Color.fromARGB(255, 0, 162, 255)
                      : const Color.fromARGB(
                          175, 158, 158, 158), // Border color
                  width: 1.0, // Border width
                ),
                borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        sizeTitle,
                        style: TextStyle(
                            color: quantity != 0
                                ? Color.fromARGB(255, 0, 162, 255)
                                : Color.fromARGB(255, 158, 158, 158),
                            fontSize: 12.sp),
                      ),
                      Text(
                        size,
                        style: TextStyle(
                            color: quantity != 0
                                ? Color.fromARGB(255, 0, 162, 255)
                                : Color.fromARGB(255, 158, 158, 158),
                            fontSize: 12.sp),
                      ),
                    ],
                  ),
                ),
                Text(
                  currencyFormatter.format(price),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: quantity != 0
                          ? Color.fromARGB(255, 0, 162, 255)
                          : Color.fromARGB(255, 104, 104, 104),
                      fontSize: 13.sp),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Row(
            children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      debugPrint("sebelum dikurang quantity $quantity");
                      if (quantity > 0) {
                        quantity--;
                        debugPrint("sesudah dikurang quantity $quantity");
                      }
                    });
                  },
                  child: const Icon(Icons.remove)),
              Container(
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color.fromARGB(
                        255, 155, 155, 155), // Border color
                    width: 1.0, // Border width
                  ),
                ),
                child: Text(quantity.toString()),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: const Icon(Icons.add)),
            ],
          )
        ],
      ),
    );
  }

  Widget popUpBottomBar() {
    return BottomAppBar(
      color: Color.fromARGB(255, 0, 162, 255),
      child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(),
              IconButton(
                icon: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => CheckoutScreen()))),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Jansen Petshop"),
          elevation: 2,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Choose Package",
                  style: TextStyle(color: Color.fromARGB(255, 159, 159, 159)),
                ),
                packageList("Small", "10x10", 50000, quantity1),
                packageList("Medium", "10x10", 50000, quantity2),
                packageList("Large", "10x10", 50000, quantity3),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Choose Date",
                  style: TextStyle(color: Color.fromARGB(255, 159, 159, 159)),
                ),
                const SizedBox(
                  height: 10,
                ),
                SfDateRangePicker(
                  enablePastDates: false,
                  toggleDaySelection: true,
                  selectionMode: DateRangePickerSelectionMode.range,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                      enableSwipeSelection: false),
                  headerStyle: const DateRangePickerHeaderStyle(
                      backgroundColor: Color.fromARGB(255, 0, 162, 255),
                      textStyle: TextStyle(color: Colors.white)),
                  startRangeSelectionColor: Color.fromARGB(255, 0, 162, 255),
                  endRangeSelectionColor: Color.fromARGB(255, 0, 162, 255),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: popUpBottomBar());
  }
}
