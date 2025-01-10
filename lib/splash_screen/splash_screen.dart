import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:event_app/auth/login/view/login_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          onFinished: () => Get.off(() => LoginView(),
              transition: Transition.rightToLeftWithFade),
        ),
      )),
    );
  }
}
