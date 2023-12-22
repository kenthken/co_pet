import 'package:co_pet/domain/repository/user/user_login_repository.dart';
import 'package:co_pet/presentation/pet-service/on_verified/verified_screen.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomePetServiceScreen extends StatefulWidget {
  const HomePetServiceScreen({super.key});

  @override
  State<HomePetServiceScreen> createState() => _HomePetServiceScreenState();
}

class _HomePetServiceScreenState extends State<HomePetServiceScreen> {
  String? username = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsername();
  }

  Future<void> getUsername() async {
    username = await UserLoginRepository().getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [Text("Hi, $username ")],
          ),
          actions: [IconButton(onPressed: () {}, icon: Icon(Icons.settings))],
          backgroundColor: const Color.fromARGB(255, 0, 162, 255),
          foregroundColor: Colors.white,
        ),
        body: OnVerifiedScreen());
  }
}
