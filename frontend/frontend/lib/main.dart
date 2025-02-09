import 'package:flutter/material.dart';
//import 'package:train_ez/pages/bottomnavscreen.dart';
//import 'package:train_ez/pages/infopage.dart';
//import 'package:train_ez/pages/exercises.dart';
//import 'package:train_ez/pages/loginsignuppage.dart';
import 'package:train_ez/pages/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: 'Poppins',
        useMaterial3: true,
      ),
      home: const Onboarding(),
      //home: PersonalInfoPage()
      //home: LoginSignupPage()
    );
  }
}

