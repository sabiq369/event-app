import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_app/ask_questions/controller/ask_question_controller.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/internet/internet_check.dart';
import 'package:event_app/utils/internet/no_internet_page.dart';
import 'package:event_app/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AskQuestionView extends StatelessWidget {
  AskQuestionView({super.key});
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (connectivityService.isConnected.value) {
          final AskQuestionController askQuestionController =
              Get.put(AskQuestionController());
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
                    textFields(context, askQuestionController),
                  ],
                ),
              ),
            ),
          );
        } else {
          return NoInternetPage();
        }
      },
    );
  }

  textFields(
      BuildContext context, AskQuestionController askQuestionController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Form(
        key: askQuestionController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text('Select Speaker'),
            SizedBox(height: 10),
            askQuestionController.isLoading.value
                ? loader(context, false)
                : askQuestionController.speakersModel!.data.result.isEmpty
                    ? loader(context, true)
                    : DropdownMenu(
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
                        initialSelection: 0,
                        dropdownMenuEntries: askQuestionController
                            .speakersModel!.data.result
                            .map<DropdownMenuEntry<int>>(
                              (e) => DropdownMenuEntry(
                                value: e.id,
                                label: e.speakerName,
                                leadingIcon: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CachedNetworkImage(
                                    imageUrl: e.speakerImage,
                                    placeholder: (context, url) => shimmer(
                                        width: 50, height: 50, radius: 50),
                                    errorWidget: (context, url, error) =>
                                        ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                          'assets/images/place_holder.png',
                                          width: 55,
                                          height: 55),
                                    ),
                                    width: 50,
                                    height: 50,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onSelected: (value) =>
                            askQuestionController.selectSession(value),
                      ),
            SizedBox(height: 10),
            SizedBox(height: 20),
            Text('Your Name'),
            SizedBox(height: 10),
            FilledTextField(
              controller: askQuestionController.nameController,
              focusNode: askQuestionController.nameFocus,
              validator: (p0) => askQuestionController
                  .validateName(askQuestionController.nameController.text),
              errorText: askQuestionController.nameError.value,
              expand: false,
              onChange: (p0) => askQuestionController.buttonColorCheck(),
            ),
            SizedBox(height: 20),
            Text('Ask Question'),
            SizedBox(height: 10),
            SizedBox(
              height: 100,
              child: FilledTextField(
                controller: askQuestionController.questionController,
                focusNode: askQuestionController.questionFocus,
                validator: (p0) => askQuestionController.validateQuestion(
                    askQuestionController.questionController.text),
                errorText: askQuestionController.questionError.value,
                expand: true,
                onChange: (p0) => askQuestionController.buttonColorCheck(),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            askQuestionController.buttonLoading.value
                ? loadingButton(context)
                : ElevatedButton(
                    onPressed: () =>
                        askQuestionController.submitQuestion(context),
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor:
                            askQuestionController.showBrightColor.value
                                ? ColorConstants().buttonBrightColor
                                : ColorConstants().buttonLightColor,
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
          ],
        ),
      ),
    );
  }

  loader(BuildContext context, bool isEmpty) {
    return DropdownMenu(
      width: MediaQuery.of(context).size.width,
      inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          filled: true,
          fillColor: ColorConstants().contBgColor),
      trailingIcon: SizedBox(),
      enabled: false,
      selectedTrailingIcon: SizedBox(),
      leadingIcon: Icon(
        Icons.unfold_more,
        color: Colors.grey,
      ),
      initialSelection: 0,
      dropdownMenuEntries: [
        DropdownMenuEntry(
            value: 0, label: isEmpty ? 'No Speaker Available' : 'Loading...')
      ],
    );
  }
}
