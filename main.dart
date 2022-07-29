import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modul_2/main_page.dart';

void main(List<String> args) {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? const CupertinoApp(
            theme: CupertinoThemeData(
                primaryColor: Colors.purple,
                scaffoldBackgroundColor: Color.fromRGBO(220, 220, 220, 1)),
            home: MainPage(),
            localizationsDelegates: [
              DefaultCupertinoLocalizations.delegate,
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
            ],)
        : MaterialApp(
            theme: ThemeData(
              primarySwatch: MaterialColor(Colors.purple.value, {
                50: Colors.purple.shade50,
                100: Colors.purple.shade100,
                200: Colors.purple.shade200,
                300: Colors.purple.shade300,
                400: Colors.purple.shade400,
                500: Colors.purple.shade500,
                600: Colors.purple.shade600,
                700: Colors.purple.shade700,
                800: Colors.purple.shade800,
                900: Colors.purple.shade900,
              }),
              fontFamily: "RobotoMono",
              scaffoldBackgroundColor: const Color.fromRGBO(220, 220, 220, 1),
            ),
            home: const MainPage(),
          );
  }
}
