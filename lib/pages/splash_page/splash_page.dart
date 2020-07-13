import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import '../../constant/colors.dart';
import '../home_page/home_page.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  void onSplashing() async {
    await Future.delayed(const Duration(seconds: 1));
    PageNavigator.pushReplacement(context, MyHomePage());
  }

  @override
  void initState() {
    onSplashing();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Text(
          "Loading...",
          style: TextStyle(fontSize: 32, color: Colors.black),
        ),
      ),
    );
  }
}
