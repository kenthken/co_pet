library detail_doctor;

import 'dart:convert';

import 'package:co_pet/cubits/user/pet_doctor/pet_doctor_list_cubit.dart';
import 'package:co_pet/cubits/user/pet_doctor/pet_doctor_list_detail_cubit.dart';
import 'package:co_pet/domain/models/pet-service/dokter/dokter_detail_model.dart';
import 'package:co_pet/domain/models/user/checkout/checkout_model.dart';
import 'package:co_pet/domain/models/user/pet_doctor/pet_doctor_list_detail_model.dart';
import 'package:co_pet/presentation/user/features/checkout/check_out_screen.dart';
import 'package:co_pet/presentation/user/features/pet_hotel/detail_item_card/detail_item_card_screen.dart';

import 'package:co_pet/utils/currency_formarter.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:sizer/sizer.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

part 'tab_review.dart';
part 'tab_services.dart';

class DetailDoctorScreen extends StatefulWidget {
  final int doctorId;
  const DetailDoctorScreen({super.key, required this.doctorId});

  @override
  State<DetailDoctorScreen> createState() => _DetailDoctorScreenState();
}

class _DetailDoctorScreenState extends State<DetailDoctorScreen> {
  PetDoctorListDetailCubit petDoctorListDetailCubit =
      PetDoctorListDetailCubit();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeDateFormatting('ar', '').then((value) => null);
    initializeDateFormatting('en', '').then((value) => null);
    petDoctorListDetailCubit.getDoctorListDetail(widget.doctorId.toString());
  }

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
            bloc: petDoctorListDetailCubit,
            builder: (context, state) {
              DoctorDetailModel? data;
              debugPrint("stae $state");
              if (state is PetDoctorListDetailLoaded) {
                data = state.data;
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
                                base64Decode(data!.data.foto),
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
                  body: TabBarView(
                      children: [TabServices(data: data!), TabReview()]),
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
