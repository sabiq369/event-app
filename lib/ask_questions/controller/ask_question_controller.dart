import 'package:event_app/services/services.dart';
import 'package:event_app/speakers_page/speakers_list/model/speakers_model.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/global_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AskQuestionController extends GetxController {
  SpeakersModel? speakersModel;
  RxBool buttonLoading = false.obs,
      isLoading = false.obs,
      showBrightColor = false.obs;
  final nameController = TextEditingController(),
      questionController = TextEditingController();
  final nameFocus = FocusNode(), questionFocus = FocusNode();
  Rx<String?> nameError = Rx<String?>(null), questionError = Rx<String?>(null);
  Rx<String> speakerName = ''.obs;
  Rx<int> eventId = 0.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();

    getSpeakers();
    initializeAll();
  }

  void initializeAll() {
    nameController.text = userName ?? '';
    nameFocus.addListener(
      () {
        if (!nameFocus.hasFocus) {
          nameError.value = validateName(nameController.text);
        }
      },
    );
    questionFocus.addListener(
      () {
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

  selectSession(value) {
    speakerName.value =
        speakersModel!.data.result.firstWhere((e) => e.id == value).speakerName;
    eventId.value =
        speakersModel!.data.result.firstWhere((e) => e.id == value).eventid;

    buttonColorCheck();
  }

  buttonColorCheck() {
    if (speakerName.value != '' &&
        nameController.text.isNotEmpty &&
        questionController.text.isNotEmpty) {
      showBrightColor.value = true;
    } else {
      showBrightColor.value = false;
    }
  }

  submitQuestion(BuildContext context) async {
    if (formKey.currentState?.validate() ?? false) {
      if (speakerName.value == '') {
        getSnackBar(
            title: 'Speaker Not Selected',
            desc: 'Please choose a speaker from the dropdown to proceed.',
            icon: CupertinoIcons.person_alt);
      } else if (showBrightColor.value) {
        buttonLoading.value = true;
        var data = await EventServices().askQuestion(
            speakerName: speakerName.value,
            askedBy: nameController.text,
            question: questionController.text,
            eventId: eventId.value);
        if (data != null) {
          if (data["Status"]) {
            buttonLoading.value = false;
            Get.back();
            getSnackBar(
                title: 'Question Submitted',
                desc: 'Your question has been successfully submitted.',
                icon: CupertinoIcons.question,
                success: true);
          }
        }
      }
    } else {
      fixErrors(context);
    }
  }

  void getSpeakers() async {
    isLoading.value = true;
    var data = await EventServices().getSpeakers();
    if (data != null) {
      speakersModel = SpeakersModel.fromJson(data);
      isLoading.value = false;
    }
  }
}
