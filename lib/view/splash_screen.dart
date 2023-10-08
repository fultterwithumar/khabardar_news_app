import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:khabar_dar/common/colors.dart';
import 'package:khabar_dar/common/routes/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, RoutesName.homeScreen);
    });
    deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height * 1;
    final width = MediaQuery.sizeOf(context).width * 1;
    return Scaffold(
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "images/splashimg.jpeg",
              fit: BoxFit.cover,
              width: width * .9,
              height: height * .5,
            ),
            SizedBox(
              height: height * .04,
            ),
            Text(
              "TOP GLOBAL HEADLINES",
              style: GoogleFonts.anton(
                  letterSpacing: .6, color: AppColors.colorBlack),
            ),
            SizedBox(
              height: height * .04,
            ),
            SpinKitChasingDots(
              color: AppColors.colorBlack,
              size: 40,
            )
          ],
        ),
      ),
    );
  }
}
