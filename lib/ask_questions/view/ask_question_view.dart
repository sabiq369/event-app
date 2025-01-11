import 'package:event_app/ask_questions/controller/ask_question_controller.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskQuestionView extends StatelessWidget {
  AskQuestionView({Key? key}) : super(key: key);
  final AskQuestionController _askQuestionController =
      Get.put(AskQuestionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalScaffoldKey,
      endDrawer: openDrawer(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              commonAppBar(title: 'ASK QUESTION'),
              textFields(context),
            ],
          ),
        ),
      ),
    );
  }

  textFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: _askQuestionController.formKey,
        child: Obx(() {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text('Select Session'),
              SizedBox(height: 10),
              DropdownMenu(
                width: MediaQuery.of(context).size.width,
                inputDecorationTheme: InputDecorationTheme(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: ColorConstants().contBgColor),
                trailingIcon: SizedBox(),
                selectedTrailingIcon: SizedBox(),
                leadingIcon: Icon(
                  Icons.unfold_more,
                  color: Colors.grey,
                ),
                dropdownMenuEntries: [
                  DropdownMenuEntry(value: 1, label: 'Session 1'),
                  DropdownMenuEntry(value: 2, label: 'Session 2'),
                  DropdownMenuEntry(value: 3, label: 'Session 3'),
                  DropdownMenuEntry(value: 4, label: 'Session 4'),
                ],
              ),
              SizedBox(height: 20),
              Text('Your Name'),
              SizedBox(height: 10),
              filledTextField(
                controller: _askQuestionController.nameController,
                focusNode: _askQuestionController.nameFocus,
                validator: (p0) => _askQuestionController.nameController.text,
                errorText: _askQuestionController.nameError.value,
                expand: false,
              ),
              SizedBox(height: 20),
              Text('Ask Question'),
              SizedBox(height: 10),
              SizedBox(
                height: 100,
                child: filledTextField(
                  controller: _askQuestionController.questionController,
                  focusNode: _askQuestionController.questionFocus,
                  validator: (p0) =>
                      _askQuestionController.questionController.text,
                  errorText: _askQuestionController.questionError.value,
                  expand: true,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              Obx(() {
                return ElevatedButton(
                  onPressed: () {
                    if (_askQuestionController.formKey.currentState
                            ?.validate() ??
                        false) {
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Please fix the errors')));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor:
                          _askQuestionController.showBrightColor.value
                              ? ColorConstants().buttonLightColor
                              : ColorConstants().buttonLightColor,
                      fixedSize: Size(MediaQuery.of(context).size.width, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    _askQuestionController.isLoading.value
                        ? 'Loading...'
                        : 'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }),
            ],
          );
        }),
      ),
    );
  }
}
