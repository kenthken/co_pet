library history_screen;

import 'package:co_pet/presentation/features/payment/payment_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
        backgroundColor: Color.fromARGB(255, 242, 242, 242),
        appBar: AppBar(
          title: Text(
            'Activity',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            automaticIndicatorColorAdjustment: true,
            unselectedLabelColor: Color.fromARGB(255, 188, 188, 188),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Color.fromARGB(255, 0, 162, 255),
            indicatorColor: const Color.fromARGB(255, 72, 179, 255),
            onTap: ((value) {}),
            labelStyle: SizerUtil.deviceType == DeviceType.mobile
                ? TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold)
                : TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold),
            tabs: [
              Tab(text: 'Order'),
              Tab(text: 'On Going'),
              Tab(text: 'History'),
            ],
          ),
        ),
        body: TabBarView(
          children: [OrderDisplay(), OnGoingDisplay(), HistoryDisplay()],
        ),
      ),
    );
  }
}
