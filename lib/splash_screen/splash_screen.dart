import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:event_app/auth/login/view/login_view.dart';
import 'package:event_app/home_page/home_page_view.dart';
import 'package:event_app/utils/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getPref();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            TypewriterAnimatedText(
              'EVENT APP',
              textStyle: TextStyle(
                fontSize: 40, // Adjust font size
                fontWeight: FontWeight.bold,
                color: Colors.black, // Adjust text color
              ),
              speed: Duration(milliseconds: 200), // Adjust animation speed
            ),
          ],
          totalRepeatCount: 1,
          onFinished: () {
            if (userId != null) {
              Get.off(() => HomePageView());
            } else {
              Get.off(() => LoginView());
            }
          },
        ),
      )),
    );
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    userName = prefs.getString('userName');
    userQrCode = prefs.getString('userQrCode');
    userId = prefs.getString('userId');
  }
}
