import 'dart:async';

import 'package:flutter/material.dart';
import 'package:niveraapp/authentication/auth_screen.dart';
import 'package:niveraapp/constants.dart';
import 'package:niveraapp/global/global.dart';
import 'package:niveraapp/pages/main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // 5S TIMER AFTER THAT AUTH CONTROLLER
  startTimer() {
    Timer(const Duration(seconds: 2), () async {
      if(firebaseAuth.currentUser != null){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const HomePage()));
      }else{
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => const AuthScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "nivera",
          style: mRobotoRegular.copyWith(
            fontSize: 110.0,
            color: ColorPalette.mainColor,)
            ),

            //const SizedBox(height: 10,),

            Text(
              "your electronic world!",
              textAlign: TextAlign.center,
                style: mRobotoRegular.copyWith(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w400,
                  color: ColorPalette.mainColor,)
            ),
          ],
        ),
      ),
    );
  }
}
