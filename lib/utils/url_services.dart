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
  static String getPetDoctorList(String freeText) => "$_baseUrl";

  static String getDoctorListDetail(int petDoctorId) => "$_baseUrl";

  //PET TRAINER
  static String getTrainerList(String freeText) => "$_baseUrl";

  static String getTrainerListDetail(int trainerId) => "$_baseUrl";

  //SCHEDULE
  static String get getScheduleList => "$_baseUrl";

  //ACTIVITY
  static String get getOrderList => "$_baseUrl";

  static String get getOnGoingList => "$_baseUrl";

  static String get getHistoryList => "$_baseUrl";
}
