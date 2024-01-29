import 'dart:convert';
import 'dart:io';

import 'package:co_pet/cubits/user/pet_trainer/pet_trainer_list_cubit.dart';
import 'package:co_pet/cubits/user/pet_trainer/pet_trainer_list_detail_cubit.dart';
import 'package:co_pet/domain/repository/user/pet_trainer/pet_trainer_update_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class TrainerManageServiceScreen extends StatefulWidget {
  final String id;
  const TrainerManageServiceScreen({super.key, required this.id});

  @override
  State<TrainerManageServiceScreen> createState() =>
      _TrainerManageServiceScreenState();
}

class _TrainerManageServiceScreenState
    extends State<TrainerManageServiceScreen> {
  TextEditingController _name = TextEditingController(),
      _address = TextEditingController(),
      _education = TextEditingController(),
      _price = TextEditingController(),
      _experience = TextEditingController(),
      _description = TextEditingController();
  PetTrainerListDetailCubit petTrainerListDetailCubit =
      PetTrainerListDetailCubit();
  bool nameRead = false,
      addressRead = false,
      educationRead = false,
      priceRead = false,
      experienceRead = false,
      descriptionRead = false,
      open = false,
      descriptionOnEdit = false;
  XFile? selectedImage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    petTrainerListDetailCubit.getTrainerDetail(widget.id);
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
                            // if (title == "Store Name") {
                            //   storeNameOnEdit = !storeNameOnEdit;
                            // } else if (title == "Store Location") {
                            //   storeLoactionOnEdit = !storeLoactionOnEdit;
                            // }
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
                            // if (title == "Store Name") {
                            //   storeNameOnEdit = !storeNameOnEdit;
                            // } else if (title == "Store Location") {
                            //   debugPrint("$title");
                            //   storeLoactionOnEdit = !storeLoactionOnEdit;
                            // }
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
        bloc: petTrainerListDetailCubit,
        builder: (context, state) {
          if (state is PetTrainerListDetailLoaded) {
            final data = state.data.data;
            _name.text = data.nama;
            _description.text = data.spesialis;
            // _education.text = data.;
            _address.text = data.lokasi;
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
                              Text("Accept order at the moment?",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 116, 115, 115),
                                      fontSize: 12.sp)),
                              Switch(
                                value: open,
                                activeColor:
                                    const Color.fromARGB(255, 0, 162, 255),
                                onChanged: (bool value) {
                                  PetTrainerUpdateRepository()
                                      .updateStatus(data.id.toString());
                                  setState(() {
                                    petTrainerListDetailCubit
                                        .getTrainerDetail(widget.id);
                                  });
                                },
                              )
                            ],
                          ),
                        ),
                        textField("Name", _name, nameRead),
                        textField("Education", _education, educationRead),
                        textField("Address", _address, addressRead),
                        textField("Experience", _experience, experienceRead),
                        Row(
                          children: [
                            Text(
                              "Store Description",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
                            ),
                          ],
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          margin: EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          child: TextFormField(
                            controller: _description,
                            onChanged: (value) {},
                            readOnly: descriptionRead,
                            decoration: InputDecoration(
                              hintText:
                                  "Write a Description for your specialize or experienced as a pet trainer",
                              hintStyle: const TextStyle(color: Colors.grey),
                              border: InputBorder.none,
                              suffixIcon: !descriptionOnEdit
                                  ? TextButton(
                                      onPressed: () {
                                        setState(() {
                                          descriptionOnEdit =
                                              !descriptionOnEdit;
                                        });
                                      },
                                      child: const Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 0, 162, 255)),
                                      ))
                                  : IconButton(
                                      onPressed: () {
                                        setState(() {
                                          descriptionOnEdit =
                                              !descriptionOnEdit;
                                        });
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.grey,
                                      )),
                            ),

                            minLines:
                                4, // any number you need (It works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: 6,
                          ),
                        ),
                        textField("Price /Session", _price, priceRead)
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
