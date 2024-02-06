import 'package:co_pet/cubits/user/user_session/user_login_cubit.dart';
import 'package:co_pet/presentation/pet-service/home/home_screen.dart';
import 'package:co_pet/presentation/pet-service/service_registration/service_registration_screen.dart';
import 'package:co_pet/presentation/user/login/login.dart';
import 'package:co_pet/presentation/user/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  UserCubit userCubit = UserCubit();
  String? userType;
  bool isUserLogin = false;
  String? id;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isUserSession();
    getUserType();
  }

  Future<void> isUserSession() async {
    isUserLogin = await userCubit.isTokenEmpty();
  }

  Future<void> getUserType() async {
    userType = await userCubit.getUserType();
    debugPrint("user typee $userType");
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(builder:
        (BuildContext context, Orientation orientation, DeviceType deviceType) {
      return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder(
          bloc: userCubit,
          builder: (context, state) {
            debugPrint("state $state");
            debugPrint(" usertype ${userType == ""}");
            if (state is UserCheckToken &&
                state.isTokenEmpty == false &&
                userType == null) {
              return const Navbar();
            } else if (state is UserCheckToken &&
                state.isTokenEmpty == false &&
                userType != null) {
              debugPrint("asdasd");
              return userType != ""
                  ? const HomePetServiceScreen()
                  : const ServiceRegistrationScreen();
            } else if (state is UserCheckToken && state.isTokenEmpty == true) {
              return const Login();
            }
            return Scaffold(
              body: Center(
                child: Image.asset("assets/logo/logo.png"),
              ),
            );
          },
        ),
        navigatorObservers: [FlutterSmartDialog.observer],
        // here
        builder: FlutterSmartDialog.init(),
      );
    });
  }
}
