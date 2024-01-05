import 'dart:convert';

import 'package:co_pet/cubits/user/pet_hotel_grooming/store_detail_cubit.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_grooming/grooming_register_model.dart';
import 'package:co_pet/domain/models/pet-service/toko/register_hotel/hotel_register_model.dart';
import 'package:co_pet/domain/repository/pet-service/toko/register_grooming/grooming_register_repository.dart';
import 'package:co_pet/domain/repository/pet-service/toko/register_hotel/hotel_register_repository.dart';
import 'package:co_pet/utils/currency_formarter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sizer/sizer.dart';
import 'package:co_pet/domain/models/user/pet_hotel_grooming/store_detail_model.dart'
    as data;

class ManageServiceScreen extends StatefulWidget {
  final String id;
  const ManageServiceScreen({super.key, required this.id});

  @override
  State<ManageServiceScreen> createState() => _ManageServiceScreenState();
}

class _ManageServiceScreenState extends State<ManageServiceScreen> {
  TextEditingController _storeName = TextEditingController(),
      _storeLocation = TextEditingController(),
      _storeDescription = TextEditingController();
  StoreDetailCubit storeDetailCubit = StoreDetailCubit();
  bool storeNameOnEdit = true,
      storeLoactionOnEdit = true,
      storeDescriptionOnEdit = true,
      pageLoading = true;
  data.Data? storeDetailModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storeDetailCubit.getStoreDetailPetService(widget.id);
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
                              debugPrint("$title");
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
    return Container(
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
                                color: const Color.fromARGB(255, 11, 11, 11),
                                fontSize: 13.sp),
                          ),
                        ),
                        Text(
                          "${currencyformat.currency(groomingData.priceGrooming)}/Day",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 11, 11, 11),
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
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget serviceCardHotel(data.Hotel? hotelData) {
    CurrencyFormarter currencyformat = CurrencyFormarter();

    return Container(
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
                        Text(
                          hotelData!.titleHotel,
                          style: TextStyle(
                              color: const Color.fromARGB(255, 11, 11, 11),
                              fontSize: 13.sp),
                        ),
                        Text(
                          "${currencyformat.currency(hotelData.priceHotel)}/Day",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 11, 11, 11),
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
                        style: TextStyle(color: Colors.grey, fontSize: 10.sp),
                      )
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
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
          debugPrint("state $state");
          if (state is StoreDetailLoaded) {
            pageLoading = false;
            storeDetailModel = state.data.data!;
            _storeName.text = storeDetailModel!.petShopName;
            _storeLocation.text = storeDetailModel!.location;
            _storeDescription.text = storeDetailModel!.description;
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
                              child: FadeInImage(
                                  placeholder:
                                      const AssetImage("assets/gif/load.gif"),
                                  image: Image.memory(base64Decode(
                                          storeDetailModel!.petShopPicture))
                                      .image)),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: IconButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
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
                                  onChanged: (value) {},
                                  readOnly: storeDescriptionOnEdit,
                                  decoration: InputDecoration(
                                    hintText:
                                        "Write a Description for your store...",
                                    hintStyle:
                                        const TextStyle(color: Colors.grey),
                                    border: InputBorder.none,
                                    suffixIcon: !storeDescriptionOnEdit
                                        ? TextButton(
                                            onPressed: () {
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
