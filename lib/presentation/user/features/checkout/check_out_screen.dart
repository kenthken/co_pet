library check_out;

import 'package:co_pet/domain/models/user/checkout/checkout_model.dart';
import 'package:co_pet/domain/models/user/order/create_order_dokter.dart';
import 'package:co_pet/domain/models/user/order/create_order_model.dart';
import 'package:co_pet/domain/models/user/order/create_order_trainer_model.dart';
import 'package:co_pet/domain/repository/user/order/create_order_repository.dart';
import 'package:co_pet/presentation/user/features/payment/payment_screen.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

part "detail_package.dart";
part "payment_method.dart";

class CheckoutScreen extends StatefulWidget {
  final CheckoutModel checkoutModel;
  const CheckoutScreen({super.key, required this.checkoutModel});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> myFunction(CreateOrderModel dataModel) async {
    String orderId = await CreateOrderRepository().createOrder(dataModel);
    debugPrint("order id $orderId");
    SmartDialog.dismiss();
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: ((context) => PaymentScreen(
                  orderId: orderId,
                  serviceType: widget.checkoutModel.serviceType,
                ))),
        (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Colors.white,
      ),
      body: Container(
        width: 100.w,
        height: 100.h,
        color: const Color.fromARGB(255, 242, 242, 242),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                DetailPackage(
                  checkoutModel: widget.checkoutModel,
                ),
                const SizedBox(
                  height: 10,
                ),
                const PaymentMethod(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                        onPressed: () async {
                          String? id;
                          SmartDialog.showLoading(
                            backDismiss: true,
                            builder: (context) => const SpinKitWave(
                              color: Color.fromARGB(255, 0, 162, 255),
                              size: 50,
                            ),
                          );
                          if (widget.checkoutModel.serviceType == "Grooming" ||
                              widget.checkoutModel.serviceType == "Hotel") {
                            List<OrderDetail> orderDetail = [];
                            for (var e in widget.checkoutModel.listPackage!) {
                              widget.checkoutModel.serviceType == "Grooming"
                                  ? orderDetail.add(OrderDetail(
                                      quantity: e.quantity,
                                      groomingId: e.id.toString()))
                                  : orderDetail.add(OrderDetail(
                                      quantity: e.quantity,
                                      hotelId: e.id.toString()));
                            }
                            CreateOrderModel createOrderModel =
                                CreateOrderModel(
                                    metodePembayaran: "BCA",
                                    serviceType:
                                        widget.checkoutModel.serviceType,
                                    tanggalKeluar:
                                        widget.checkoutModel.end_date_hotel ??
                                            widget.checkoutModel.grooming_date,
                                    tanggalMasuk:
                                        widget.checkoutModel.start_date_hotel ??
                                            widget.checkoutModel.grooming_date,
                                    tokoId: widget.checkoutModel.storeId,
                                    userId: widget.checkoutModel.userId,
                                    orderDetail: orderDetail);
                            debugPrint(
                                "tgl keluar ${widget.checkoutModel.end_date_hotel}");

                            id = await CreateOrderRepository()
                                .createOrder(createOrderModel);
                          } else if (widget.checkoutModel.serviceType ==
                              "dokter") {
                            CreateOrderDoctorModel createOrderDoctorModel =
                                CreateOrderDoctorModel(
                                    metodePembayaran: "BCA",
                                    userId: int.parse(
                                        await SecureStorageService()
                                            .readData("id")),
                                    dokterId: widget.checkoutModel.storeId,
                                    jamKonsultasi:
                                        widget.checkoutModel.jamKonsultasi!,
                                    tanggalKonsultasi:
                                        widget.checkoutModel.jamKonsultasi!,
                                    serviceType:
                                        widget.checkoutModel.serviceType);
                            id = await CreateOrderRepository()
                                .createOrderDoctor(createOrderDoctorModel);
                          } else if (widget.checkoutModel.serviceType ==
                              "trainer") {
                            CreateOrderTrainerModel data =
                                CreateOrderTrainerModel(
                                    metodePembayaran: "BCA",
                                    userId:
                                        int
                                            .parse(
                                                await SecureStorageService()
                                                    .readData("id")),
                                    trainerId: widget.checkoutModel.storeId,
                                    jamPertemuan: widget
                                        .checkoutModel.jamKonsultasi!,
                                    tanggalPertemuan:
                                        widget.checkoutModel.jamKonsultasi!,
                                    serviceType:
                                        widget.checkoutModel.serviceType);
                            debugPrint(
                                "service ${widget.checkoutModel.serviceType}");
                            id = await CreateOrderRepository()
                                .createOrderTrainer(data);
                          }
                          if (id!.isNotEmpty) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => PaymentScreen(
                                          orderId: id!,
                                          serviceType:
                                              widget.checkoutModel.serviceType,
                                        ))),
                                (route) => route.isFirst);
                          }
                          SmartDialog.dismiss();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 0, 162, 255),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Checkout",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13.sp),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
