import 'dart:convert';
import 'dart:io';

import 'package:co_pet/cubits/user/pet_trainer/pet_trainer_list_cubit.dart';
import 'package:co_pet/cubits/user/pet_trainer/pet_trainer_list_detail_cubit.dart';
import 'package:co_pet/domain/models/pet-service/trainer/register_trainer_model.dart';
import 'package:co_pet/domain/repository/pet-service/trainer/update_trainer_repository.dart';
import 'package:co_pet/domain/repository/user/pet_trainer/pet_trainer_update_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';

class TrainerManageServiceScreen extends StatefulWidget {
  final isAdmin;
  final String id;
  const TrainerManageServiceScreen(
      {super.key, required this.id, required this.isAdmin});

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
  bool nameRead = true,
      addressRead = true,
      educationRead = true,
      priceRead = true,
      experienceRead = true,
      descriptionRead = true,
      open = false,
      descriptionOnEdit = true;
  XFile? selectedImage, pickedImage;
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
                suffixIcon: !widget.isAdmin
                    ? !readOnly
                        ? TextButton(
                            onPressed: () {
                              setState(() {
                                if (title == "Name") {
                                  nameRead = !nameRead;
                                } else if (title == "Store Location") {
                                  addressRead = !addressRead;
                                } else if (title == "Address") {
                                  addressRead = !addressRead;
                                } else if (title == "Experience") {
                                  experienceRead = !experienceRead;
                                } else if (title == "Specialize Description") {
                                  descriptionOnEdit = !descriptionOnEdit;
                                } else if (title == "Price /Session") {
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
                                } else if (title == "Store Location") {
                                  addressRead = !addressRead;
                                } else if (title == "Address") {
                                  addressRead = !addressRead;
                                } else if (title == "Experience") {
                                  experienceRead = !experienceRead;
                                } else if (title == "Specialize Description") {
                                  descriptionOnEdit = !descriptionOnEdit;
                                } else if (title == "Price /Session") {
                                  priceRead = !priceRead;
                                }
                              });
                            },
                            icon: Icon(
                              Icons.edit,
                              color: Colors.grey,
                            ))
                    : null,
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

  Future<bool> udpateData() async {
    List<int> imageBytes = [];
    SmartDialog.showLoading(
      backDismiss: true,
      builder: (context) => const SpinKitWave(
        color: Color.fromARGB(255, 0, 162, 255),
        size: 50,
      ),
    );
    if (pickedImage != null) {
      imageBytes = File(pickedImage!.path).readAsBytesSync();
    }
    debugPrint("${base64Encode(imageBytes)}");
    TrainerRegisterModel data = TrainerRegisterModel(
        nama: _name.text,
        spesialis: _description.text,
        foto: base64Encode(imageBytes),
        pengalaman: _experience.text,
        harga: int.parse(_price.text),
        alumni: _education.text,
        lokasi: _address.text);

    final updateSuccess =
        await UpdateTrainerRepository().updateTrainer(data, widget.id);

    SmartDialog.dismiss();

    if (updateSuccess) {
      petTrainerListDetailCubit.getTrainerDetail(widget.id);
      Fluttertoast.showToast(
          msg: "Update Success",
          backgroundColor: Colors.white,
          textColor: Colors.black);
    } else {
      Fluttertoast.showToast(
          msg: "Please try again later",
          backgroundColor: Colors.white,
          textColor: Colors.black);
    }
    return updateSuccess;
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
                      !widget.isAdmin
                          ? Positioned(
                              bottom: 10,
                              right: 10,
                              child: IconButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white)),
                                onPressed: () async {
                                  pickedImage = await ImagePicker().pickImage(
                                    imageQuality: 70,
                                    maxWidth: 1440,
                                    source: ImageSource.gallery,
                                  );

                                  debugPrint("opern ${open}");

                                  final upadateSuccess = await udpateData();
                                  if (upadateSuccess) {
                                    setState(() {
                                      selectedImage = pickedImage;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.image,
                                  color: Colors.grey,
                                ),
                                padding: EdgeInsets.all(5),
                              ),
                            )
                          : Container()
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
                              Text(
                                  widget.isAdmin
                                      ? "Trainer Current Status"
                                      : "Accept order at the moment?",
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 116, 115, 115),
                                      fontSize: 12.sp)),
                              Switch(
                                value: open,
                                activeColor:
                                    const Color.fromARGB(255, 0, 162, 255),
                                onChanged: !widget.isAdmin
                                    ? (bool value) async {
                                        final update =
                                            await PetTrainerUpdateRepository()
                                                .updateStatus(
                                                    data.id.toString());
                                        if (update) {
                                          setState(() {
                                            petTrainerListDetailCubit
                                                .getTrainerDetail(widget.id);
                                          });
                                        }
                                      }
                                    : null,
                              )
                            ],
                          ),
                        ),
                        textField("Name", _name, nameRead),
                        textField("Address", _address, addressRead),
                        textField("Experience", _experience, experienceRead),
                        Row(
                          children: [
                            Text(
                              "Specialize Description",
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
                              suffixIcon: !widget.isAdmin
                                  ? !descriptionOnEdit
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
                                          ))
                                  : null,
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
