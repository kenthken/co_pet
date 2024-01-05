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

  static String getStoreDetail(String storeId) =>
      "$_baseUrl/toko/toko-card-detail/$storeId";

  static String getPackageStoreList(String storeId, String service) =>
      "$_baseUrl/getBookingProductList";

  //PET DOCTOR
  static String getPetDoctorList(String freeText) => _baseUrl;

  static String getDoctorListDetail(String petDoctorId) => _baseUrl;

  //PET TRAINER
  static String getTrainerList(String freeText) => _baseUrl;

  static String getTrainerListDetail(String trainerId) => _baseUrl;

  //SCHEDULE
  static String getScheduleList(int userId) =>
      "$_baseUrl/schedule/getListActivity/$userId";

  static String createSchedule(int userId) =>
      "$_baseUrl/schedule/createActivity/$userId";

  static String updateSchedule(int scheduleId) =>
      "$_baseUrl/schedule/updateActivity/$scheduleId";

  static String deleteSchedule(int scheduleId) =>
      "$_baseUrl/schedule/deleteActivity/$scheduleId";

  //ACTIVITY
  static String getOrderList(String userId) =>
      "$_baseUrl/order/$userId/getOrderStatusWaitingPayment";

  static String getOnGoingList(String userId) =>
      "$_baseUrl/order/$userId/getOrderStatusOnProgress";

  static String getHistoryList(String userId) =>
      "$_baseUrl/order/$userId/getOrderStatusCompleteExpireCancel";

  //ORDER
  static String get createOrder => "$_baseUrl/order/create";

  static String getOrderDetail(String userId, String orderId) =>
      "$_baseUrl/order/$userId/$orderId";

  static String cancelOrder(String orderId) =>
      "$_baseUrl/order/set-order-to-expired/$orderId";

  //REVIEW
  static String get createReview => "$_baseUrl/review/create";

/////////////////////////////////////////////////////////////////////

  // PET-SERVICES

  //--auth
  static String get registerPetService => "$_baseUrl/penyedia-jasa/register";

  static String get loginPetService => "$_baseUrl/auth/login-penyedia-jasa";

  //--toko
  static String get registerToko => "$_baseUrl/toko/register";

  static String getStoreDetailPetService(String penyediaId) =>
      "$_baseUrl/toko/detail-toko/$penyediaId";

  static String get registerHotel => "$_baseUrl/hotel/register";

  static String get registerGrooming => "$_baseUrl/grooming/register";

  static String getOrderTokoList(String penyediaId) =>
      "$_baseUrl/order/$penyediaId/getOrderStatusWaitingPaymentPenyedia";

  static String getOnGoingTokoList(String penyediaId) =>
      "$_baseUrl/order/$penyediaId/getOrderStatusOnProgressPenyedia";

  static String getHistoryTokoList(String penyediaId) =>
      "$_baseUrl/order/$penyediaId/getOrderStatusCompleteExpireCancelPenyedia";

  // PET SERVICE
  static String getOrderDetailPetService(String penyediaId, String orderId) =>
      "$_baseUrl/order/order-penyedia/$penyediaId/$orderId";

  static String setOrderComplete(String orderId) =>
      "$_baseUrl/order/setOrderToCompleted/$orderId";
}
