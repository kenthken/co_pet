library manage_pet_service;

import 'dart:convert';

import 'package:co_pet/cubits/user/admin/request_list_cubit.dart';
import 'package:co_pet/cubits/user/admin/user_pet_service_list_cubit.dart';
import 'package:co_pet/domain/models/pet-service/admin/pet_service_model.dart'
    as DataPetService;
import 'package:co_pet/domain/models/pet-service/admin/user_pet_service_model.dart'
    as DataUserPetService;
import 'package:co_pet/domain/repository/pet-service/admin/admin_repository.dart';
import 'package:co_pet/presentation/pet-service/doctor/manage_services/doctor_manage_services_screen.dart';
import 'package:co_pet/presentation/pet-service/hotel_grooming/manage_services/hotel_grooming_manage_services_screen.dart';
import 'package:co_pet/presentation/pet-service/trainer/manage_services/trainer_manage_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

part 'request_tab.dart';
part 'user_pet_service_tab.dart';

class ManagePetServiceScreen extends StatefulWidget {
  const ManagePetServiceScreen({super.key});

  @override
  State<ManagePetServiceScreen> createState() => _ManagePetServiceScreenState();
}

RequestListCubit requestListCubit = RequestListCubit();
UserPetServiceListCubit userPetServiceListCubit = UserPetServiceListCubit();

class _ManagePetServiceScreenState extends State<ManagePetServiceScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestListCubit.getRequestList();
    userPetServiceListCubit.getUserPetServiceList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Manage Pet Service"),
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            unselectedLabelColor: const Color.fromARGB(255, 188, 188, 188),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.normal),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: const Color.fromARGB(255, 0, 162, 255),
            indicatorColor: const Color.fromARGB(255, 72, 179, 255),
            onTap: ((value) {}),
            labelStyle: SizerUtil.deviceType == DeviceType.mobile
                ? TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
            tabs: const [
              Tab(text: 'Request'),
              Tab(text: 'User Pet Service'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [RequestTab(), UserPetServiceTab()],
        ),
      ),
    );
  }
}
