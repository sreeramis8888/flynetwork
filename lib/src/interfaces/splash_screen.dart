import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_svg/svg.dart';
import 'package:flynetwork/src/data/constants/color_constants.dart';
import 'package:flynetwork/src/data/services/navigation_service.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool isAppUpdateRequired = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  Future<void> initialize() async {
    NavigationService navigationSerivce = NavigationService();

    Timer(Duration(seconds: 2), () {
      if (!isAppUpdateRequired) {
        navigationSerivce.pushNamedReplacement('PhoneNumber');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.center,
          //   child: SvgPicture.asset(
          //     'assets/pngs/splash_logo.png',
          //     height: 140,
          //     width: 140,
          //   ),
          // ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'assets/pngs/splash_people.png',
              scale: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
