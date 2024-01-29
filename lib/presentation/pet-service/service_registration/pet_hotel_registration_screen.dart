import 'dart:convert';
import 'dart:io';

import 'package:co_pet/domain/models/pet-service/register/register_toko_model.dart';
import 'package:co_pet/domain/repository/pet-service/register/register_toko_repository.dart';
import 'package:co_pet/presentation/pet-service/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class PetHotelandGroomingRegistration extends StatefulWidget {
  final String penyediaId;
  const PetHotelandGroomingRegistration({super.key, required this.penyediaId});

  @override
  State<PetHotelandGroomingRegistration> createState() =>
      _PetHotelandGroomingRegistrationState();
}

class _PetHotelandGroomingRegistrationState
    extends State<PetHotelandGroomingRegistration> {
  XFile? selectedImage;
  TextEditingController _storeName = TextEditingController(),
      _description = TextEditingController(),
      _address = TextEditingController();
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  DateTime? open, close;
  bool validateStoreName = false,
      validatestoreLocation = false,
      validateDescription = false,
      validatePhoto = false;
  String storeNameErrorMessage = "",
      storeLocationAddressMessage = "",
      storeDescriptionMessage = "",
      photoErroMessage = "";

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

  Future<void> _selectTime(
      BuildContext context, TimeOfDay time, String title) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    debugPrint("a ${close.toString()}");
    if (picked != null && picked != time) {
      setState(() {
        time = picked;
        if (title == "open") {
          openTime = picked;
          open = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, picked.hour, picked.minute);
          debugPrint("a $open");
        } else {
          closeTime = picked;
          close = DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day, picked.hour, picked.minute);
          debugPrint("a $close");
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Store Registration"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                textField("Store Name", _storeName, Icons.store,
                    validateStoreName, storeNameErrorMessage),
                textField(
                    "Store Location Address",
                    _address,
                    Icons.fmd_good_sharp,
                    validatestoreLocation,
                    storeLocationAddressMessage),
                Row(
                  children: [
                    Text(
                      "Open Time : ",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 154, 154, 154),
                          fontSize: 10.sp),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => _selectTime(context, openTime, "open"),
                      child: Text(
                        "${openTime.hour.toString()} : ${openTime.minute.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Close Time : ",
                      style: TextStyle(
                          color: const Color.fromARGB(255, 154, 154, 154),
                          fontSize: 10.sp),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                      ),
                      onPressed: () => _selectTime(context, closeTime, "close"),
                      child: Text(
                        "${closeTime.hour.toString()} : ${closeTime.minute.toString()}",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Store Image",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 154, 154, 154),
                          fontSize: 10.sp),
                    ),
                    validatePhoto
                        ? Text(
                            "   $photoErroMessage",
                            style: TextStyle(color: Colors.red, fontSize: 9.sp),
                          )
                        : const SizedBox()
                  ],
                ),
                IconButton(
                    onPressed: () async {
                      final result = await ImagePicker().pickImage(
                        imageQuality: 70,
                        maxWidth: 1500,
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
                      "Store Description",
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
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a description.';
                        }
                        return null; // Return null if the input is valid.
                      },
                      decoration: InputDecoration(
                          hintText: "Write a Description for your store...",
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.sp),
                          border: InputBorder.none,
                          errorText: validateDescription
                              ? storeDescriptionMessage
                              : null),

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
                      SmartDialog.showLoading(
                        backDismiss: true,
                        builder: (context) => const SpinKitWave(
                          color: Color.fromARGB(255, 0, 162, 255),
                          size: 50,
                        ),
                      );
                      validateStoreName = _storeName.text.isEmpty;
                      validatestoreLocation = _address.text.isEmpty;
                      validateDescription = _description.text.isEmpty;
                      validatePhoto = selectedImage == null;
                      List<String> description = _description.text.split(" ");

                      if (validateStoreName) {
                        storeNameErrorMessage = "Input store name";
                      } else if (!validateStoreName &&
                          _storeName.text.length < 5) {
                        validateStoreName = true;
                        storeNameErrorMessage =
                            "Store name must be at least 5 characters";
                      }

                      if (validatestoreLocation) {
                        storeLocationAddressMessage = "Input store address";
                      } else if (!validatestoreLocation &&
                          _address.text.length < 10) {
                        validatestoreLocation = true;
                        storeLocationAddressMessage =
                            "Input detail store address";
                      }

                      if (validateDescription) {
                        storeDescriptionMessage = "Input store description";
                      } else if (!validateDescription &&
                          description.length < 10) {
                        validateDescription = true;
                        storeDescriptionMessage =
                            "Store description must be at least 10 words";
                      }

                      if (validatePhoto) {
                        photoErroMessage = "Upload store image";
                      }

                      if (!validateStoreName &&
                          !validateDescription &&
                          !validateDescription &&
                          _storeName.text.length >= 5 &&
                          _address.text.length >= 10 &&
                          description.length >= 10 &&
                          selectedImage != null) {
                        List<int> imageBytes =
                            File(selectedImage!.path).readAsBytesSync();
                     
                        final data = TokoRegisterModel(
                            penyediaId: widget.penyediaId,
                            nama: _storeName.text,
                            foto: base64Encode(imageBytes),
                            fasilitas: "",
                            deskripsi: _description.text,
                            lokasi: _address.text,
                            jamBuka: open.toString(),
                            jamTutup: close.toString());

                        final registerSuccess =
                            await TokoRegisterRepository().registerToko(data);

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
                      }

                      setState(() {
                        SmartDialog.dismiss();
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
      ),
    );
  }
}
