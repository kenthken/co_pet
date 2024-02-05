part of detail_trainer;

class TabServices extends StatefulWidget {
  final Data.Data data;
  const TabServices({super.key, required this.data});

  @override
  State<TabServices> createState() => _TabServicesState();
}

Widget serviceCard() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    child: Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SizedBox(
          width: 100.w,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(142, 215, 215, 215),
                      width: 2.0,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Train Dog",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 11, 11, 11),
                            fontSize: 13.sp),
                      ),
                      Text(
                        "Rp 50.000/Session",
                        style: TextStyle(
                            color: const Color.fromARGB(255, 11, 11, 11),
                            fontSize: 12.sp),
                      )
                    ],
                  ),
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Train Dog",
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  )
                ],
              ),
              Row(
                children: [
                  const Icon(
                    Icons.circle,
                    size: 10,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    "AC 24 Jam",
                    style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}

Widget servicesDisplay() {
  return Container(
    margin: const EdgeInsets.only(bottom: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Services',
          style: TextStyle(
            color: const Color(0xFF0093FF),
            fontSize: 15.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 0.38,
          ),
        ),
        serviceCard(),
        serviceCard()
      ],
    ),
  );
}

Widget groomingServicesDisplay() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Grooming',
          style: TextStyle(
            color: const Color(0xFF0093FF),
            fontSize: 15.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,
            height: 0,
            letterSpacing: 0.38,
          ),
        ),
        serviceCard(),
        serviceCard()
      ],
    ),
  );
}

Future<dynamic> showBottomSheetBook(context) {
  Widget bookCard(String title) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: ((context) => BookingPetHotelScreen())));
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
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
                        "Booking",
                        style: TextStyle(
                            fontSize: 15.sp, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    bookCard("Hotel"),
                    bookCard("Grooming")
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
                color: const Color.fromARGB(255, 88, 87, 87), fontSize: 12.sp),
          ),
        )
      ],
    ),
  );
}

class _TabServicesState extends State<TabServices> {
  CurrencyFormarter currencyFormart = CurrencyFormarter();
  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(15.0),
                  child: SizedBox(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.data.nama,
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
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
                                            "${widget.data.rating} (${widget.data.totalRating})",
                                            style: TextStyle(
                                                color: const Color.fromARGB(
                                                    255, 161, 161, 161),
                                                fontSize: 15.sp),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      currencyFormart
                                          .currency(widget.data.harga),
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.bold,
                                          color: const Color.fromARGB(
                                              255, 0, 162, 255))),
                                  Text("/Sessions ",
                                      style: TextStyle(
                                          fontSize: 10.sp,
                                          color: const Color.fromARGB(
                                              255, 181, 181, 181))),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Text(
                          "Status",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 78, 78, 78),
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                            widget.data.isAvailable == true
                                ? "Available"
                                : "Not Available",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: widget.data.isAvailable == true
                                    ? Color.fromARGB(255, 0, 255, 21)
                                    : Colors.red)),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Description",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 78, 78, 78),
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.data.spesialis,
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 189, 189, 189),
                                        fontSize: 13.sp),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        detail("Experience", widget.data.pengalaman),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                onPressed: widget.data.isAvailable == true
                                    ? () async {
                                        List<ListPackage> listPackage = [
                                          ListPackage(
                                              widget.data.id,
                                              "${widget.data.nama} Pet Training Session",
                                              widget.data.harga,
                                              1)
                                        ];
                                        CheckoutModel
                                            checkoutModel = CheckoutModel(
                                                userId: int.parse(
                                                    await SecureStorageService()
                                                        .readData("id")),
                                                title: widget.data.nama,
                                                jamKonsultasi: DateTime.now(),
                                                listPackage: listPackage,
                                                detailPackage:
                                                    "Pet Training Session",
                                                serviceType: "trainer",
                                                storeId: widget.data.id,
                                                total: widget.data.harga);

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
                                )),
                          ],
                        )
                      ],
                    ),
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
