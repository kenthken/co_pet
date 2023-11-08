class UrlServices {
  static const String _baseUrl =
      "http://172.16.5.40233333337/api"; // cobacobi (INTERNAL)

  /* =========================================================================================================================== */
  // LOGIN
  static String get loginUrl => "$_baseUrl/auth/login";
  //REGISTER
  static String get registerUrl => "$_baseUrl/register";

  //PET HOTEL AND GROOMING
  static String get getStoreList => "$_baseUrl/list";

  static String getStoreDetail(int storeId) => "$_baseUrl/detailList/$storeId";

  static String getBookingStoreList(int storeId, String service) =>
      "$_baseUrl/getBookingProductList";

  //PET DOCTOR
  static String getPetDoctorList(String freeText) => "$_baseUrl";

  static String getDoctorListDetail(int petDoctorId) => "$_baseUrl";

  //PET TRAINER
  static String getTrainerList(String freeText) => "$_baseUrl";

  static String getTrainerListDetail(int trainerId) => "$_baseUrl";
}
