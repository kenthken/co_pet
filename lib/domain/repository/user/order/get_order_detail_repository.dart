import 'package:co_pet/domain/api_service/api_service.dart';
import 'package:co_pet/domain/models/user/order/order_detail_get_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:co_pet/utils/url_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GetOrderDetailRepository {
  final Dio dio = Dio();

  Future<OrderDetailModel> getOrderDetail(String orderId) async {
    String message = "Please try again later";
    final userId = await UserLoginRepository().getUserId();
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);

    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderDetail(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint("getOderDetail() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print(" getOderDetail() error ${e.toString()}");

      throw Exception();
    }

    return responseOrderDetail;
  }

  Future<OrderDetailModel> getOrderDoctorDetail(String orderId) async {
    String message = "Please try again later";
    final userId = await UserLoginRepository().getUserId();
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);

    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderDetailDoctor(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint("getOrderDoctorDetail() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print(" getOrderDoctorDetail() error ${e.toString()}");

      throw Exception();
    }

    return responseOrderDetail;
  }

  Future<OrderDetailModel> getOrderTrainerDetail(String orderId) async {
    String message = "Please try again later";
    final userId = await UserLoginRepository().getUserId();
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);

    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderDetailTrainer(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint("getOrderTrainerDetail() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print(" getOrderTrainerDetail() error ${e.toString()}");

      throw Exception();
    }

    return responseOrderDetail;
  }

  Future<OrderDetailModel> getOrderDetailPetService(String orderId) async {
    String message = "Please try again later";
    final userId = await UserLoginRepository().getUserId();
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);

    try {
      Response response =
          await ApiService().getApiData(UrlServices.getOrderDetailPetService(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint("getOrderDetailPetService() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(" getOrderDetailPetService() error ${e.toString()}");
      throw Exception(" getOrderDetailPetService() error ${e.toString()}");
    }

    return responseOrderDetail;
  }

  Future<OrderDetailModel> getOrderDetailPetServiceDoctor(
      String orderId) async {
    String message = "Please try again later";
    final userId = await SecureStorageService().readData("doctor_id");
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);

    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getOrderDetailDoctorPetService(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint(
            "getOrderDetailPetServiceDoctor() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(" getOrderDetailPetServiceDoctor() error ${e.toString()}");
      throw Exception(
          " getOrderDetailPetServiceDoctor() error ${e.toString()}");
    }

    return responseOrderDetail;
  }

  Future<OrderDetailModel> getOrderDetailPetServiceTrainer(
      String orderId) async {
    String message = "Please try again later";
    final userId = await SecureStorageService().readData("trainer_id");
    OrderDetailModel responseOrderDetail =
        OrderDetailModel(message: message, responseCode: 404, data: null);
    debugPrint("userID $userId $orderId");
    try {
      Response response = await ApiService()
          .getApiData(UrlServices.getOrderDetailTrainerPetService(
        userId!,
        orderId,
      ));

      if (response.statusCode == 200) {
        debugPrint(
            "getOrderDetailTrainerPetService() Success = ${response.data}");
        return OrderDetailModel.fromJson(response.data);
      }
    } catch (e) {
      debugPrint(" getOrderDetailTrainerPetService() error ${e.toString()}");
      throw Exception(
          " getOrderDetailTrainerPetService() error ${e.toString()}");
    }

    return responseOrderDetail;
  }
}
