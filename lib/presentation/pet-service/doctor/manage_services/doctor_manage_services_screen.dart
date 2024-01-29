import 'dart:convert';
import 'dart:io';

import 'package:co_pet/cubits/user/pet_doctor/pet_doctor_list_detail_cubit.dart';
import 'package:co_pet/domain/repository/user/pet_doctor/pet_doctor_update_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class DoctorManageServiceScreen extends StatefulWidget {
  final String id;
  const DoctorManageServiceScreen({super.key, required this.id});

  @override
  State<DoctorManageServiceScreen> createState() =>
      _DoctorManageServiceScreenState();
}

class _DoctorManageServiceScreenState extends State<DoctorManageServiceScreen> {
  TextEditingController _name = TextEditingController(),
      _str = TextEditingController(),
      _address = TextEditingController(),
      _education = TextEditingController(),
      _price = TextEditingController(),
      _experience = TextEditingController(),
      _specialist = TextEditingController();
  bool nameRead = true,
      strRead = true,
      addressRead = true,
      educationRead = true,
      priceRead = true,
      experienceRead = true,
      specialistRead = true,
      open = false;
  PetDoctorListDetailCubit petDoctorListDetailCubit =
      PetDoctorListDetailCubit();
  XFile? selectedImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    petDoctorListDetailCubit.getDoctorListDetail(widget.id);
  }

  Widget textField(
      String title, TextEditingController controller, bool readOnly) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Container(
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 0.5, color: Colors.grey))),
            child: TextFormField(
              controller: controller,
              readOnly: readOnly,
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: !readOnly
                    ? TextButton(
                        onPressed: () {
                          setState(() {
                            if (title == "Name") {
                              nameRead = !nameRead;
                            } else if (title == "No STR") {
                              strRead = !strRead;
                            } else if (title == "Education") {
                              educationRead = !educationRead;
                            } else if (title ==
                                "Profesional Placement Address") {
                              addressRead = !addressRead;
                            } else if (title == "Experience") {
                              experienceRead = !experienceRead;
                            } else if (title == "Price /30 minute session") {
                              priceRead = !priceRead;
                            }
                          });
                        },
                        child: const Text(
                          "Submit",
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 162, 255)),
                        ))
                    : IconButton(
                        onPressed: () {
                          setState(() {
                            if (title == "Name") {
                              nameRead = !nameRead;
                            } else if (title == "No STR") {
                              strRead = !strRead;
                            } else if (title == "Education") {
                              educationRead = !educationRead;
                            } else if (title ==
                                "Profesional Placement Address") {
                              addressRead = !addressRead;
                            } else if (title == "Experience") {
                              experienceRead = !experienceRead;
                            } else if (title == "Price /30 Minure session") {
                              priceRead = !priceRead;
                            }
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: Colors.grey,
                        )),
                labelStyle: TextStyle(
                    color: const Color.fromARGB(255, 154, 154, 154),
                    fontSize: 14.sp),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage Service"),
      ),
      body: BlocBuilder(
        bloc: petDoctorListDetailCubit,
        builder: (context, state) {
          if (state is PetDoctorListDetailLoaded) {
            final data = state.data.data;
            _name.text = data.nama;
            _str.text = data.noStr;
            _education.text = data.alumni;
            _address.text = data.lokasiPraktek;
            _experience.text = data.pengalaman;
            _price.text = data.harga.toString();
            open = data.isAvailable;
            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SizedBox(
                          height: 50.w,
                          width: 100.w,
                          child: selectedImage == null
                              ? Image.memory(
                                  base64Decode(data.foto),
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  File(selectedImage!.path),
                                  fit: BoxFit.cover,
                                )),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: IconButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white)),
                          onPressed: () {},
                          icon: Icon(
                            Icons.image,
                            color: Colors.grey,
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: 100.w,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Accept patient at the moment?",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 116, 115, 115),
                                      fontSize: 12.sp)),
                              Switch(
                                // This bool value toggles the switch.
                                value: open,
                                activeColor:
                                    const Color.fromARGB(255, 0, 162, 255),
                                onChanged: (bool value) async {
                                  SmartDialog.showLoading(
                                    backDismiss: true,
                                    builder: (context) => const SpinKitWave(
                                      color: Color.fromARGB(255, 0, 162, 255),
                                      size: 50,
                                    ),
                                  );

                                  final updateSuccess =
                                      await PetDoctorUpdateRepository()
                                          .updateStatus(data.id.toString());

                                  if (updateSuccess) {
                                    petDoctorListDetailCubit
                                        .getDoctorListDetail(widget.id);
                                  }
                                  SmartDialog.dismiss();
                                },
                              )
                            ],
                          ),
                        ),
                        textField("Name", _name, nameRead),
                        textField("No STR", _str, strRead),
                        textField("Education", _education, educationRead),
                        textField("Profesional Placement Address", _address,
                            addressRead),
                        textField("Experience", _experience, experienceRead),
                        textField("Price /30 minute session", _price, priceRead)
                      ],
                    ),
                  )
                ],
              ),
            );
          }
          return const SpinKitWave(
            color: Color.fromARGB(255, 0, 162, 255),
            size: 50,
          );
        },
      ),
    );
  }
}
