import 'package:event_app/home_page/home_page_view/home_page_view.dart';
import 'package:event_app/services/services.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  Rx<bool> isLoading = false.obs, showBrightColor = false.obs;
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  Rx<String?> emailError = Rx<String?>(null), passwordError = Rx<String?>(null);

  onChange() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      print('1');
      return showBrightColor.value = true;
    } else {
      return showBrightColor.value = false;
    }
  }

  login() async {
    isLoading.value = true;
    var data = await EventServices()
        .login(email: emailController.text, password: passwordController.text);
    if (data != null) {
      if (data['Status']) {
        toastMessage(msg: data['Message']);
        isLoading.value = false;
        Get.off(() => HomePageView());
      } else {
        isLoading.value = false;
        emailController.text = '';
        passwordController.text = '';
        toastMessage(msg: data['Message']);
      }
    }
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter an email address';
    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
        .hasMatch(value)) {
      emailError.value = 'Please enter a valid email address';
    } else {
      emailError.value = null;
    }
    return emailError.value;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password';
    } else {
      passwordError.value = null;
    }
    return passwordError.value;
  }

  @override
  void onInit() {
    super.onInit();
    initializeAll();
  }

  @override
  void onClose() {
    super.onClose();
    disposeAll();
  }

  disposeAll() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  void initializeAll() {
    emailFocusNode.addListener(
      () {
        if (!emailFocusNode.hasFocus) {
          emailError.value = validateEmail(emailController.text);
        }
      },
    );
    passwordFocusNode.addListener(
      () {
        if (!passwordFocusNode.hasFocus) {
          passwordError.value = validatePassword(passwordController.text);
        }
      },
    );
  }
}
