import 'package:co_pet/domain/models/checkout/checkout_model.dart';
import 'package:co_pet/domain/models/pet_hotel_grooming/store_detail_model.dart';
import 'package:co_pet/domain/repository/user_login_repository.dart';
import 'package:co_pet/presentation/features/checkout/check_out_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class BookingPetHotelScreen extends StatefulWidget {
  int id;
  String name;
  List<Hotel> hotelData;
  List<Grooming> groomingData;

  BookingPetHotelScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.groomingData,
      required this.hotelData});

  @override
  State<BookingPetHotelScreen> createState() => _BookingPetHotelScreenState();
}

class _BookingPetHotelScreenState extends State<BookingPetHotelScreen> {
  String? userId;

  List<GroomingPackage> groomingPackageList = [];
  List<GroomingPackage> groomingCart = [];
  DateTime? selectedDateGrooming;

  List<HotelPackage> hotelPackageList = [];
  List<HotelPackage> hotelCart = [];
  dynamic packageType;
  int total = 0;

  DateRangePickerController dateController = DateRangePickerController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    if (widget.groomingData.isNotEmpty) {
      for (var e in widget.groomingData) {
        groomingPackageList.add(GroomingPackage(e));
      }
      packageType = "Grooming";
    } else {
      packageType = "Hotel";
      for (var e in widget.hotelData) {
        hotelPackageList.add(HotelPackage(e));
      }
    }
  }

  void getUserId() async {
    userId = await UserLoginRepository().getUserId();
  }

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is PickerDateRange) {
        // _range = '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} -'
        //     // ignore: lines_longer_than_80_chars
        //     ' ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}';
      } else if (args.value is DateTime) {
        selectedDateGrooming = args.value;
        debugPrint("date $selectedDateGrooming");
      } else if (args.value is List<DateTime>) {
        // _dateCount = args.value.length.toString();
      } else {
        // _rangeCount = args.value.length.toString();
      }
    });
  }

  Widget packageGrooming(
    GroomingPackage groomingPackage,
  ) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);
    int quantity = groomingPackageList
        .firstWhere(
            (element) => element.grooming.id == groomingPackage.grooming.id)
        .quantity;

    var package = groomingPackageList.firstWhere(
        (element) => element.grooming.id == groomingPackage.grooming.id);

    return Row(
      children: [
        // Widget 1
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0.5.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: quantity != 0
                    ? Color.fromARGB(255, 0, 162, 255)
                    : const Color.fromARGB(175, 158, 158, 158), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    groomingPackage.grooming.titleGrooming,
                    style: TextStyle(
                        color: quantity != 0
                            ? Color.fromARGB(255, 0, 162, 255)
                            : Color.fromARGB(255, 158, 158, 158),
                        fontSize: 12.sp),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  currencyFormatter
                      .format(groomingPackage.grooming.priceGrooming),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: quantity != 0
                          ? Color.fromARGB(255, 0, 162, 255)
                          : Color.fromARGB(255, 104, 104, 104),
                      fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        // Expanded Widget

        // Widget 3
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (package.quantity > 0) {
                      package.quantity--;

                      total = total - groomingPackage.grooming.priceGrooming;
                    }
                  });
                },
                child: const Icon(Icons.remove)),
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 155, 155, 155), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: Text(quantity.toString()),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    package.quantity++;

                    total = total + groomingPackage.grooming.priceGrooming;
                  });
                },
                child: const Icon(Icons.add)),
          ],
        )
      ],
    );
  }

  Widget packageHotel(
    HotelPackage hotelPackage,
  ) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

    int quantity = hotelPackageList
        .firstWhere((element) => element.hotel.id == hotelPackage.hotel.id)
        .quantity;

    var package = hotelPackageList
        .firstWhere((element) => element.hotel.id == hotelPackage.hotel.id);

    return Row(
      children: [
        // Widget 1
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(vertical: 0.5.h),
            decoration: BoxDecoration(
              border: Border.all(
                color: quantity != 0
                    ? Color.fromARGB(255, 0, 162, 255)
                    : const Color.fromARGB(175, 158, 158, 158), // Border color
                width: 1.0, // Border width
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Text(
                    hotelPackage.hotel.titleHotel,
                    style: TextStyle(
                        color: quantity != 0
                            ? Color.fromARGB(255, 0, 162, 255)
                            : Color.fromARGB(255, 158, 158, 158),
                        fontSize: 12.sp),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  currencyFormatter.format(hotelPackage.hotel.priceHotel),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: quantity != 0
                          ? Color.fromARGB(255, 0, 162, 255)
                          : Color.fromARGB(255, 104, 104, 104),
                      fontSize: 13.sp),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 20,
        ),
        // Expanded Widget

        // Widget 3
        Row(
          children: [
            GestureDetector(
                onTap: () {
                  setState(() {
                    if (package.quantity > 0) {
                      package.quantity--;

                      total = total - hotelPackage.hotel.priceHotel;
                    }
                  });
                },
                child: const Icon(Icons.remove)),
            Container(
              padding: const EdgeInsets.all(10),
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(
                  color:
                      const Color.fromARGB(255, 155, 155, 155), // Border color
                  width: 1.0, // Border width
                ),
              ),
              child: Text(quantity.toString()),
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    package.quantity++;

                    total = total + hotelPackage.hotel.priceHotel;
                  });
                },
                child: const Icon(Icons.add)),
          ],
        )
      ],
    );
  }

  Widget popUpBottomBar() {
    return BottomAppBar(
      color: Color.fromARGB(255, 0, 162, 255),
      child: Padding(
          padding: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(color: Colors.white, fontSize: 13.sp),
                    ),
                    Text(
                      CurrencyFormarter().currency(total),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
                onPressed: () {
                  List<ListPackage> list = [];

                  if (packageType == "Grooming") {
                    updateCartGrooming(groomingPackageList);

                    if (groomingCart.isNotEmpty &&
                        dateController.selectedDate != null) {
                      String date =
                          DateTime(2023, dateController.displayDate!.month)
                              .toString()
                              .split(' ')[0];
                      String monthName =
                          DateFormat.MMMM().format(DateTime.parse(date));
                      for (var e in groomingCart) {
                        list.add(ListPackage(
                            e.grooming.id,
                            e.grooming.titleGrooming,
                            e.grooming.priceGrooming,
                            e.quantity));
                      }
                      CheckoutModel checkoutModel = CheckoutModel(
                          storeId: widget.id,
                          userId: int.parse(userId!),
                          title: widget.name,
                          detailPackage:
                              "Grooming | ${dateController.displayDate!.day.toString()} ${monthName}",
                          listPackage: list,
                          serviceType: packageType,
                          total: total,
                          grooming_date: dateController.displayDate,
                          end_date_hotel: null,
                          start_date_hotel: null);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CheckoutScreen(
                                    checkoutModel: checkoutModel,
                                  ))));
                      groomingCart.clear();
                    } else {
                      groomingCart.isEmpty
                          ? Fluttertoast.showToast(
                              msg: "Choose Package",
                              backgroundColor: Colors.white,
                              textColor: Colors.black)
                          : Fluttertoast.showToast(
                              msg: "Choose Date",
                              backgroundColor: Colors.white,
                              textColor: Colors.black);
                    }
                  } else {
                    updateCartHotel(hotelPackageList);

                    if (hotelCart.isNotEmpty &&
                        dateController.selectedRange != null) {
                      String startMonth = DateTime(2023,
                              dateController.selectedRange!.startDate!.month)
                          .toString()
                          .split(' ')[0];

                      String endMonth = DateTime(2023,
                              dateController.selectedRange!.startDate!.month)
                          .toString()
                          .split(' ')[0];

                      String startMonthName =
                          DateFormat.MMMM().format(DateTime.parse(startMonth));
                      String endMonthName =
                          DateFormat.MMMM().format(DateTime.parse(endMonth));

                      String startDate = dateController
                          .selectedRange!.startDate!
                          .toLocal()
                          .toString()
                          .split(' ')[0];
                      String endDate = dateController.selectedRange!.endDate!
                          .toLocal()
                          .toString()
                          .split(' ')[0];
                      debugPrint(
                          " start date ${DateTime.parse(startDate)} == end date ${DateTime.parse(endDate)}");
                      Duration difference = DateTime.parse(endDate)
                          .difference(DateTime.parse(startDate));
                      for (var e in hotelCart) {
                        list.add(ListPackage(e.hotel.id, e.hotel.titleHotel,
                            e.hotel.priceHotel, e.quantity));
                      }

                      CheckoutModel checkoutModel = CheckoutModel(
                          storeId: widget.id,
                          userId: int.parse(userId!),
                          title: widget.name,
                          detailPackage:
                              " ${dateController.selectedRange!.startDate!.day} $startMonthName - ${dateController.selectedRange!.endDate!.day} $endMonthName | ${difference.inDays} Days ",
                          listPackage: list,
                          serviceType: packageType,
                          total: total,
                          start_date_hotel:
                              dateController.selectedRange!.startDate,
                          end_date_hotel: dateController.selectedRange!.endDate,
                          grooming_date: null);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: ((context) => CheckoutScreen(
                                    checkoutModel: checkoutModel,
                                  ))));
                      hotelCart.clear();
                    } else {
                      hotelCart.isEmpty
                          ? Fluttertoast.showToast(
                              msg: "Choose Package",
                              backgroundColor: Colors.white,
                              textColor: Colors.black)
                          : Fluttertoast.showToast(
                              msg: "Choose Date",
                              backgroundColor: Colors.white,
                              textColor: Colors.black);
                    }
                  }
                },
              )
            ],
          )),
    );
  }

  void updateCartGrooming(List<GroomingPackage> listPackage) {
    for (var e in listPackage) {
      if (e.quantity > 0) {
        groomingCart.add(e);
      }
    }
  }

  void updateCartHotel(List<HotelPackage> listPackage) {
    for (var e in listPackage) {
      if (e.quantity > 0) {
        hotelCart.add(e);
      }
    }
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
                for (Hotel e in widget.hotelData) packageHotel(HotelPackage(e)),
                for (Grooming e in widget.groomingData)
                  packageGrooming(GroomingPackage(e)),
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
                  onSelectionChanged: _onSelectionChanged,
                  controller: dateController,
                  enablePastDates: false,
                  toggleDaySelection: true,
                  selectionMode: packageType == "Hotel"
                      ? DateRangePickerSelectionMode.range
                      : DateRangePickerSelectionMode.single,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                      enableSwipeSelection: false),
                  headerStyle: const DateRangePickerHeaderStyle(
                      backgroundColor: Color.fromARGB(255, 0, 162, 255),
                      textStyle: TextStyle(color: Colors.white)),
                  startRangeSelectionColor: Color.fromARGB(255, 0, 162, 255),
                  endRangeSelectionColor: Color.fromARGB(255, 0, 162, 255),
                  selectionColor: Color.fromARGB(255, 0, 162, 255),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: popUpBottomBar());
  }
}
