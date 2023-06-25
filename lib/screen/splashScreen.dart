

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (_) => const Login(),
            )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            // Text(
            //   'ຮ້ານຂາຍເຄື່ອງສຳອາງອອນລາຍ',
            //   style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 44,
            //       fontWeight: FontWeight.bold),
            // ),
            SizedBox(
              height: 20,
            ),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        )),
      ),
    );
  }
}
