library history_screen;

import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

part 'item_card_history.dart';
part 'order_display.dart';
part 'on_going_display.dart';
part 'history_display.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Number of tabs
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 242, 242, 242),
        appBar: AppBar(
          title: const Text(
            'Activity',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
              Tab(text: 'Order'),
              Tab(text: 'On Going'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [OrderDisplay(), OnGoingDisplay(), HistoryDisplay()],
        ),
      ),
    );
  }
}
