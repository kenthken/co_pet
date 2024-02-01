import 'dart:convert';
import 'dart:io';

import 'package:co_pet/domain/models/pet-service/dokter/dokter_model.dart';
import 'package:co_pet/domain/repository/pet-service/register/register_dokter_repository.dart';
import 'package:co_pet/presentation/pet-service/doctor/manage_services/doctor_manage_services_screen.dart';
import 'package:co_pet/presentation/pet-service/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class PetDoctorRegistrationScreen extends StatefulWidget {
  final String penyediaId;
  const PetDoctorRegistrationScreen({super.key, required this.penyediaId});

  @override
  State<PetDoctorRegistrationScreen> createState() =>
      _PetDoctorRegistrationScreenState();
}

class _PetDoctorRegistrationScreenState
    extends State<PetDoctorRegistrationScreen> {
  TextEditingController _name = TextEditingController(),
      _str = TextEditingController(),
      _education = TextEditingController(),
      _placement = TextEditingController(),
      _price = TextEditingController(),
      _experience = TextEditingController();
  bool nameValidate = false,
      strValidate = false,
      educationValidate = false,
      placementValidate = false,
      priceValidate = false,
      experienceValidate = false,
      photoValidate = false;
  String nameErrorM = "",
      strErrorM = "",
      educationErrorM = "",
      placementErrorM = "",
      priceErrorM = "",
      experienceErrorM = "",
      photoErrorM = "";
  XFile? selectedImage;

  Widget textField(String title, TextEditingController controller,
      IconData icon, bool validate, String errorMessage) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 198, 198,
                    198)), // Set the desired underline color here
          ),
          labelText: title,
          errorText: validate ? errorMessage : null,
          suffixIcon: Icon(
            icon,
            color: const Color.fromARGB(255, 141, 141, 141),
            size: 16.sp,
          ),
          labelStyle: TextStyle(
              color: const Color.fromARGB(255, 154, 154, 154), fontSize: 10.sp),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Doctor Registration"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              textField("Name", _name, Icons.person, nameValidate, nameErrorM),
              textField(
                  "STR No", _str, Icons.edit_document, strValidate, strErrorM),
              textField("Latest University", _education,
                  Icons.menu_book_outlined, educationValidate, educationErrorM),
              textField("Professional Placement Address", _placement,
                  Icons.location_on, placementValidate, placementErrorM),
              textField("Experience (ex : 4 Years)", _experience,
                  Icons.account_balance, experienceValidate, experienceErrorM),
              Row(
                children: [
                  Text(
                    "Profile Image",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 154, 154, 154),
                        fontSize: 10.sp),
                  ),
                  photoValidate
                      ? Text(
                          "   $photoErrorM",
                          style: TextStyle(color: Colors.red, fontSize: 9.sp),
                        )
                      : const SizedBox()
                ],
              ),
              IconButton(
                  onPressed: () async {
                    final result = await ImagePicker().pickImage(
                      imageQuality: 70,
                      maxWidth: 1440,
                      source: ImageSource.gallery,
                    );

                    setState(() {
                      selectedImage = result;
                    });
                  },
                  icon: Icon(Icons.file_upload_outlined)),
              selectedImage != null
                  ? SizedBox(
                      height: 40.w,
                      width: 100.w,
                      child: Image.file(File(selectedImage!.path)))
                  : const SizedBox(),
              Row(
                children: [
                  Text(
                    "Session Fee",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 154, 154, 154),
                        fontSize: 10.sp),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Row(
                  children: [
                    Text(
                      "Rp ",
                      style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    ),
                    Expanded(
                      child: Container(
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 0.5, color: Colors.grey))),
                          child: TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                errorText: priceValidate ? priceErrorM : null),
                            controller: _price,
                            keyboardType: TextInputType.number,
                          )),
                    ),
                    Text(
                      "/30 Minutes",
                      style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    )
                  ],
                ),
              ),
              const Row(
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: Colors.grey,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Registration will take up 1x24 working hours to verified your data",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 0, 162, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () async {
                    nameValidate = _name.text.isEmpty;
                    strValidate = _str.text.isEmpty;
                    educationValidate = _education.text.isEmpty;
                    placementValidate = _placement.text.isEmpty;
                    experienceValidate = _experience.text.isEmpty;
                    photoValidate = selectedImage == null;
                    priceValidate = _price.text.isEmpty;
                    if (nameValidate) {
                      nameErrorM = "Please input name";
                    } else if (!nameValidate && _name.text.length < 5) {
                      nameValidate = true;
                      nameErrorM = "Input valid name";
                    }

                    if (placementValidate) {
                      placementErrorM = "Input professional placement address";
                    } else if (!placementValidate &&
                        _placement.text.length < 10) {
                      placementValidate = true;
                      placementErrorM =
                          "Input detail professional placement address";
                    }

                    if (strValidate) {
                      strErrorM = "Input valid STR No";
                    }

                    if (educationValidate) {
                      educationErrorM = "Input latest University education";
                    }

                    if (experienceValidate) {
                      experienceErrorM = "Input years or month of experience";
                    }

                    if (photoValidate) {
                      photoErrorM = "Upload profile photo";
                    }

                    if (priceValidate) {
                      priceErrorM = "Must input price";
                    } else if (!priceValidate &&
                        int.parse(_price.text) < 10000) {
                      priceValidate = true;
                      priceErrorM = "Minimum price Rp 10.000";
                    }

                    if (!nameValidate &&
                        !strValidate &&
                        !educationValidate &&
                        !placementValidate &&
                        !experienceValidate &&
                        !photoValidate &&
                        !priceValidate &&
                        int.parse(_price.text) > 10000) {
                      List<int> imageBytes =
                          File(selectedImage!.path).readAsBytesSync();
                      SmartDialog.showLoading(
                        backDismiss: true,
                        builder: (context) => const SpinKitWave(
                          color: Color.fromARGB(255, 0, 162, 255),
                          size: 50,
                        ),
                      );
                      DoctorRegisterModel data = DoctorRegisterModel(
                          penyediaId: widget.penyediaId,
                          nama: _name.text,
                          spesialis: "",
                          foto: base64Encode(imageBytes),
                          pengalaman: _experience.text,
                          harga: int.parse(_price.text),
                          alumni: _education.text,
                          lokasiPraktek: _placement.text,
                          noStr: _str.text);

                      final registerSuccess =
                          await DokterRegisterRepository().registerDokter(data);

                      if (registerSuccess) {
                        Future.delayed(Duration.zero, () {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const HomePetServiceScreen()),
                              (route) => false);
                        });
                      }

                      SmartDialog.dismiss();
                      setState(() {});
                    }
                  },
                  child: Text("Register",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold)))
            ],
          ),
        ),
      ),
    );
  }
}
