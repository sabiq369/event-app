import 'package:event_app/auth/login/model/login_model.dart';
import 'package:event_app/home_page/home_page_view/home_page_view.dart';
import 'package:event_app/services/services.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  LoginModel? loginModel;
  Rx<bool> isLoading = false.obs, showBrightColor = false.obs;
  final TextEditingController emailController = TextEditingController(),
      passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode(), passwordFocusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  Rx<String?> emailError = Rx<String?>(null), passwordError = Rx<String?>(null);

  onChange() {
    bool isEmailValid = emailController.text.isNotEmpty &&
        RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$")
            .hasMatch(emailController.text);
    bool isPasswordValid = passwordController.text.isNotEmpty;
    showBrightColor.value = isEmailValid && isPasswordValid;
    if (showBrightColor.value) {
      emailError.value = null;
      passwordError.value = null;
    }
  }

  login() async {
    isLoading.value = true;
    var data = await EventServices()
        .login(email: emailController.text, password: passwordController.text);
    if (data != null) {
      if (data['Status']) {
        loginModel = LoginModel.fromJson(data);
        final prefs = await SharedPreferences.getInstance();
        // Save data to SharedPreferences
        await prefs.setString('userName', loginModel!.doctorName ?? '');
        await prefs.setString('userQrCode', loginModel!.qrCode ?? '');
        await prefs.setString('userId', loginModel!.useruniqueid ?? '');

        // Assign to global variables
        userName = prefs.getString('userName') ?? '';
        userQrCode = prefs.getString('userQrCode') ?? '';
        userId = prefs.getString('userId') ?? '';

        print('|||||||||||| user data |||||||||||||||');
        print(userName);
        print(userQrCode);
        print(userId);
        toastMessage(msg: data['Message']);
        isLoading.value = false;
        Get.off(() => HomePageView());
      } else {
        isLoading.value = false;
        emailController.text = '';
        passwordController.text = '';
        toastMessage(msg: data['Message']);
        onChange();
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
        onChange();
      },
    );
    passwordFocusNode.addListener(
      () {
        if (!passwordFocusNode.hasFocus) {
          passwordError.value = validatePassword(passwordController.text);
        }
        onChange();
      },
    );
  }
}
