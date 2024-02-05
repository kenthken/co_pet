library manage_pet_service;

import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'request_tab.dart';
part 'user_pet_service_tab.dart';

class ManagePetServiceScreen extends StatefulWidget {
  const ManagePetServiceScreen({super.key});

  @override
  State<ManagePetServiceScreen> createState() => _ManagePetServiceScreenState();
}

class _ManagePetServiceScreenState extends State<ManagePetServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Pet Service"),
        bottom: TabBar(
          automaticIndicatorColorAdjustment: true,
          unselectedLabelColor: const Color.fromARGB(255, 188, 188, 188),
          unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
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
    );
  }
}
