import 'package:clipboard/clipboard.dart';
import 'package:co_pet/cubits/user/order/order_detail_get_cubit.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/models/user/review/create_review_model.dart';
import 'package:co_pet/domain/repository/user/order/cancel_order_repository.dart';
import 'package:co_pet/domain/repository/user/review/create_review_repository.dart';
import 'package:co_pet/presentation/user/features/pet_hotel/detail_item_card/detail_item_card_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:sizer/sizer.dart';
import 'package:slide_countdown/slide_countdown.dart';

class OrderDetailPetServiceScreen extends StatefulWidget {
  final String orderId;
  const OrderDetailPetServiceScreen({super.key, required this.orderId});

  @override
  State<OrderDetailPetServiceScreen> createState() =>
      _OrderDetailPetServiceScreenState();
}

class _OrderDetailPetServiceScreenState
    extends State<OrderDetailPetServiceScreen> {
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

    orderDetailGetCubit.getOrderDetail(widget.orderId, true);
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await orderDetailGetCubit.getOrderDetail(widget.orderId, true);
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
                              customerId: userId.toString(),
                              rating: rate.toString(),
                              ulasan: _feedbackController.text);

                          reviewSuccess =
                              await CreateReviewRepository().createReview(data);
                          setState(() {
                            orderDetailGetCubit.getOrderDetail(
                                widget.orderId, true);
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

  Widget itemList(String itemName, int quantity, int itemPrice) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Text(
                itemName,
                style: TextStyle(fontSize: 10.sp),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                "${quantity.toString()}x",
                style: TextStyle(fontSize: 10.sp),
              ),
            ],
          ),
        ),
        Text(
          currencyFormatter.format(itemPrice),
          style: TextStyle(fontSize: 10.sp),
        ),
      ],
    );
  }

  Widget detailOrder(String title, String detail) {
    return Container(
      color: Colors.white,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.sp),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
                border: Border.symmetric(
                    horizontal: BorderSide(
                        width: 1, color: Color.fromARGB(255, 217, 217, 217)))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Order Detail",
                    style: TextStyle(
                        color: const Color.fromARGB(255, 159, 159, 159),
                        fontSize: 12.sp),
                  ),
                  Text(detail,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 159, 159, 159),
                          fontSize: 12.sp)),
                  const SizedBox(
                    height: 10,
                  ),
                  for (var e in orderDetailData!.data![0].orderDetail)
                    itemList(e.title!, e.quantity, 20000),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total",
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                ),
                Text(
                  currencyFormatter
                      .format(orderDetailData!.data![0].totalPrice),
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15.sp),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Detail Order",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(4.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            "Order Detail",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16.sp),
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
                                                            : () {},
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
                                                            true);
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
