import 'package:co_pet/cubits/user/chat/chat_cubit.dart';
import 'package:co_pet/cubits/user/order/order_detail_get_cubit.dart';
import 'package:co_pet/domain/models/user/chat/chat_model.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/models/user/review/create_review_model.dart';
import 'package:co_pet/domain/repository/pet-service/set_order_to_complete_repository.dart';
import 'package:co_pet/domain/repository/user/chat/chat_repository.dart';
import 'package:co_pet/domain/repository/user/review/create_review_repository.dart';
import 'package:co_pet/presentation/user/chat/chat.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
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
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class OrderDetailPetServiceScreen extends StatefulWidget {
  final String orderId;
  final String serviceType;

  const OrderDetailPetServiceScreen(
      {super.key, required this.orderId, required this.serviceType});

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
  String penyediaId = "";
  String? roomId;
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
  ChatCubit chatCubit = ChatCubit();
  OrderDetailModel? orderDetailData;
  final TextEditingController _feedbackController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateCubit();
    chatCubit.getChat(widget.orderId);
    getPenyediaId();
  }

  void updateCubit() async {
    if (widget.serviceType.toLowerCase() == "pet hotel" ||
        widget.serviceType.toLowerCase() == "pet grooming" ||
        widget.serviceType.toLowerCase() == "hotel" ||
        widget.serviceType.toLowerCase() == "grooming") {
      await orderDetailGetCubit.getOrderDetail(widget.orderId, true);
    } else if (widget.serviceType.toLowerCase() == "dokter") {
      await orderDetailGetCubit.getOrderDoctorDetail(widget.orderId, true);
    } else if (widget.serviceType.toLowerCase() == "trainer") {
      await orderDetailGetCubit.getOrderTrainerDetail(widget.orderId, true);
    }
  }

  void getPenyediaId() async {
    penyediaId = await SecureStorageService().readData("id");
    setState(() {});
  }

  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    updateCubit();
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
    debugPrint("other user ${otherUser.id}");
    final navigator = Navigator.of(context);
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    roomId = room.id;
    StartChatModel data =
        StartChatModel(roomId: room.id, orderId: widget.orderId);
    final startChat = await ChatRepository().startChat(data);
    if (startChat) {
      await navigator.push(
        MaterialPageRoute(
          builder: (context) => ChatPage(
            room: room,
          ),
        ),
      );
    } else {
      Fluttertoast.showToast(
          msg: "Please try again later",
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
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
                              serviceType:
                                  orderDetailData!.data![0].serviceType,
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

  Widget showDetailPackage() {
    String? package =
        orderDetailData!.data![0].serviceType.toLowerCase() == "dokter"
            ? "30 Minute Session"
            : "Pet Training Session";

    if (orderDetailData!.data![0].orderDetail != null) {
      for (var e in orderDetailData!.data![0].orderDetail!) {
        itemList(e.title!, e.quantity, e.price!);
      }
    }

    return itemList(package, 1, orderDetailData!.data![0].totalPrice);
  }

  Widget detailOrder() {
    String detail = "";

    String formattedDateFrom =
        DateFormat('d/M/yyyy').format(orderDetailData!.data![0].from!);
    String formattedDateTo =
        DateFormat('d/M/yyyy').format(orderDetailData!.data![0].to!);
    switch (orderDetailData!.data![0].serviceType) {
      case "Hotel":
        Duration difference = orderDetailData!.data![0].to!
            .difference(orderDetailData!.data![0].from!);
        detail =
            "$formattedDateFrom - $formattedDateTo | ${difference.inDays == 0 ? 1 : difference.inDays} Days";
        break;
      case "Grooming":
        detail = "Grooming | $formattedDateTo";
        break;
      default:
    }
    return Container(
      color: Colors.white,
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              orderDetailData!.data![0].namaToko,
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
                  showDetailPackage()
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
          debugPrint("state $state");
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  "Order No",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 13.sp),
                                ),
                                Text(orderNo.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
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
                                          detailOrder(),
                                          const SizedBox(
                                            height: 10,
                                          ),
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
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .account_circle_rounded,
                                                      color: Colors.grey,
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      title,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12.sp),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                BlocBuilder(
                                                  bloc: chatCubit,
                                                  builder: (context, state) {
                                                    ChatModel? chat;
                                                    if (state is ChatLoaded) {
                                                      chat = state.data;
                                                      roomId = chat.data.roomId;
                                                    }
                                                    return Container(
                                                        height: 40,
                                                        width: 40,
                                                        margin: const EdgeInsets
                                                            .only(bottom: 10),
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
                                                                            .data![0]
                                                                            .namaToko);

                                                                    createChat(
                                                                        otherUser,
                                                                        context);
                                                                  },
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(0),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side: const BorderSide(
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
                                                                      .fromARGB(
                                                                      255,
                                                                      0,
                                                                      162,
                                                                      255),
                                                            )));
                                                  },
                                                ),
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
                                    orderDetailData!.data![0].orderStatus ==
                                            "On Progress"
                                        ? Padding(
                                            padding: EdgeInsets.all(4.w),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      final setOrderToCompleteSuccess =
                                                          await SetOrderToCompleteRepository()
                                                              .setOrderToComplete(
                                                                  orderDetailData!
                                                                      .data![0]
                                                                      .orderId
                                                                      .toString());
                                                      setState(() {
                                                        if (setOrderToCompleteSuccess) {
                                                          FirebaseChatCore
                                                              .instance
                                                              .deleteRoom(
                                                                  roomId!);
                                                          updateCubit();
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please try again later",
                                                              backgroundColor:
                                                                  Colors.white,
                                                              textColor:
                                                                  Colors.black);
                                                        }
                                                      });
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                          const Color.fromARGB(
                                                              255, 0, 162, 255),
                                                      elevation: 2,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      "Complete",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )),
                                                const Text("Order Complete?"),
                                              ],
                                            ),
                                          )
                                        : Container(),
                                    orderDetailData!.data![0].orderStatus ==
                                            "Waiting Confirmation"
                                        ? Column(
                                            children: [
                                              const Text("Accept Order?"),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {},
                                                      icon: const Icon(
                                                        Icons
                                                            .do_not_disturb_sharp,
                                                        color: Colors.grey,
                                                      )),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  IconButton(
                                                      onPressed: () async {
                                                        SmartDialog.showLoading(
                                                          backDismiss: true,
                                                          builder: (context) =>
                                                              const SpinKitWave(
                                                            color:
                                                                Color.fromARGB(
                                                                    255,
                                                                    0,
                                                                    162,
                                                                    255),
                                                            size: 50,
                                                          ),
                                                        );
                                                        final confirmSuccess =
                                                            await SetOrderToCompleteRepository()
                                                                .confirmOrder(
                                                                    penyediaId,
                                                                    widget
                                                                        .orderId);
                                                        if (confirmSuccess) {
                                                          updateCubit();
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Confirm Success",
                                                              backgroundColor:
                                                                  Colors.white,
                                                              textColor:
                                                                  Colors.black);
                                                        } else {
                                                          Fluttertoast.showToast(
                                                              msg:
                                                                  "Please try again later",
                                                              backgroundColor:
                                                                  Colors.white,
                                                              textColor:
                                                                  Colors.black);
                                                        }
                                                        SmartDialog.dismiss();
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .green),
                                                      ),
                                                      icon: const Icon(
                                                        Icons.done,
                                                        color: Colors.white,
                                                      ))
                                                ],
                                              )
                                            ],
                                          )
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
