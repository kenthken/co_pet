library detail_trainer;

import 'dart:convert';

import 'package:co_pet/cubits/user/pet_trainer/pet_trainer_list_detail_cubit.dart';
import 'package:co_pet/domain/models/user/checkout/checkout_model.dart';
import 'package:co_pet/domain/models/user/pet_trainer/pet_trainer_list_detail_model.dart'
    as Data;
import 'package:co_pet/presentation/user/features/checkout/check_out_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';

part "tab_review.dart";
part 'tab_services.dart';

class DetailTrainerScreen extends StatefulWidget {
  final String id;
  const DetailTrainerScreen({super.key, required this.id});

  @override
  State<DetailTrainerScreen> createState() => _DetailTrainerScreenState();
}

class _DetailTrainerScreenState extends State<DetailTrainerScreen> {
  PetTrainerListDetailCubit petTrainerListDetailCubit =
      PetTrainerListDetailCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    petTrainerListDetailCubit.getTrainerDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final List<String> tabs = <String>['Services', 'Review'];

    Widget backButton(BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 0, 162, 255),
            ),
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.white,
                ))),
      );
    }

    return DefaultTabController(
        length: 2,
        child: Scaffold(
          body: BlocBuilder(
            bloc: petTrainerListDetailCubit,
            builder: (context, state) {
              Data.Data? data;
              if (state is PetTrainerListDetailLoaded) {
                data = state.data.data;
                return NestedScrollView(
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return <Widget>[
                      SliverOverlapAbsorber(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                            context),
                        sliver: SliverAppBar(
                          pinned: true,
                          snap: false,
                          floating: false,
                          centerTitle: true,
                          leading: backButton(context),
                          expandedHeight: 30.h,
                          flexibleSpace: FlexibleSpaceBar(
                            collapseMode: CollapseMode.parallax,
                            background: ShaderMask(
                              shaderCallback: (Rect bounds) {
                                return const LinearGradient(
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(0, 250, 250, 250)
                                  ], // Define your gradient colors
                                  stops: [0.15, 0.1],
                                  begin:
                                      Alignment.bottomCenter, // Starting point
                                  end: Alignment.topCenter, // Ending point
                                ).createShader(bounds);
                              },
                              blendMode: BlendMode
                                  .srcATop, // Blend mode for the gradient
                              child: Image.memory(
                                base64Decode(data!.foto),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          forceElevated: innerBoxIsScrolled,
                          bottom: TabBar(
                              automaticIndicatorColorAdjustment: true,
                              unselectedLabelColor:
                                  const Color.fromARGB(255, 188, 188, 188),
                              indicatorSize: TabBarIndicatorSize.tab,
                              labelColor:
                                  const Color.fromARGB(255, 0, 162, 255),
                              indicatorColor:
                                  const Color.fromARGB(255, 72, 179, 255),
                              onTap: ((value) {}),
                              labelStyle:
                                  SizerUtil.deviceType == DeviceType.mobile
                                      ? TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.bold)
                                      : TextStyle(
                                          fontSize: 9.sp,
                                          fontWeight: FontWeight.bold),
                              tabs: tabs
                                  .map((String name) => Tab(text: name))
                                  .toList()),
                        ),
                      ),
                    ];
                  },
                  body: TabBarView(children: [
                    TabServices(data: data),
                    TabReview(
                      data: data,
                    )
                  ]),
                );
              }
              return const SpinKitWave(
                color: Color.fromARGB(255, 0, 162, 255),
                size: 50,
              );
            },
          ),
        ));
  }
}
