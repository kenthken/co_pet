import 'dart:convert';
import 'package:co_pet/cubits/user/pet_doctor/pet_doctor_list_cubit.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_model.dart'
    as data;
import 'package:co_pet/presentation/user/features/doctor/recommended_list_doctor_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sizer/sizer.dart';

class SearchDoctorScreen extends StatefulWidget {
  const SearchDoctorScreen({super.key});

  @override
  State<SearchDoctorScreen> createState() => _SearchDoctorScreenState();
}

class _SearchDoctorScreenState extends State<SearchDoctorScreen> {
  final TextEditingController _search = TextEditingController();
  PetDoctorListCubit petDoctorListCubit = PetDoctorListCubit();
  List<data.Datum> petDoctordata = [];
  bool noData = false;

  Widget card(data.Datum data) {
    return Container(
      width: 100.w,
      height: 45.w,
      margin: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 0, 0, 0)
                .withOpacity(0.5), // Shadow color with opacity
            spreadRadius: 0, // Spread radius
            blurRadius: 1, // Blur radius
            offset: const Offset(0, 0.5), // Offset from the top
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SizedBox(
                width: 35.w,
                height: 35.w,
                child: Image.memory(
                  base64Decode(data.foto),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data.nama,
                    style: TextStyle(fontSize: 12.sp),
                  ),
                  Text(
                    data.pengalaman,
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 181, 181, 181)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("No STR",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color.fromARGB(255, 181, 181, 181))),
                  Text(data.noStr,
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color.fromARGB(255, 181, 181, 181),
                          fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("Status",
                      style: TextStyle(
                          fontSize: 10.sp,
                          color: const Color.fromARGB(255, 181, 181, 181))),
                  Text("Available",
                      style: TextStyle(
                          fontSize: 12.sp,
                          color: Color.fromARGB(255, 0, 255, 21))),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(currencyFormart.currency(data.harga),
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 0, 162, 255))),
                Text("/30 minute",
                    style: TextStyle(
                        fontSize: 10.sp,
                        color: const Color.fromARGB(255, 181, 181, 181))),
              ],
            ),
          ],
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
                  petDoctordata.clear();
                }
                petDoctorListCubit.getPetDoctorList(search);
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
        bloc: petDoctorListCubit,
        builder: (context, state) {
          if (state is PetDoctorListLoaded && _search.text.isNotEmpty) {
            petDoctordata.clear();

            if (state.data.data!.isEmpty) {
              noData = true;
            } else {
              for (var e in state.data.data) {
                petDoctordata.add(e);
                noData = false;
              }
            }
          }
          return !noData
              ? ListView.builder(
                  itemCount: petDoctordata.length,
                  itemBuilder: (context, index) => card(petDoctordata[index]),
                )
              : const Center(
                  child: Text("Search not found"),
                );
        },
      ),
    );
  }
}
