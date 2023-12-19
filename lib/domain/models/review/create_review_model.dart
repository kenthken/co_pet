// To parse this JSON data, do
//
//     final CreateReviewModel = CreateReviewModelFromJson(jsonString);

import 'dart:convert';

CreateReviewModel createReviewModelFromJson(String str) => CreateReviewModel.fromJson(json.decode(str));

String createReviewModelToJson(CreateReviewModel data) => json.encode(data.toJson());

class CreateReviewModel {
    String orderId;
    String customerId;
    String rating;
    String ulasan;

    CreateReviewModel({
        required this.orderId,
        required this.customerId,
        required this.rating,
        required this.ulasan,
    });

    factory CreateReviewModel.fromJson(Map<String, dynamic> json) => CreateReviewModel(
        orderId: json["order_id"],
        customerId: json["customer_id"],
        rating: json["rating"],
        ulasan: json["ulasan"],
    );

    Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "customer_id": customerId,
        "rating": rating,
        "ulasan": ulasan,
    };
}
