import 'package:co_pet/domain/models/user/checkout/checkout_model.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/user/features/checkout/check_out_screen.dart';
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
  int hotelTotalDays = 1;
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
        String startDate = dateController.selectedRange!.startDate!
            .toLocal()
            .toString()
            .split(' ')[0];
        String endDate = dateController.selectedRange!.endDate != null
            ? dateController.selectedRange!.endDate!
                .toLocal()
                .toString()
                .split(' ')[0]
            : startDate;

        Duration difference =
            DateTime.parse(endDate).difference(DateTime.parse(startDate));

        hotelTotalDays = difference.inDays != 0 ? difference.inDays : 1;
        total = total * hotelTotalDays;
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
                    ? const Color.fromARGB(255, 0, 162, 255)
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
                            ? const Color.fromARGB(255, 0, 162, 255)
                            : const Color.fromARGB(255, 158, 158, 158),
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
                          ? const Color.fromARGB(255, 0, 162, 255)
                          : const Color.fromARGB(255, 104, 104, 104),
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
              margin: const EdgeInsets.all(5),
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
                    ? const Color.fromARGB(255, 0, 162, 255)
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
                            ? const Color.fromARGB(255, 0, 162, 255)
                            : const Color.fromARGB(255, 158, 158, 158),
                        fontSize: 12.sp),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "${currencyFormatter.format(hotelPackage.hotel.priceHotel)}/day",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: quantity != 0
                          ? const Color.fromARGB(255, 0, 162, 255)
                          : const Color.fromARGB(255, 104, 104, 104),
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

                      total = total -
                          hotelPackage.hotel.priceHotel * hotelTotalDays;
                    }
                  });
                },
                child: const Icon(Icons.remove)),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(5),
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

                    total =
                        total + hotelPackage.hotel.priceHotel * hotelTotalDays;
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
      color: const Color.fromARGB(255, 0, 162, 255),
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
                    if (dateController.selectedDate != null) {
                      checkoutGrooming(list);
                    } else {
                      Fluttertoast.showToast(
                          msg: "Choose Date",
                          backgroundColor: Colors.white,
                          textColor: Colors.black);
                    }
                  } else {
                    if (dateController.selectedRange != null) {
                      checkoutHotel(list);
                    } else {
                      Fluttertoast.showToast(
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

  void checkoutGrooming(List<ListPackage> list) {
    bool cartIsNotEmpty = updateCartGrooming(groomingPackageList);

    if (!cartIsNotEmpty) {
      Fluttertoast.showToast(
          msg: "Choose Package",
          backgroundColor: Colors.white,
          textColor: Colors.black);
      return;
    }
    String month = DateTime(2023, dateController.displayDate!.month)
        .toString()
        .split(' ')[0];
    String groomingDate =
        dateController.selectedDate!.toLocal().toString().split(' ')[0];
    String monthName = DateFormat.MMMM().format(DateTime.parse(month));

    for (var e in groomingCart) {
      list.add(ListPackage(e.grooming.id, e.grooming.titleGrooming,
          e.grooming.priceGrooming, e.quantity));
    }

    CheckoutModel checkoutModel = CheckoutModel(
        storeId: widget.id,
        userId: int.parse(userId!),
        title: widget.name,
        detailPackage: "Grooming | ${groomingDate.substring(8, 10)} $monthName",
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
  }

  void checkoutHotel(List<ListPackage> list) {
    bool cartIsNotEmpty = updateCartHotel(hotelPackageList);
    if (!cartIsNotEmpty) {
      Fluttertoast.showToast(
          msg: "Choose Package",
          backgroundColor: Colors.white,
          textColor: Colors.black);
      return;
    }
    String startMonth =
        DateTime(2023, dateController.selectedRange!.startDate!.month)
            .toString()
            .split(' ')[0];

    String endMonth =
        DateTime(2023, dateController.selectedRange!.startDate!.month)
            .toString()
            .split(' ')[0];

    String startMonthName =
        DateFormat.MMMM().format(DateTime.parse(startMonth));
    String endMonthName = DateFormat.MMMM().format(DateTime.parse(endMonth));

    String startDate = dateController.selectedRange!.startDate!
        .toLocal()
        .toString()
        .split(' ')[0];
    String endDate = dateController.selectedRange!.endDate != null
        ? dateController.selectedRange!.endDate!
            .toLocal()
            .toString()
            .split(' ')[0]
        : startDate;
    debugPrint(
        " start date ${DateTime.parse(startDate)} == end date ${DateTime.parse(endDate)}");
    Duration difference =
        DateTime.parse(endDate).difference(DateTime.parse(startDate));
    for (var e in hotelCart) {
      list.add(ListPackage(
          e.hotel.id, e.hotel.titleHotel, e.hotel.priceHotel, e.quantity));
    }

    CheckoutModel checkoutModel = CheckoutModel(
        storeId: widget.id,
        userId: int.parse(userId!),
        title: widget.name,
        detailPackage:
            " ${startDate.substring(8, 10)} $startMonthName - ${endDate.substring(8, 10)} $endMonthName | ${difference.inDays == 0 ? 1 : difference.inDays} Days ",
        listPackage: list,
        serviceType: packageType,
        total: total,
        start_date_hotel: DateTime.parse(startDate),
        end_date_hotel: dateController.selectedRange!.endDate != null
            ? DateTime.parse(endDate)
            : DateTime.parse(startDate),
        grooming_date: null);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: ((context) => CheckoutScreen(
                  checkoutModel: checkoutModel,
                ))));
    hotelCart.clear();
  }

  bool updateCartGrooming(List<GroomingPackage> listPackage) {
    for (var e in listPackage) {
      if (e.quantity > 0) {
        groomingCart.add(e);
      }
    }
    return groomingCart.isNotEmpty ? true : false;
  }

  bool updateCartHotel(List<HotelPackage> listPackage) {
    for (var e in listPackage) {
      if (e.quantity > 0) {
        hotelCart.add(e);
      }
    }
    return hotelCart.isNotEmpty ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Jansen Petshop"),
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
                  initialDisplayDate: DateTime.now(),
                  initialSelectedDate: DateTime.now(),
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
                  startRangeSelectionColor:
                      const Color.fromARGB(255, 0, 162, 255),
                  endRangeSelectionColor:
                      const Color.fromARGB(255, 0, 162, 255),
                  selectionColor: const Color.fromARGB(255, 0, 162, 255),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: popUpBottomBar());
  }
}
