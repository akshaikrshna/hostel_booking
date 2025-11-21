// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hostel_booking/BottomNavBar/bottomnavbar.dart';
import 'package:hostel_booking/Login/loginpage.dart';
import 'package:hostel_booking/admin/bottomnav.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), _navigateAfterSplash);
  }

  Future<void> _navigateAfterSplash() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("uid");
    String? role = prefs.getString("role");
    try {
      if (userId != null && userId.isNotEmpty) {
        if (role == "user") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ModernNavBar()),
          );
        } else if (role == "vendor") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Bottomnav()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const Loginpage()),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Loginpage()),
        );
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Image.asset("assets/images/logo.png")],
        ),
      ),
    );
  }
}
