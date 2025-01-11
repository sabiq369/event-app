import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AskQuestionController extends GetxController {
  RxBool isLoading = false.obs, showBrightColor = false.obs;
  final nameController = TextEditingController(),
      questionController = TextEditingController();
  final nameFocus = FocusNode(), questionFocus = FocusNode();
  Rx<String?> nameError = Rx<String?>(null), questionError = Rx<String?>(null);
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeAll();
  }

  void initializeAll() {
    nameFocus.addListener(
      () {
        print('|||||||||||||| 1');

        if (!nameFocus.hasFocus) {
          nameError.value = validateName(nameController.text);
        }
      },
    );
    questionFocus.addListener(
      () {
        print('|||||||||||||| 2');

        if (!questionFocus.hasFocus) {
          questionError.value = validateQuestion(questionController.text);
        }
      },
    );
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Please enter your name';
    } else {
      nameError.value = null;
    }
    return nameError.value;
  }

  String? validateQuestion(String value) {
    if (value.isEmpty) {
      return 'Please enter a question';
    } else {
      questionError.value = null;
    }
    return questionError.value;
  }

  @override
  void onClose() {
    super.onClose();
    disposeAll();
  }

  disposeAll() {
    nameController.dispose();
    questionController.dispose();
    nameFocus.dispose();
    questionFocus.dispose();
  }
}
