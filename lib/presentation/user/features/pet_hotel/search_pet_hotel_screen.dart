import 'package:co_pet/cubits/user/pet_hotel_grooming/store_list_cubit.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_list_model.dart'
    as data;
import 'package:co_pet/presentation/user/features/pet_hotel/detail_item_card/detail_item_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class SearchPetHotelScreen extends StatefulWidget {
  const SearchPetHotelScreen({super.key});

  @override
  State<SearchPetHotelScreen> createState() => _SearchPetHotelScreenState();
}

class _SearchPetHotelScreenState extends State<SearchPetHotelScreen> {
  final TextEditingController _search = TextEditingController();
  StoreListCubit storeListCubit = StoreListCubit();

  List<data.Datum> storeData = [];
  bool noData = false;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
        iconTheme: const IconThemeData(color: Colors.white),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close_rounded)),
        title: Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: TextFormField(
              controller: _search,
              autofocus: true,
              onFieldSubmitted: (search) {
                if (search.isEmpty) {
                  storeData.clear();
                }
                storeListCubit.getStoreList(search);
              },
              decoration: const InputDecoration(
                  hintText: "Search",
                  icon: Icon(
                    Icons.search,
                    color: Color.fromARGB(255, 0, 162, 255),
                  ),
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey))),
        ),
      ),
      body: BlocBuilder(
        bloc: storeListCubit,
        builder: (context, state) {
          if (state is StoreListLoaded && _search.text.isNotEmpty) {
            storeData.clear();

            if (state.data.data!.isEmpty) {
              noData = true;
            } else {
              for (var e in state.data.data!) {
                storeData.add(e);
                noData = false;
              }
            }
          }
          return !noData
              ? ListView.builder(
                  itemCount: storeData.length,
                  itemBuilder: (context, index) => card(storeData[index]),
                )
              : const Center(
                  child: Text("Search not found"),
                );
        },
      ),
    );
  }
}
