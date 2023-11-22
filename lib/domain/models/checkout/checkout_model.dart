
class CheckoutModel {
  int storeId;
  int userId;
  String title;
  String detailPackage;
  List<ListPackage> listPackage;
  String serviceType;
  int total;
  DateTime? start_date_hotel;
  DateTime? end_date_hotel;
  DateTime? grooming_date;
  CheckoutModel(
      {required this.storeId,
      required this.userId,
      required this.title,
      required this.detailPackage,
      required this.listPackage,
      required this.serviceType,
      required this.total,
      required this.start_date_hotel,
      required this.end_date_hotel,
      required this.grooming_date});
}

class ListPackage {
  int id;
  String packageName;
  int price;
  int quantity;

  ListPackage(this.id, this.packageName, this.price, this.quantity);
}
