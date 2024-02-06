import 'package:co_pet/cubits/user/pet/pet_list_cubit.dart';
import 'package:co_pet/domain/models/user/pet/pet_model.dart';
import 'package:co_pet/domain/repository/user/pet/create_pet_repository.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sizer/sizer.dart';

class PetScreen extends StatefulWidget {
  const PetScreen({super.key});

  @override
  State<PetScreen> createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  String id = "";
  PetListCubit petListCubit = PetListCubit();
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserIdandPet();
  }

  void getUserIdandPet() async {
    id = await SecureStorageService().readData("id");
    setState(() {
      petListCubit.getPetList(id);
    });
  }

  Widget petCard(
      String petId, String name, String type, String age, String gender) {
    return Row(
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(255, 0, 0, 0)
                      .withOpacity(0.5), // Shadow color with opacity
                  spreadRadius: 0, // Spread radius
                  blurRadius: 1, // Blur radius
                  offset: const Offset(0, 0.5), // Offset from the top
                ),
              ],
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Type",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          Text(
                            type,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Age",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          Text(
                            age,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Name",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          Text(
                            name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "Gender",
                            style:
                                TextStyle(color: Colors.grey, fontSize: 12.sp),
                          ),
                          Text(
                            gender,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13.sp),
                          )
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              await PetRepository().deletePet(id, petId).then((value) =>
                  value == true
                      ? Fluttertoast.showToast(
                          msg: "Delete Success",
                          backgroundColor: Colors.white,
                          textColor: Colors.black)
                      : Fluttertoast.showToast(
                          msg: "Please try again later",
                          backgroundColor: Colors.white,
                          textColor: Colors.black));
              await petListCubit.getPetList(id);
              setState(() {});
            },
            icon: const Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }

  Future<dynamic> addPet(String id) {
    TextEditingController petName = TextEditingController(),
        petAge = TextEditingController();

    bool titleValidate = false,
        priceValidate = false,
        facilityValidate = false,
        facilityRead = false;
    String titleError = "", priceError = "", facilityError = "";
    String selectedValuePetType = 'Cat';
    String selectedValuePetSize = "Small";
    String selectedValuePetGender = "Male";
    String selectedValuePetAge = "Month";
    List<TextEditingController> facility = [];
    return showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      isDismissible: false,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (context) {
        return StatefulBuilder(builder: (context, StateSetter mystate) {
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                child: Wrap(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(
                                    147, 151, 151, 151), // Border color
                                width: 1.0, // Border width
                                style: BorderStyle
                                    .solid, // Border style (solid, dashed, etc.)
                              ),
                            ),
                          ),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Register Pet",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Pet Name",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        TextFormField(
                          controller: petName,
                          decoration: InputDecoration(
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 198, 198,
                                      198)), // Set the desired underline color here
                            ),
                            errorText: titleValidate ? titleError : null,
                            labelStyle: TextStyle(
                                color: const Color.fromARGB(255, 154, 154, 154),
                                fontSize: 10.sp),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Pet Type",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: selectedValuePetType,
                          onChanged: (String? newValue) {
                            mystate(() {
                              selectedValuePetType = newValue!;
                            });
                          },
                          items: <String>[
                            'Cat',
                            'Dog',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Pet Age",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: petAge,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Color.fromARGB(255, 198, 198,
                                            198)), // Set the desired underline color here
                                  ),
                                  errorText: titleValidate ? titleError : null,
                                  labelStyle: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 154, 154, 154),
                                      fontSize: 10.sp),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: selectedValuePetAge,
                              onChanged: (String? newValue) {
                                mystate(() {
                                  selectedValuePetAge = newValue!;
                                });
                              },
                              items: <String>[
                                'Month',
                                'Year',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Pet Size",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: selectedValuePetSize,
                          onChanged: (String? newValue) {
                            mystate(() {
                              selectedValuePetSize = newValue!;
                            });
                          },
                          items: <String>['Small', 'Medium', 'Large']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Pet Gender",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        DropdownButton<String>(
                          value: selectedValuePetGender,
                          onChanged: (String? newValue) {
                            mystate(() {
                              selectedValuePetGender = newValue!;
                            });
                          },
                          items: <String>['Male', 'Female']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                SmartDialog.showLoading(
                                  backDismiss: true,
                                  builder: (context) => const SpinKitWave(
                                    color: Color.fromARGB(255, 0, 162, 255),
                                    size: 50,
                                  ),
                                );
                                PetModel data = PetModel(
                                    userId: int.parse(id),
                                    namaHewan: petName.text,
                                    jenisHewan: selectedValuePetType,
                                    sizeHewan: selectedValuePetSize,
                                    umurHewan:
                                        "${petAge.text} $selectedValuePetAge",
                                    gender: selectedValuePetGender);

                                final registerSuccess =
                                    await PetRepository().createPet(data);

                                if (registerSuccess) {
                                  Fluttertoast.showToast(
                                      msg: "Register pet success",
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black);
                                  SmartDialog.dismiss();
                                  Navigator.pop(context);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "Please try again later",
                                      backgroundColor: Colors.white,
                                      textColor: Colors.black);
                                  SmartDialog.dismiss();
                                }
                              },
                              child: Center(
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 0, 162, 255),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Text(
                                    "Register Pet",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pet List"),
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder(
        bloc: petListCubit,
        builder: (context, state) {
          debugPrint("state $state");
          if (state is PetListLoading) {
            return const SpinKitWave(
              color: Color.fromARGB(255, 0, 162, 255),
              size: 50,
            );
          } else if (state is PetListLoaded) {
            final pet = state.data.data;
            return ListView.builder(
              shrinkWrap: true,
              itemCount: pet.length,
              itemBuilder: (context, index) => petCard(
                  pet[index].id.toString(),
                  pet[index].namaHewan,
                  pet[index].jenisHewan,
                  pet[index].umurHewan,
                  pet[index].gender),
            );
          }
          return const Center(
            child: Text("You don’t have any pet, register pet first"),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
        onPressed: () {
          addPet(id).then((value) => setState(() {
                petListCubit.getPetList(id);
              }));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ), // You can customize the icon as needed
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
