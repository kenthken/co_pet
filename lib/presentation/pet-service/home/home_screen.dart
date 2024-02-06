import 'package:co_pet/domain/models/pet-service/pet_service_login_response_model.dart';
import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/pet-service/admin/admin_service_screen.dart';
import 'package:co_pet/presentation/pet-service/doctor/doctor_service_screen.dart';
import 'package:co_pet/presentation/pet-service/hotel_grooming/hotel_grooming_service_screen.dart';
import 'package:co_pet/presentation/pet-service/on_verified/verified_screen.dart';
import 'package:co_pet/presentation/pet-service/trainer/trainer_service_screen.dart';
import 'package:co_pet/presentation/user/features/doctor/doctor_screen.dart';
import 'package:co_pet/presentation/user/profile/profile_screen.dart';
import 'package:co_pet/utils/secure_storage_services.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePetServiceScreen extends StatefulWidget {
  const HomePetServiceScreen({super.key});

  @override
  State<HomePetServiceScreen> createState() => _HomePetServiceScreenState();
}

class _HomePetServiceScreenState extends State<HomePetServiceScreen> {
  String? username;
  String? serviceType;
  String? isAcc;
  String? id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
    getServiceType();
  }

  Future<void> getServiceType() async {
    serviceType = await SecureStorageService().readData("service_type");
    isAcc = await SecureStorageService().readData("is_acc");
    debugPrint("service type $isAcc");
    setState(() {});
  }

  Future<void> getUsername() async {
    username = await UserLoginRepository().getUsername();
    debugPrint("username $username");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [Text("Hi, $username ")],
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const ProfileScreen(isPetService: true),
                      ));
                },
                icon: Icon(Icons.person))
          ],
          backgroundColor: const Color.fromARGB(255, 0, 162, 255),
          foregroundColor: Colors.white,
        ),
        body: isAcc == "false"
            ? OnVerifiedScreen()
            : serviceType == "Toko"
                ? HotelGroomingServiceScreen()
                : serviceType == "Dokter"
                    ? DoctorServiceScreen()
                    : serviceType == "Trainer"
                        ? TrainerServiceScreen()
                        : serviceType == "admin"
                            ? AdminServiceScreen()
                            : Container());
  }
}
