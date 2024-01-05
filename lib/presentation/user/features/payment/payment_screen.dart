import 'package:clipboard/clipboard.dart';
import 'package:co_pet/cubits/user/order/order_detail_get_cubit.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/models/user/review/create_review_model.dart';
import 'package:co_pet/domain/repository/user/order/cancel_order_repository.dart';
import 'package:co_pet/domain/repository/user/review/create_review_repository.dart';
import 'package:co_pet/presentation/user/chat/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_countdown/slide_countdown.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class PaymentScreen extends StatefulWidget {
  final String orderId;
  const PaymentScreen({super.key, required this.orderId});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  Duration defaultDuration = const Duration(seconds: 15);
  final defaultPadding =
      const EdgeInsets.symmetric(horizontal: 10, vertical: 5);
  String status = "Waiting Payment";
  String review = "";
  String virtualAccount = "";
  String title = "";
  bool loading = true;
  bool isOrderCancel = false;
  int totalPayment = 0;
  bool paymentComplete = false;
  int orderNo = 0;
  bool orderComplete = false;
  bool reviewSuccess = false;
  final currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);
  OrderDetailGetCubit orderDetailGetCubit = OrderDetailGetCubit();
  OrderDetailModel? orderDetailData;
  final TextEditingController _feedbackController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tes();
    orderDetailGetCubit.getOrderDetail(widget.orderId, false);
  }

  Future<void> tes() async {
    final d = await FirebaseChatCore.instance.rooms();
    debugPrint("d ${d.first.asStream()}");
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await orderDetailGetCubit.getOrderDetail(widget.orderId, false);
    // if failed,use refreshFailed()
    refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 3000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()

    if (mounted) setState(() {});
    refreshController.loadComplete();
  }

  void createChat(types.User otherUser, BuildContext context) async {
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    debugPrint("other data = ${room.name}");
    await navigator.push(
      MaterialPageRoute(
        builder: (context) => ChatPage(
          room: room,
        ),
      ),
    );
  }

  Widget showReview(int userId) {
    int rate = 0;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingBar.builder(
          initialRating: orderDetailData!.data![0].review != null
              ? orderDetailData!.data![0].review!.rate.toDouble()
              : 0,
          minRating: 1,
          ignoreGestures:
              orderDetailData!.data![0].review != null || reviewSuccess
                  ? true
                  : false,
          direction: Axis.horizontal,
          itemSize: 30,
          allowHalfRating: false,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(horizontal: 5.0),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            rate = rating.toInt();
          },
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2, color: const Color.fromARGB(255, 221, 221, 221))),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled:
                    orderDetailData!.data![0].review != null || reviewSuccess
                        ? false
                        : true,
                controller: _feedbackController,
                onChanged: (value) {
                  review = value;
                },
                decoration: const InputDecoration.collapsed(
                    hintText: "Write a feedback..."),
                minLines:
                    4, // any number you need (It works as the rows for the textarea)
                keyboardType: TextInputType.multiline,
                maxLines: 6,
              )),
        ),
        SizedBox(
          width: 100.w,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: orderDetailData!.data![0].review != null ||
                          reviewSuccess
                      ? null
                      : () async {
                          CreateReviewModel data = CreateReviewModel(
                              orderId: orderNo.toString(),
                              tokoId:
                                  orderDetailData!.data![0].idToko.toString(),
                              customerId: userId.toString(),
                              rating: rate.toString(),
                              ulasan: _feedbackController.text);

                          reviewSuccess =
                              await CreateReviewRepository().createReview(data);
                          setState(() {
                            orderDetailGetCubit.getOrderDetail(
                                widget.orderId, false);
                          });
                        },
                  child: Text(
                    "Submit review",
                    textAlign: TextAlign.end,
                    style: TextStyle(
                        color: orderDetailData!.data![0].review != null ||
                                reviewSuccess
                            ? Colors.grey
                            : const Color.fromARGB(255, 0, 162, 255)),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget detailPackage(String title, int quantity) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
              color: const Color.fromARGB(255, 137, 137, 137), fontSize: 10.sp),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          quantity.toString(),
          style: TextStyle(
              color: const Color.fromARGB(255, 173, 173, 173), fontSize: 10.sp),
        )
      ],
    );
  }

  Future<dynamic> showLoading() {
    return SmartDialog.showLoading(
      backDismiss: true,
      builder: (context) => const SpinKitWave(
        color: Color.fromARGB(255, 0, 162, 255),
        size: 50,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Payment",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder(
        bloc: orderDetailGetCubit,
        builder: (context, state) {
          if (state is OrderDetailGetLoaded) {
            orderDetailData = state.data;

            var orderDetail = orderDetailData!.data![0];
            _feedbackController.text = orderDetail.review != null
                ? orderDetail.review!.reviewDescription
                : "";
            status = orderDetail.orderStatus;
            virtualAccount = orderDetail.virtualNumber;
            totalPayment = orderDetail.totalPrice;
            orderNo = orderDetail.orderId;
            title = orderDetail.namaToko;
            loading = false;
            defaultDuration = Duration(
                minutes: orderDetail.time.minutes,
                seconds: orderDetail.time.seconds);
            debugPrint("status $status");
          }
          return loading
              ? const SpinKitWave(
                  color: Color.fromARGB(255, 0, 162, 255),
                  size: 50,
                )
              : Container(
                  color: const Color.fromARGB(255, 0, 162, 255),
                  width: 100.w,
                  height: 100.h,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Must Pay Within",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.timer_sharp,
                                      color: Colors.white,
                                    ),
                                    SlideCountdownSeparated(
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent),
                                      showZeroValue: true,
                                      onDone: () async {
                                        await orderDetailGetCubit
                                            .getOrderDetail(
                                                widget.orderId, false);

                                        setState(() {});
                                      },
                                      shouldShowDays: (p0) => false,
                                      shouldShowHours: (p0) => true,
                                      separator: ":",
                                      separatorStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.bold),
                                      duration: defaultDuration,
                                      padding: defaultPadding,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Status :",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                Text(status,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold))
                              ],
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(
                                      20.0), // Adjust the radius as needed
                                ),
                              ),
                              child: SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: false,
                                header: ClassicHeader(
                                    refreshingText: "",
                                    completeIcon: const Icon(
                                      Icons.check,
                                      color: Color.fromARGB(255, 0, 162, 255),
                                    ),
                                    idleIcon: Icon(
                                      Icons.arrow_downward,
                                      color: Colors.grey.shade400,
                                    ),
                                    refreshStyle: RefreshStyle.Behind,
                                    textStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 0, 162, 255)),
                                    refreshingIcon:
                                        const CircularProgressIndicator(
                                      color: Color.fromARGB(255, 0, 162, 255),
                                    )),
                                footer: const ClassicFooter(),
                                controller: refreshController,
                                onRefresh: _onRefresh,
                                onLoading: _onLoading,
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(4.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Payment Method",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                width: 20.w,
                                                height: 10.w,
                                                margin: const EdgeInsets.only(
                                                    right: 20,
                                                    top: 20,
                                                    bottom: 20),
                                                child: Image.asset(
                                                  "assets/checkOut/bca.png",
                                                  fit: BoxFit.contain,
                                                ),
                                              ),
                                              Text(
                                                "BCA Virtual Account",
                                                style:
                                                    TextStyle(fontSize: 10.sp),
                                              )
                                            ],
                                          ),
                                          Container(
                                            color: const Color.fromARGB(
                                                255, 233, 233, 233),
                                            margin: const EdgeInsets.only(
                                                bottom: 20),
                                            width: 100.w,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    virtualAccount,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17.sp),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      FlutterClipboard.copy(
                                                              virtualAccount)
                                                          .then((value) =>
                                                              Fluttertoast.showToast(
                                                                  msg:
                                                                      "Copied to clipboard",
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  textColor: Colors
                                                                      .black));
                                                    },
                                                    child: const Icon(
                                                      Icons.copy,
                                                      color: Color.fromARGB(
                                                          89, 0, 0, 0),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Total Payment",
                                                style:
                                                    TextStyle(fontSize: 12.sp),
                                              ),
                                              Text(
                                                currencyFormatter
                                                    .format(totalPayment),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: const Color.fromARGB(
                                                        255, 0, 162, 255),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Order No",
                                                style:
                                                    TextStyle(fontSize: 12.sp),
                                              ),
                                              Text(
                                                orderNo.toString(),
                                                style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: const Color.fromARGB(
                                                        255, 177, 177, 177),
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 100.w,
                                      decoration: BoxDecoration(
                                        border: const Border.symmetric(
                                            horizontal: BorderSide(
                                                width: 1,
                                                color: Color.fromARGB(
                                                    255, 211, 211, 211))),
                                        color: status != "On Progress"
                                            ? const Color.fromARGB(
                                                255, 241, 241, 241)
                                            : Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(4.w),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: 30.w,
                                                height: 20.w,
                                                child: Image.asset(
                                                  "assets/petHotel/toko.jpg",
                                                  fit: BoxFit.cover,
                                                )),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.sp),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "Detail Package",
                                                      style: TextStyle(
                                                          color: const Color
                                                              .fromARGB(255,
                                                              202, 202, 202),
                                                          fontSize: 10.sp),
                                                    ),
                                                    for (var e
                                                        in orderDetailData!
                                                            .data![0]
                                                            .orderDetail)
                                                      detailPackage(
                                                          e.title!, e.quantity)
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Container(
                                                    height: 60,
                                                    width: 60,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 10),
                                                    child: ElevatedButton(
                                                        onPressed: status !=
                                                                "On Progress"
                                                            ? null
                                                            : () {
                                                                types.User otherUser = types.User(
                                                                    id: orderDetailData!
                                                                        .data![
                                                                            0]
                                                                        .uid,
                                                                    firstName: orderDetailData!
                                                                        .data![
                                                                            0]
                                                                        .namaToko);
                                                                debugPrint(
                                                                    "tesss ${orderDetailData!.data![0].namaToko}");
                                                                createChat(
                                                                    otherUser,
                                                                    context);
                                                              },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side:
                                                                const BorderSide(
                                                                    width: 0.50,
                                                                    color: Colors
                                                                        .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7),
                                                          ),
                                                        ),
                                                        child: Icon(
                                                          Icons.chat,
                                                          color: status !=
                                                                  "On Progress"
                                                              ? Colors.grey
                                                              : const Color
                                                                  .fromARGB(255,
                                                                  0, 162, 255),
                                                        ))),
                                                Text(
                                                  "Chat",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: status != "Success"
                                                          ? Colors.grey
                                                          : const Color
                                                              .fromARGB(
                                                              255, 0, 162, 255),
                                                      fontSize: 10.sp),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10.w,
                                    ),
                                    status != "On Progress" &&
                                            status != "Completed"
                                        ? GestureDetector(
                                            onTap: isOrderCancel ||
                                                    status == "Expired" ||
                                                    status == "Cancel"
                                                ? null
                                                : () async {
                                                    SmartDialog.showLoading(
                                                      backDismiss: true,
                                                      builder: (context) =>
                                                          const SpinKitWave(
                                                        color: Color.fromARGB(
                                                            255, 0, 162, 255),
                                                        size: 50,
                                                      ),
                                                    );
                                                    isOrderCancel =
                                                        await CancelOrderRepository()
                                                            .cancelOrder(
                                                                widget.orderId);
                                                    await orderDetailGetCubit
                                                        .getOrderDetail(
                                                            widget.orderId,
                                                            false);
                                                    SmartDialog.dismiss();
                                                    setState(() {});
                                                  },
                                            child: Text(
                                              "Cancel Booking",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: isOrderCancel ||
                                                          status == "Expired" ||
                                                          status == "Cancel"
                                                      ? Colors.grey
                                                      : Colors.red,
                                                  fontWeight: FontWeight.bold),
                                            ))
                                        : Container(),
                                    status == "Completed"
                                        ? showReview(
                                            orderDetailData!.data![0].userId)
                                        : Container()
                                  ],
                                ),
                              )))
                    ],
                  ));
        },
      ),
    );
  }
}
