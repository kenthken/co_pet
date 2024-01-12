import 'dart:io';

import 'package:co_pet/presentation/pet-service/trainer/manage_services/trainer_manage_service_screen.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class PetTrainerRegistrationScreen extends StatefulWidget {
  const PetTrainerRegistrationScreen({super.key});

  @override
  State<PetTrainerRegistrationScreen> createState() =>
      _PetTrainerRegistrationScreenState();
}

class _PetTrainerRegistrationScreenState
    extends State<PetTrainerRegistrationScreen> {
  TextEditingController _name = TextEditingController(),
      _experience = TextEditingController(),
      _address = TextEditingController(),
      _education = TextEditingController(),
      _price = TextEditingController(),
      _description = TextEditingController();
  bool nameValidate = false,
      experienceValidate = false,
      addressValidate = false,
      educationValidate = false,
      priceValidate = false,
      photoValidate = false,
      descriptionValidate = false;
  String nameErrorM = "",
      experienceErrorM = "",
      addressErrorM = "",
      educationErrorM = "",
      priceErrorM = "",
      photoErrorM = "",
      descriptionErrorM = "";

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
        title: Text("Trainer Registration"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              textField("Name", _name, Icons.person, nameValidate, nameErrorM),
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
              textField("Experience (ex: 3 years)", _experience,
                  Icons.account_balance, experienceValidate, experienceErrorM),
              textField("Address", _address, Icons.location_on, addressValidate,
                  addressErrorM),
              textField("Education", _education, Icons.menu_book_rounded,
                  educationValidate, educationErrorM),
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
                      "/ Sessions",
                      style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    "Specialize Description",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: const Color.fromARGB(255, 154, 154, 154),
                        fontSize: 10.sp),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(bottom: 30, top: 10),
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 2,
                        color: const Color.fromARGB(255, 221, 221, 221))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _description,
                    onChanged: (value) {},

                    decoration: InputDecoration(
                        hintText:
                            "Write a Description for your specialize or experienced as a pet trainer",
                        hintStyle:
                            TextStyle(color: Colors.grey, fontSize: 10.sp),
                        border: InputBorder.none,
                        errorText:
                            descriptionValidate ? descriptionErrorM : null),

                    minLines:
                        4, // any number you need (It works as the rows for the textarea)
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                  ),
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
                  ),
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
                    setState(() {
                      // nameValidate = _name.text.isEmpty;
                      // educationValidate = _education.text.isEmpty;
                      // experienceValidate = _experience.text.isEmpty;
                      // photoValidate = selectedImage == null;
                      // priceValidate = _price.text.isEmpty;
                      // addressValidate = _address.text.isEmpty;
                      // if (nameValidate) {
                      //   nameErrorM = "Input name";
                      // } else if (!nameValidate && _name.text.length < 5) {
                      //   nameValidate = true;
                      //   nameErrorM = "Store name must be at least 5 characters";
                      // }

                      // if (addressValidate) {
                      //   addressErrorM = "Input store address";
                      // } else if (!addressValidate &&
                      //     _address.text.length < 10) {
                      //   addressValidate = true;
                      //   addressErrorM = "Input detail store address";
                      // }

                      // if (educationValidate) {
                      //   educationErrorM = "Input latest University education";
                      // }

                      // if (experienceValidate) {
                      //   experienceErrorM = "Input years or month of experience";
                      // }

                      // if (photoValidate) {
                      //   photoErrorM = "Upload profile photo";
                      // }

                      // if (priceValidate) {
                      //   priceErrorM = "Must input price";
                      // } else if (!priceValidate &&
                      //     int.parse(_price.text) < 10000) {
                      //   priceValidate = true;
                      //   priceErrorM = "Minimum price Rp 10.000";
                      // }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainerManageServiceScreen(),
                          ));
                    });
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
