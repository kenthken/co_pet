class CheckoutModel {
  int storeId;
  int userId;
  String title;
  String detailPackage;
  List<ListPackage>? listPackage;
  String serviceType;
  int total;
  DateTime? start_date_hotel;
  DateTime? end_date_hotel;
  DateTime? grooming_date;
  DateTime? jamKonsultasi;
  CheckoutModel(
      {required this.storeId,
      required this.userId,
      required this.title,
      required this.detailPackage,
      this.listPackage,
      required this.serviceType,
      required this.total,
       this.start_date_hotel,
      this.jamKonsultasi,
       this.end_date_hotel,
       this.grooming_date});
}

class ListPackage {
  int id;
  String packageName;
  int price;
  int quantity;

  ListPackage(this.id, this.packageName, this.price, this.quantity);
}
