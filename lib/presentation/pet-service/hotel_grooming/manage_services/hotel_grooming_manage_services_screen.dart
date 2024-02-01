import 'dart:convert';
import 'dart:io';
import 'package:co_pet/cubits/user/pet_hotel_grooming/store_detail_cubit.dart';
import 'package:co_pet/domain/models/pet-service/register/register_toko_model.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_grooming/grooming_register_model.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_hotel/hotel_register_model.dart';
import 'package:co_pet/domain/repository/pet-service/toko/register_grooming/grooming_register_repository.dart';
import 'package:co_pet/domain/repository/pet-service/toko/register_hotel/hotel_register_repository.dart';
import 'package:co_pet/domain/repository/pet-service/toko/update_toko_repository.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart'
    as data;

class HotelGroomingManageServiceScreen extends StatefulWidget {
  final String id;
  const HotelGroomingManageServiceScreen({super.key, required this.id});

  @override
  State<HotelGroomingManageServiceScreen> createState() =>
      _HotelGroomingManageServiceScreenState();
}

class _HotelGroomingManageServiceScreenState
    extends State<HotelGroomingManageServiceScreen> {
  TextEditingController _storeName = TextEditingController(),
      _storeLocation = TextEditingController(),
      _storeDescription = TextEditingController();
  StoreDetailCubit storeDetailCubit = StoreDetailCubit();
  bool storeNameOnEdit = true,
      storeLoactionOnEdit = true,
      storeDescriptionOnEdit = true,
      pageLoading = true;
  dynamic image, pickedImage;
  data.Data? storeDetailModel;
  TimeOfDay openTime = TimeOfDay.now();
  TimeOfDay closeTime = TimeOfDay.now();
  DateTime? open, close;
  XFile? selectedImage;
  String tokoId = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeDetailCubit.getStoreDetailPetService(widget.id);
  }

  Future<void> _selectTime(
      BuildContext context, TimeOfDay time, String title) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );

    if (picked != null && picked != time) {
      time = picked;
      if (title == "open") {
        openTime = picked;
        open = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, picked.hour, picked.minute);
      } else {
        closeTime = picked;
        close = DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, picked.hour, picked.minute);
      }

      await udpateData();
      setState(() {});
    }
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
                        onPressed: () async {
                          await udpateData();

                          setState(() {
                            if (title == "Store Name") {
                              storeNameOnEdit = !storeNameOnEdit;
                            } else if (title == "Store Location") {
                              storeLoactionOnEdit = !storeLoactionOnEdit;
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
                            if (title == "Store Name") {
                              storeNameOnEdit = !storeNameOnEdit;
                            } else if (title == "Store Location") {
                              storeLoactionOnEdit = !storeLoactionOnEdit;
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

  Widget serviceCardGrooming(data.Grooming? groomingData) {
    CurrencyFormarter currencyformat = CurrencyFormarter();
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 100.w,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(142, 215, 215, 215),
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  groomingData!.titleGrooming,
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 11, 11, 11),
                                      fontSize: 13.sp),
                                ),
                              ),
                              Text(
                                "${currencyformat.currency(groomingData.priceGrooming)}/Day",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 11, 11, 11),
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      for (String e in groomingData.serviceDetailGrooming)
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              e,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.sp),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              SmartDialog.showLoading(
                backDismiss: true,
                builder: (context) => const SpinKitWave(
                  color: Color.fromARGB(255, 0, 162, 255),
                  size: 50,
                ),
              );
              await GroomingRegisterRepository()
                  .groomingDelete(tokoId, groomingData.id.toString())
                  .then((value) => value == true
                      ? Fluttertoast.showToast(
                          msg: "Delete Success",
                          backgroundColor: Colors.white,
                          textColor: Colors.black)
                      : Fluttertoast.showToast(
                          msg: "Please try again later",
                          backgroundColor: Colors.white,
                          textColor: Colors.black));
              storeDetailCubit.getStoreDetailPetService(widget.id);
              SmartDialog.dismiss();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }

  Widget serviceCardHotel(data.Hotel? hotelData) {
    CurrencyFormarter currencyformat = CurrencyFormarter();

    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Material(
              elevation: 2,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SizedBox(
                  width: 100.w,
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Color.fromARGB(142, 215, 215, 215),
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  hotelData!.titleHotel,
                                  style: TextStyle(
                                      color:
                                          const Color.fromARGB(255, 11, 11, 11),
                                      fontSize: 13.sp),
                                ),
                              ),
                              Text(
                                "${currencyformat.currency(hotelData.priceHotel)}/Day",
                                style: TextStyle(
                                    color:
                                        const Color.fromARGB(255, 11, 11, 11),
                                    fontSize: 12.sp),
                              )
                            ],
                          ),
                        ),
                      ),
                      for (String e in hotelData.serviceDetailHotel)
                        Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 10,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              e,
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 10.sp),
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              SmartDialog.showLoading(
                backDismiss: true,
                builder: (context) => const SpinKitWave(
                  color: Color.fromARGB(255, 0, 162, 255),
                  size: 50,
                ),
              );
              await HotelRegisterRepository()
                  .hotelDelete(tokoId, hotelData.id.toString())
                  .then((value) => value == true
                      ? Fluttertoast.showToast(
                          msg: "Delete Success",
                          backgroundColor: Colors.white,
                          textColor: Colors.black)
                      : Fluttertoast.showToast(
                          msg: "Please try again later",
                          backgroundColor: Colors.white,
                          textColor: Colors.black));
              await storeDetailCubit.getStoreDetailPetService(widget.id);
              setState(() {});
              SmartDialog.dismiss();
            },
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ))
      ],
    );
  }

  Future<dynamic> addServices(String title) {
    TextEditingController _type = TextEditingController(),
        _price = TextEditingController(),
        _facility = TextEditingController();
    bool titleValidate = false,
        priceValidate = false,
        facilityValidate = false,
        facilityRead = false;
    String titleError = "", priceError = "", facilityError = "";
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
                          margin: EdgeInsets.only(bottom: 20),
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
                            "Add $title Services",
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "Input Title",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        TextFormField(
                          controller: _type,
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
                          "Input Facility",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        facilityValidate
                            ? Text(
                                facilityError,
                                style: TextStyle(
                                    color: Colors.red.shade700, fontSize: 9.sp),
                              )
                            : Container(),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          height: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 249, 249, 249),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            readOnly: facilityRead,
                            controller: _facility,
                            autofocus: false,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: "Input Text Here",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(255, 132, 140, 155)),
                            ),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount: facility.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      height: 60,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 249, 249, 249),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: TextFormField(
                                        controller: facility[index],
                                        autofocus: false,
                                        decoration: const InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Input Text Here",
                                          hintStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 132, 140, 155)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      mystate(() {
                                        facility[index].clear();
                                        facility[index].dispose();
                                        facility.removeAt(index);
                                        if (facility.isEmpty) {
                                          facilityRead = false;
                                        }
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.do_disturb_on,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                mystate(() {
                                  if (_facility.text.isNotEmpty) {
                                    facilityValidate = false;
                                    facility.add(TextEditingController());
                                    facilityRead = true;
                                  } else {
                                    facilityValidate = true;
                                    facilityError =
                                        "first field must be input to add more";
                                  }
                                });
                              },
                              child: Text(
                                "Add More",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 162, 255)),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "Input Price",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                        ),
                        Row(
                          children: [
                            Text(
                              "Rp ",
                              style: TextStyle(
                                  color: Colors.grey, fontSize: 12.sp),
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
                                        errorText:
                                            priceValidate ? priceError : null),
                                    controller: _price,
                                    keyboardType: TextInputType.number,
                                  )),
                            ),
                            Text(title == "Hotel" ? "/ Day" : "/ Grooming")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                titleValidate = _type.text.isEmpty;
                                priceValidate = _price.text.isEmpty;
                                facilityValidate = _facility.text.isEmpty;

                                if (titleValidate) {
                                  titleError = "Must input title";
                                }

                                if (facilityValidate) {
                                  facilityError =
                                      "Must input at least 1 facility";
                                }

                                if (priceValidate) {
                                  priceError = "Must input price";
                                } else if (!priceValidate &&
                                    int.parse(_price.text) < 10000) {
                                  priceValidate = true;
                                  priceError = "Minimum price Rp 10.000";
                                }

                                if (!titleValidate &&
                                    !facilityValidate &&
                                    !priceValidate &&
                                    int.parse(_price.text) >= 10000) {
                                  bool registerSuccess = false;
                                  List<String> facilityList =
                                      facility.map((e) => e.text).toList();
                                  String facilityJoin =
                                      "${_facility.text} ${facilityList.isNotEmpty ? "," : ""}";
                                  facilityJoin += facilityList.join(',');

                                  if (title == "Hotel") {
                                    HotelRegisterModel data =
                                        HotelRegisterModel(
                                            tokoId:
                                                storeDetailModel!.id.toString(),
                                            tipeHotel: _type.text,
                                            fasilitas: facilityJoin,
                                            harga: int.parse(_price.text));

                                    const SpinKitWave(
                                      color: Color.fromARGB(255, 0, 162, 255),
                                      size: 50,
                                    );

                                    registerSuccess =
                                        await HotelRegisterRepository()
                                            .hotelRegister(data);
                                  } else if (title == "Grooming") {
                                    GroomingRegisterModel data =
                                        GroomingRegisterModel(
                                            tokoId:
                                                storeDetailModel!.id.toString(),
                                            tipe: _type.text,
                                            fasilitas: facilityJoin,
                                            harga: int.parse(_price.text));

                                    const SpinKitWave(
                                      color: Color.fromARGB(255, 0, 162, 255),
                                      size: 50,
                                    );

                                    registerSuccess =
                                        await GroomingRegisterRepository()
                                            .groomingRegister(data);
                                  }

                                  if (registerSuccess) {
                                    storeDetailCubit
                                        .getStoreDetailPetService(widget.id);
                                    Navigator.pop(context);
                                  }
                                }
                              },
                              child: Center(
                                child: Container(
                                  margin: EdgeInsets.all(20),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 0, 162, 255),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    "Add Services",
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

  Widget hotelServicesDisplay(List<data.Hotel>? hotelData) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hotel',
            style: TextStyle(
              color: Color.fromARGB(255, 145, 145, 145),
              fontSize: 13.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: 0.38,
            ),
          ),
          hotelData!.isEmpty
              ? const Center(
                  child: Text(
                    "No hotel service",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : const SizedBox(),
          for (data.Hotel hotel in hotelData) serviceCardHotel(hotel),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  addServices("Hotel");
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Color.fromARGB(255, 0, 162, 255),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget groomingServicesDisplay(List<data.Grooming>? groomingData) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Grooming',
            style: TextStyle(
              color: Color.fromARGB(255, 145, 145, 145),
              fontSize: 13.sp,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              height: 0,
              letterSpacing: 0.38,
            ),
          ),
          groomingData!.isEmpty
              ? const Center(
                  child: Text(
                    "No grooming service",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              : const SizedBox(),
          for (data.Grooming grooming in groomingData)
            serviceCardGrooming(grooming),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  addServices("Grooming");
                },
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Color.fromARGB(255, 0, 162, 255),
                ),
              ),
            ],
          )
        ],
      ),
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
    debugPrint(
        "awdawd ${_storeName.text} ${_storeDescription.text} ${_storeLocation.text} ${open.toString()}  ${close.toString()} ${base64Encode(imageBytes).length} ");
    TokoRegisterModel data = TokoRegisterModel(
        penyediaId: null,
        nama: _storeName.text,
        foto: pickedImage != null ? base64Encode(imageBytes) : image,
        fasilitas: "",
        deskripsi: _storeDescription.text,
        lokasi: _storeLocation.text,
        jamBuka: open.toString(),
        jamTutup: close.toString());

    final updateSuccess = await UpdateTokoRepository().updateToko(data, tokoId);

    SmartDialog.dismiss();

    if (updateSuccess) {
      storeDetailCubit.getStoreDetailPetService(widget.id);
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
        title: Text("Manage Services"),
        backgroundColor: const Color.fromARGB(255, 0, 162, 255),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder(
        bloc: storeDetailCubit,
        builder: (context, state) {
          debugPrint("stateeee $state");
          if (state is StoreDetailLoading) {
            // return const SpinKitWave(
            //   color: Color.fromARGB(255, 0, 162, 255),
            //   size: 50,
            // );
          } else if (state is StoreDetailLoaded) {
            pageLoading = false;
            storeDetailModel = state.data.data!;
            _storeName.text = storeDetailModel!.petShopName;
            _storeLocation.text = storeDetailModel!.location;
            _storeDescription.text = storeDetailModel!.description;
            image = storeDetailModel!.petShopPicture;
            open = state.data.data!.openTime;
            close = state.data.data!.closeTime;
            tokoId = state.data.data!.id.toString();
            openTime = TimeOfDay.fromDateTime(open!);
            closeTime = TimeOfDay.fromDateTime(close!);
          }
          return pageLoading
              ? const SpinKitWave(
                  color: Color.fromARGB(255, 0, 162, 255),
                  size: 50,
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          SizedBox(
                              height: 50.w,
                              width: 100.w,
                              child: selectedImage == null
                                  ? Image.memory(
                                      base64Decode(image),
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
                        ],
                      ),
                      Container(
                        width: 100.w,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textField(
                                  "Store Name", _storeName, storeNameOnEdit),
                              textField("Store Location", _storeLocation,
                                  storeLoactionOnEdit),
                              Text(
                                "Store Description",
                                style: TextStyle(
                                    color: Colors.grey, fontSize: 12.sp),
                              ),
                              Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.only(bottom: 20),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 0.5, color: Colors.grey)),
                                child: TextFormField(
                                  controller: _storeDescription,
                                  onChanged: (value) async {},
                                  readOnly: storeDescriptionOnEdit,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Write a Description for your store...",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    suffixIcon: !storeDescriptionOnEdit
                                        ? TextButton(
                                            onPressed: () async {
                                              await udpateData();
                                              setState(() {
                                                storeDescriptionOnEdit =
                                                    !storeDescriptionOnEdit;
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
                                                storeDescriptionOnEdit =
                                                    !storeDescriptionOnEdit;
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
                              Row(
                                children: [
                                  Text(
                                    "Open Time : ",
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 154, 154, 154),
                                        fontSize: 10.sp),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    onPressed: () =>
                                        _selectTime(context, openTime, "open"),
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
                                        color: const Color.fromARGB(
                                            255, 154, 154, 154),
                                        fontSize: 10.sp),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  ElevatedButton(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                    ),
                                    onPressed: () => _selectTime(
                                        context, closeTime, "close"),
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
                              Container(
                                child: Column(
                                  children: [
                                    Text(
                                      "Store Services",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                              ),
                              hotelServicesDisplay(storeDetailModel!.hotels),
                              groomingServicesDisplay(
                                  storeDetailModel!.groomings)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
