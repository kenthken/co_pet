part of detail_doctor;

class TabServices extends StatefulWidget {
  final DoctorDetailModel data;
  const TabServices({super.key, required this.data});

  @override
  State<TabServices> createState() => _TabServicesState();
}

class _TabServicesState extends State<TabServices> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeDateFormatting('ar', '').then((value) => null);
    initializeDateFormatting('en', '').then((value) => null);
  }

  CurrencyFormarter currencyFormart = CurrencyFormarter();

  Widget detail(String fieldName, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              fieldName,
              style: TextStyle(
                  color: const Color.fromARGB(255, 189, 189, 189),
                  fontSize: 12.sp),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                  color: const Color.fromARGB(255, 88, 87, 87),
                  fontSize: 12.sp),
            ),
          )
        ],
      ),
    );
  }

  Future<dynamic> showBottomSheetChat() {
    Widget bookCard(String title) {
      return GestureDetector(
        onTap: () {
          title == "Schedule your chat" ? scheduleChat() : null;
          // Navigator.push(context,
          //     MaterialPageRoute(builder: ((context) => BookingScreen())));
        },
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          alignment: Alignment.centerLeft,
          width: 100.w,
          height: 7.h,
          child: Text(
            title,
            style: TextStyle(
                fontSize: 13.sp, color: const Color.fromARGB(255, 0, 162, 255)),
          ),
        ),
      );
    }

    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
              child: Wrap(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(
                                  147, 151, 151, 151), // Border color
                              width: 1.0, // Border width
                              style: BorderStyle
                                  .solid, // Border style (solid, dashed, etc.)
                            ),
                          ),
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Chat Doctor",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      bookCard("Chat now"),
                      bookCard("Schedule your chat")
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> scheduleChat() {
    DateTime selectTime = DateTime.now();

    return showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter mystate) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Wrap(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.only(top: 5, bottom: 3.h),
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(Icons.arrow_back))),
                      ],
                    ),
                    Text(
                      "Choose date",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 159, 159, 159),
                          fontSize: 12.sp),
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
                      startRangeSelectionColor:
                          const Color.fromARGB(255, 0, 162, 255),
                      endRangeSelectionColor:
                          const Color.fromARGB(255, 0, 162, 255),
                    ),
                    Text(
                      "Choose Time",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 159, 159, 159),
                          fontSize: 12.sp),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TimesSlotGridViewFromInterval(
                      locale: "en",
                      initTime: selectTime,
                      crossAxisCount: 4,
                      selectedColor: const Color.fromARGB(255, 0, 162, 255),
                      timeSlotInterval: const TimeSlotInterval(
                        start: TimeOfDay(hour: 10, minute: 00),
                        end: TimeOfDay(hour: 18, minute: 0),
                        interval: Duration(hours: 1, minutes: 00),
                      ),
                      onChange: (value) {
                        mystate(() {
                          selectTime = value;
                          debugPrint("$selectTime");
                        });
                      },
                    ),
                    const Divider(),
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                          onPressed: () {
                            // Navigator.pushAndRemoveUntil(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) => CheckoutScreen())),
                            //     (route) => route.isFirst);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: ((context) => PaymentScreen())));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 0, 162, 255),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 13.sp),
                            ),
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data.data;
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        // This Builder is needed to provide a BuildContext that is
        // "inside" the NestedScrollView, so that
        // sliverOverlapAbsorberHandleFor() can find the
        // NestedScrollView.
        builder: (BuildContext context) {
          return CustomScrollView(
            // The "controller" and "primary" members should be left
            // unset, so that the NestedScrollView can control this
            // inner scroll view.
            // If the "controller" property is set, then this scroll
            // view will not be associated with the NestedScrollView.
            // The PageStorageKey should be unique to this ScrollView;
            // it allows the list to remember its scroll position when
            // the tab view is not on the screen.
            key: const PageStorageKey<String>("Services"),
            slivers: <Widget>[
              SliverOverlapInjector(
                // This is the flip side of the SliverOverlapAbsorber
                // above.
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data.nama,
                                  style: TextStyle(
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.yellow,
                                          size: 20.sp,
                                        ),
                                        Text(
                                          "${data.rating} (${data.totalRating})",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 90, 89, 89),
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Status",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 119, 119, 119),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    data.isAvailable == true
                                        ? "Available"
                                        : "Not Available",
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: data.isAvailable == true
                                            ? Color.fromARGB(255, 0, 255, 21)
                                            : Colors.red)),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(currencyFormart.currency(data.harga),
                                  style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 0, 162, 255))),
                              Text("/30 minute",
                                  style: TextStyle(
                                      fontSize: 10.sp,
                                      color: const Color.fromARGB(
                                          255, 181, 181, 181))),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: 100.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Detail",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 119, 119, 119),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            detail("Experience", data.pengalaman),
                            detail("STR", data.noStr),
                            detail("Practice at", data.lokasiPraktek),
                            detail("Education", data.alumni),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 60.w,
                        child: Padding(
                          padding: EdgeInsets.all(5.w),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 162, 255),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              onPressed: widget.data.data.isAvailable == true
                                  ? () async {
                                      // showBottomSheetChat();
                                      List<ListPackage> listPackage = [
                                        ListPackage(
                                            data.id,
                                            "${data.nama} 30 Minute Session",
                                            data.harga,
                                            1)
                                      ];
                                      CheckoutModel checkoutModel =
                                          CheckoutModel(
                                              userId: int.parse(
                                                  await SecureStorageService()
                                                      .readData("id")),
                                              title: data.nama,
                                              jamKonsultasi: DateTime.now(),
                                              listPackage: listPackage,
                                              detailPackage:
                                                  "30 Minute Consultation",
                                              serviceType: "dokter",
                                              storeId: data.id,
                                              total: data.harga);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CheckoutScreen(
                                                    checkoutModel:
                                                        checkoutModel),
                                          ));
                                    }
                                  : null,
                              child: const Text(
                                "Chat ",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
