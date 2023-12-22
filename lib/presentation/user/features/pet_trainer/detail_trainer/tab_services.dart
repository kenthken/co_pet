part of detail_trainer;

class TabServices extends StatefulWidget {
  const TabServices({super.key});

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

class _TabServicesState extends State<TabServices> {
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
                                    "Michael Gowel",
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
                                            "4.5 (3)",
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
                              ElevatedButton(
                                  onPressed: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: ((context) =>
                                    //             BookingScreen())));
                                  },
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
                                    color: const Color.fromARGB(255, 78, 78, 78),
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam et tortor lectus. Maecenas sed facilisis libero, et dictum sem. Praesent volutpat ultrices est quis fringilla. Suspendisse id quam molestie, ",
                                style: TextStyle(
                                    color: const Color.fromARGB(255, 189, 189, 189),
                                    fontSize: 13.sp),
                              )
                            ],
                          ),
                        ),
                        servicesDisplay(),
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
