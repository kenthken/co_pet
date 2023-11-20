import 'package:co_pet/cubits/user/user_session/user_login_cubit.dart';
import 'package:co_pet/presentation/login/login.dart';
import 'package:co_pet/presentation/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
  bool isUserLogin = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userCubit.isTokenEmpty();
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
            if (state is UserCheckToken && state.isTokenEmpty == false) {
              isUserLogin = true;
            }
            return isUserLogin ? Navbar() : Login();
          },
        ),
      );
    });
  }
}
