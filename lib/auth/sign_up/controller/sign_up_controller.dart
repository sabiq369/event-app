import 'package:event_app/home_page/home_page_view/home_page_view.dart';
import 'package:event_app/services/services.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final TextEditingController nameController = TextEditingController(),
      emailController = TextEditingController(),
      passwordController = TextEditingController(),
      mobileNumController = TextEditingController(),
      instaLinkController = TextEditingController(),
      tikTokLindController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode(),
      emailFocus = FocusNode(),
      passwordFocusNode = FocusNode(),
      mobileFocus = FocusNode(),
      instaFocus = FocusNode(),
      tikTokFocus = FocusNode();
  final RxBool isLoading = false.obs,
      userConsent = false.obs,
      showBrightColor = false.obs;
  RxInt speciality = 0.obs, country = 0.obs;
  Rx<String?> nameError = Rx<String?>(null),
      emailError = Rx<String?>(null),
      passwordError = Rx<String?>(null),
      mobileError = Rx<String?>(null);

  toggleCheckBox() => userConsent.value = !userConsent.value;

  nameOnChange() {
    if (nameController.text.isEmpty) {
      nameError.value = 'Please Enter Full Name';
    } else {
      nameError.value = null;
    }
  }

  signUp() async {
    isLoading.value = true;
    print('|||||||||||||||| 1||||||||||||');
    var data = await EventServices().signUp(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        speciality: speciality.value,
        country: country.value,
        mobile: mobileNumController.text,
        instagram: instaLinkController.text,
        tikTok: tikTokLindController.text,
        userConsent: userConsent.value);
    if (data != null) {
      if (data["Status"]) {
        isLoading.value = false;
        toastMessage(msg: data["Message"]);
        Get.off(() => HomePageView());
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

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter Full Name';
    } else {
      nameError.value = null;
    }
    return nameError.value;
  }

  String? validateMobile(String value) {
    if (value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (value.length < 10) {
      return 'Please enter a 10 digit number';
    } else {
      mobileError.value = null;
    }
    return mobileError.value;
  }

  @override
  void onClose() {
    super.onClose();
    disposeAll();
  }

  disposeAll() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    mobileNumController.dispose();
    instaLinkController.dispose();
    tikTokLindController.dispose();
    nameFocusNode.dispose();
    emailFocus.dispose();
    passwordFocusNode.dispose();
    mobileFocus.dispose();
    instaFocus.dispose();
    tikTokFocus.dispose();
  }

  @override
  void onInit() {
    super.onInit();
    initializeAll();
  }

  void initializeAll() {
    nameFocusNode.addListener(
      () {
        if (!nameFocusNode.hasFocus) {
          nameError.value = validateName(nameController.text);
        }
      },
    );
    emailFocus.addListener(
      () {
        if (!emailFocus.hasFocus) {
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
    mobileFocus.addListener(
      () {
        if (!mobileFocus.hasFocus) {
          mobileError.value = validateMobile(mobileNumController.text);
        }
      },
    );
  }
}
