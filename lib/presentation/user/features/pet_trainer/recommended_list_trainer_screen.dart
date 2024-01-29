import 'dart:convert';

import 'package:co_pet/cubits/user/pet_trainer/pet_trainer_list_cubit.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_model.dart'
    as Data;

class RecommendedTrainerList extends StatefulWidget {
  const RecommendedTrainerList({super.key});

  @override
  State<RecommendedTrainerList> createState() => _RecommendedTrainerListState();
}

class _RecommendedTrainerListState extends State<RecommendedTrainerList> {
  final List<String> name = ["Dog", "Cat"];
  PetTrainerListCubit petTrainerListCubit = PetTrainerListCubit();

  CurrencyFormarter currencyFormart = CurrencyFormarter();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    petTrainerListCubit.getTrainerList("");
  }

  Widget specialize(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 162, 255),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          textAlign: TextAlign.center,
          name,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget card(Data.Datum data) {
    return Container(
      width: 100.w,
      height: 40.w,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Colors.yellow,
                            ),
                            Text(
                              "${data.rating} (${data.totalRating})",
                              style: TextStyle(
                                  color:
                                      const Color.fromARGB(255, 161, 161, 161),
                                  fontSize: 10.sp),
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(currencyFormart.currency(data.harga),
                                style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color.fromARGB(
                                        255, 0, 162, 255))),
                            Text("/Session ",
                                style: TextStyle(
                                    fontSize: 10.sp,
                                    color: const Color.fromARGB(
                                        255, 181, 181, 181))),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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
        elevation: 2,
        foregroundColor: Colors.white,
        title: const Text(
          "Recommended Trainer",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
      ),
      body: BlocBuilder(
        bloc: petTrainerListCubit,
        builder: (context, state) {
          List<Data.Datum> data = [];
          if (state is PetTrainerListLoaded) {
            data.addAll(state.data.data);
          }
          return Container(
            width: 100.w,
            height: 100.h,
            color: const Color.fromARGB(255, 241, 241, 241),
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: ((context, index) {
                  return card(data[index]);
                })),
          );
        },
      ),
    );
  }
}
