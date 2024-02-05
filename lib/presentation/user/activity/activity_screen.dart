library history_screen;

import 'package:co_pet/cubits/user/activity/history_list_cubit.dart';
import 'package:co_pet/cubits/user/activity/on_going_list_cubit.dart';
import 'package:co_pet/cubits/user/activity/order_list_cubit.dart';
import 'package:co_pet/domain/models/user/activity/order_list_model.dart'
    as order_model;
import 'package:co_pet/presentation/pet-service/hotel_grooming/activity/detail_order_screen.dart';
import 'package:co_pet/presentation/user/features/payment/payment_screen.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

part 'item_card_history.dart';
part 'order_display.dart';
part 'on_going_display.dart';
part 'history_display.dart';

class HistoryScreen extends StatefulWidget {
  final String? user;
  const HistoryScreen({super.key, required this.user});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

OrderListCubit orderListCubit = OrderListCubit();
OnGoingListCubit onGoingListCubit = OnGoingListCubit();
HistoryListCubit historyListCubit = HistoryListCubit();

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("userrrr activity ${widget.user}");
    getUserActivity(widget.user);
  }

  void getUserActivity(String? user) {
    orderListCubit.getOrderList(user);
    onGoingListCubit.getOnGoingList(user);
    historyListCubit.getHistoryList(user);
  }

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
          actions: [
            IconButton(
                onPressed: () {
                  getUserActivity(widget.user);
                },
                icon: Icon(Icons.refresh_outlined))
          ],
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
