class UrlServices {
  static const String _baseUrl =
      "https://copet-production.up.railway.app"; // cobacobi (INTERNAL)

  /* =========================================================================================================================== */
  // LOGIN
  static String get loginUrl => "$_baseUrl/auth/login";
  //REGISTER
  static String get registerUrl => "$_baseUrl/auth/register";

  //PET HOTEL AND GROOMING
  static String getStoreList(String search) =>
      "$_baseUrl/toko/toko-card/$search";

  static String getStoreDetail(int storeId) =>
      "$_baseUrl/toko/toko-card-detail/$storeId";

  static String getPackageStoreList(int storeId, String service) =>
      "$_baseUrl/getBookingProductList";

  //PET DOCTOR
  static String getPetDoctorList(String freeText) => _baseUrl;

  static String getDoctorListDetail(int petDoctorId) => _baseUrl;

  //PET TRAINER
  static String getTrainerList(String freeText) => _baseUrl;

  static String getTrainerListDetail(int trainerId) => _baseUrl;

  //SCHEDULE
  static String get getScheduleList => _baseUrl;

  //ACTIVITY
  static String get getOrderList =>
      "$_baseUrl/order/getOrderStatusWaitingPayment";

  static String get getOnGoingList =>
      "$_baseUrl/order/getOrderStatusOnProgress";

  static String get getHistoryList =>
      "$_baseUrl/order/getOrderStatusCompleteExpireCancel";

  //ORDER
  static String get createOrder => "$_baseUrl/order/create";

  static String getOrderDetail(int orderId) => "$_baseUrl/order/$orderId";

  static String cancelOrder(int orderId) =>
      "$_baseUrl/order/set-order-to-expired/$orderId";

  //REVIEW
  static String get createReview => "$_baseUrl/review/create";
}
