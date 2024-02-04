// To parse this JSON data, do
//
//     final CreateReviewModel = CreateReviewModelFromJson(jsonString);

import 'dart:convert';

String createReviewTokoModelToJson(CreateReviewModel data) =>
    json.encode(data.toJson());

String createReviewDokterModelToJson(CreateReviewModel data) =>
    json.encode(data.toJsonDokter());

String createReviewTrainerModelToJson(CreateReviewModel data) =>
    json.encode(data.toJsonTrainer());

class CreateReviewModel {
  String serviceType;
  String orderId;
  String tokoId;
  String customerId;
  String rating;
  String ulasan;

  CreateReviewModel({
    required this.serviceType,
    required this.orderId,
    required this.tokoId,
    required this.customerId,
    required this.rating,
    required this.ulasan,
  });

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "toko_id": tokoId,
        "customer_id": customerId,
        "rating": rating,
        "ulasan": ulasan,
      };

  Map<String, dynamic> toJsonDokter() => {
        "order_id": orderId,
        "dokter_id": tokoId,
        "customer_id": customerId,
        "rating": rating,
        "ulasan": ulasan,
      };

  Map<String, dynamic> toJsonTrainer() => {
        "order_id": orderId,
        "trainer_id": tokoId,
        "customer_id": customerId,
        "rating": rating,
        "ulasan": ulasan,
      };
}
