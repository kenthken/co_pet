part of detail_item_card;

class TabServices extends StatefulWidget {
  const TabServices({super.key});

  @override
  State<TabServices> createState() => _TabServicesState();
}

class _TabServicesState extends State<TabServices> {
  Widget serviceCardHotel(data.Hotel hotelData) {
    CurrencyFormarter currencyformat = CurrencyFormarter();

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
                          hotelData.titleHotel,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 11, 11, 11),
                              fontSize: 13.sp),
                        ),
                        Text(
                          "${currencyformat.currency(hotelData.priceHotel)}/Day",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 11, 11, 11),
                              fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ),
                for (String e in hotelData.serviceDetailHotel)
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
                        e,
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceCardGrooming(data.Grooming groomingData) {
    CurrencyFormarter currencyformat = CurrencyFormarter();
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
                        Expanded(
                          child: Text(
                            groomingData.titleGrooming,
                            style: TextStyle(
                                color: const Color.fromARGB(255, 11, 11, 11),
                                fontSize: 13.sp),
                          ),
                        ),
                        Text(
                          "${currencyformat.currency(groomingData.priceGrooming)}/Day",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 11, 11, 11),
                              fontSize: 12.sp),
                        )
                      ],
                    ),
                  ),
                ),
                for (String e in groomingData.serviceDetailGrooming)
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
                        e,
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget hotelServicesDisplay(List<data.Hotel> hotelData) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hotel',
            style: TextStyle(
              color: const Color(0xFF0093FF),
              fontSize: 15.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: 0.38,
            ),
          ),
          for (data.Hotel hotel in hotelData) serviceCardHotel(hotel),
        ],
      ),
    );
  }

  Widget groomingServicesDisplay(List<data.Grooming> groomingData) {
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
          for (data.Grooming grooming in groomingData)
            serviceCardGrooming(grooming),
        ],
      ),
    );
  }

  Future<dynamic> showBottomSheetBook(context) {
    Widget bookCard(String title, List<dynamic> dataa) {
      return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ProductListScreen(),
          //     ));
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => dataa is List<data.Grooming>
                      ? BookingPetHotelScreen(
                          id: storeDetailModel!.id,
                          name: storeDetailModel!.petShopName,
                          groomingData: dataa,
                          hotelData: const [],
                        )
                      : BookingPetHotelScreen(
                          id: storeDetailModel!.id,
                          name: storeDetailModel!.petShopName,
                          hotelData: dataa as List<data.Hotel>,
                          groomingData: const [],
                        ))));
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
                          "Booking",
                          style: TextStyle(
                              fontSize: 15.sp, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      for (String e in storeDetailModel!.services)
                        bookCard(
                            e,
                            e == "Grooming"
                                ? storeDetailModel!.groomings
                                : storeDetailModel!.hotels),
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

  Widget serviceLoaded() {
    return Padding(
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
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          storeDetailModel!.petShopName,
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
                                  "${storeDetailModel!.rating} ",
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 90, 89, 89),
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                                Text(
                                  "/5 ",
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
                  ),
                  ElevatedButton(
                      onPressed: storeDetailModel!.isOpen
                          ? () {
                              showBottomSheetBook(context);
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
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
                    storeDetailModel!.description,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 189, 189, 189),
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
                          color: const Color.fromARGB(255, 78, 78, 78),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      storeDetailModel!.location,
                      style: TextStyle(
                        color: const Color.fromARGB(255, 189, 189, 189),
                        fontSize: 13.sp,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Operational hour",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 78, 78, 78),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          "${DateFormat.jm().format(storeDetailModel!.openTime)} - ${DateFormat.jm().format(storeDetailModel!.closeTime)}",
                          style: TextStyle(
                            color: const Color.fromARGB(255, 189, 189, 189),
                            fontSize: 13.sp,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            storeDetailModel!.isOpen == true
                                ? "Open"
                                : "Closed",
                            style: TextStyle(
                                color: storeDetailModel!.isOpen == true
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 13.sp))
                      ],
                    )
                  ],
                ),
              ),
            ),
            storeDetailModel!.hotels.isNotEmpty
                ? hotelServicesDisplay(storeDetailModel!.hotels)
                : Container(),
            storeDetailModel!.groomings.isNotEmpty
                ? groomingServicesDisplay(storeDetailModel!.groomings)
                : Container()
          ],
        ),
      ),
    );
  }

  Widget serviceLoading() {
    return Padding(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer.fromColors(
                          baseColor: const Color.fromARGB(98, 184, 184, 184),
                          highlightColor:
                              const Color.fromARGB(255, 215, 215, 215),
                          child: Container(
                            color: Colors.white,
                            height: 8.w,
                            width: 35.w,
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Shimmer.fromColors(
                              baseColor:
                                  const Color.fromARGB(98, 184, 184, 184),
                              highlightColor:
                                  const Color.fromARGB(255, 215, 215, 215),
                              child: Container(
                                color: Colors.white,
                                height: 8.w,
                                width: 30.w,
                              )),
                        ],
                      )
                    ],
                  ),
                  Shimmer.fromColors(
                      baseColor: const Color.fromARGB(98, 184, 184, 184),
                      highlightColor: const Color.fromARGB(255, 215, 215, 215),
                      child: Container(
                        color: Colors.white,
                        height: 10.w,
                        width: 30.w,
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                      baseColor: const Color.fromARGB(98, 184, 184, 184),
                      highlightColor: const Color.fromARGB(255, 215, 215, 215),
                      child: Container(
                        color: Colors.white,
                        height: 8.w,
                        width: 30.w,
                      )),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: SizedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                        baseColor: const Color.fromARGB(98, 184, 184, 184),
                        highlightColor:
                            const Color.fromARGB(255, 215, 215, 215),
                        child: Container(
                          color: Colors.white,
                          height: 50.w,
                          width: 100.w,
                        )),
                  ],
                ),
              ),
            ),
            Shimmer.fromColors(
                baseColor: const Color.fromARGB(98, 184, 184, 184),
                highlightColor: const Color.fromARGB(255, 215, 215, 215),
                child: Container(
                  color: Colors.white,
                  height: 50.w,
                  width: 100.w,
                )),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return CustomScrollView(
            key: const PageStorageKey<String>("Services"),
            slivers: <Widget>[
              SliverOverlapInjector(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              ),
              SliverToBoxAdapter(
                child: BlocBuilder(
                  bloc: storeDetailCubit,
                  builder: (context, state) {
                    if (state is StoreDetailLoaded) {
                      storeDetailIsLoading = false;
                    }
                    return storeDetailIsLoading
                        ? serviceLoading()
                        : serviceLoaded();
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
