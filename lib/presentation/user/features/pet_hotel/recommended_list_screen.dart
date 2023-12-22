import 'package:co_pet/cubits/user/pet_hotel_grooming/store_list_cubit.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_list_model.dart'
    as data;
import 'package:co_pet/presentation/user/features/pet_hotel/detail_item_card/detail_item_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class RecommendedListScreen extends StatefulWidget {
  const RecommendedListScreen({super.key});

  @override
  State<RecommendedListScreen> createState() => _RecommendedListScreenState();
}

class _RecommendedListScreenState extends State<RecommendedListScreen> {
  StoreListCubit storeListCubit = StoreListCubit();
  List<data.Datum> storeListData = [];
  bool storeListDataIsLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeListCubit.getStoreList("");
  }

  Widget card(data.Datum data) {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);
    Widget servicesIndicator(String service) {
      return Container(
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 0, 162, 255),
          ),
          child: Text(
            service,
            style: const TextStyle(color: Colors.white),
          ));
    }

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailItemCardScreen(id: data.id)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    "assets/petHotel/toko.jpg",
                    height: 20.h,
                    width: 100.w,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.petShopName,
                              style: TextStyle(
                                  fontSize: 13.sp, fontWeight: FontWeight.w500),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Text(
                                  "${data.rating} (${data.totalRating})",
                                  style: TextStyle(
                                    color: const Color.fromARGB(255, 161, 161, 161),
                                    fontSize: 10.sp,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Services",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.sp),
                                ),
                                SizedBox(
                                  height: 8.w,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: data.services.length,
                                    itemBuilder: (context, index) =>
                                        servicesIndicator(data.services[index]),
                                  ),
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Start from",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 10.sp),
                                ),
                                Text(
                                  currencyFormatter.format(data.startFrom),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardSkeletonLoading() {
    final currencyFormatter =
        NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);
    Widget servicesIndicator(String service) {
      return Container(
          margin: const EdgeInsets.only(right: 5),
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color.fromARGB(255, 0, 162, 255),
          ),
          child: Text(
            service,
            style: const TextStyle(color: Colors.white),
          ));
    }

    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Material(
          elevation: 2,
          borderRadius: BorderRadius.circular(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Shimmer.fromColors(
                    baseColor: const Color.fromARGB(98, 184, 184, 184),
                    highlightColor: const Color.fromARGB(255, 215, 215, 215),
                    child: Image.asset(
                      "assets/petHotel/toko.jpg",
                      height: 20.h,
                      width: 100.w,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Shimmer.fromColors(
                                baseColor: const Color.fromARGB(98, 184, 184, 184),
                                highlightColor:
                                    const Color.fromARGB(255, 215, 215, 215),
                                child: Container(
                                  color: Colors.white,
                                  width: 30.w,
                                  height: 5.w,
                                )),
                            Row(
                              children: [
                                Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(98, 184, 184, 184),
                                    highlightColor:
                                        const Color.fromARGB(255, 215, 215, 215),
                                    child: Container(
                                      color: Colors.white,
                                      width: 5.w,
                                      height: 5.w,
                                    )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(98, 184, 184, 184),
                                    highlightColor:
                                        const Color.fromARGB(255, 215, 215, 215),
                                    child: Container(
                                      color: Colors.white,
                                      width: 10.w,
                                      height: 5.w,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(98, 184, 184, 184),
                                    highlightColor:
                                        const Color.fromARGB(255, 215, 215, 215),
                                    child: Container(
                                      color: Colors.white,
                                      width: 35.w,
                                      height: 10.w,
                                    )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Shimmer.fromColors(
                                    baseColor:
                                        const Color.fromARGB(98, 184, 184, 184),
                                    highlightColor:
                                        const Color.fromARGB(255, 215, 215, 215),
                                    child: Container(
                                      color: Colors.white,
                                      width: 30.w,
                                      height: 10.w,
                                    )),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        foregroundColor: Colors.white,
        title: const Text(
          "Recommended",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocBuilder(
          bloc: storeListCubit,
          builder: (context, state) {
            if (state is StoreListLoading) {
              storeListDataIsLoading = true;
            } else if (state is StoreListLoaded && storeListData.isEmpty) {
              for (var element in state.data.data!) {
                storeListData.add(element);
              }
              storeListDataIsLoading = false;
            }
            return ListView.builder(
                itemCount: storeListDataIsLoading ? 3 : storeListData.length,
                itemBuilder: ((context, index) {
                  return storeListDataIsLoading
                      ? cardSkeletonLoading()
                      : card(storeListData[index]);
                }));
          },
        ),
      ),
    );
  }
}
