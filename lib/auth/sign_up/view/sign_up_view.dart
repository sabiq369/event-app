import 'package:event_app/auth/sign_up/controller/sign_up_controller.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key}) : super(key: key);
  final SignUpController signUpController = Get.put(SignUpController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: SizedBox(),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SizedBox(
              child: Column(
                // spacing: 20,
                children: [
                  Divider(),
                  textFields(context),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  textFields(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.nameController,
              focusNode: signUpController.nameFocusNode,
              labelText: 'Name*',
              keyboardType: TextInputType.name,
              validator: (p0) => signUpController
                  .validateName(signUpController.nameController.text),
              errorText: signUpController.nameError.value,
              textCapitalization: TextCapitalization.words,
              onChange: (p0) => signUpController.nameOnChange(),
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.emailController,
              focusNode: signUpController.emailFocus,
              labelText: 'Email*',
              keyboardType: TextInputType.emailAddress,
              validator: (p0) => signUpController
                  .validateEmail(signUpController.emailController.text),
              errorText: signUpController.emailError.value,
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.passwordController,
              focusNode: signUpController.passwordFocusNode,
              labelText: 'Password*',
              keyboardType: TextInputType.visiblePassword,
              showPassword: true,
              validator: (p0) => signUpController
                  .validatePassword(signUpController.passwordController.text),
              errorText: signUpController.passwordError.value,
            ),
            SizedBox(height: 20),
            DropdownMenu(
              width: MediaQuery.of(context).size.width,
              initialSelection: 0,
              inputDecorationTheme:
                  InputDecorationTheme(border: InputBorder.none),
              trailingIcon: Icon(
                Icons.unfold_more,
                color: Colors.grey,
              ),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 0, label: 'Select Speciality*'),
                DropdownMenuEntry(value: 1, label: 'Speciality 1'),
                DropdownMenuEntry(value: 2, label: 'Speciality 2'),
                DropdownMenuEntry(value: 3, label: 'Speciality 3'),
                DropdownMenuEntry(value: 4, label: 'Speciality 4'),
              ],
            ),
            DropdownMenu(
              width: MediaQuery.of(context).size.width,
              initialSelection: 0,
              trailingIcon: Icon(Icons.keyboard_arrow_down),
              inputDecorationTheme:
                  InputDecorationTheme(border: InputBorder.none),
              dropdownMenuEntries: [
                DropdownMenuEntry(value: 0, label: 'Select Country*'),
                DropdownMenuEntry(value: 1, label: 'UAE'),
                DropdownMenuEntry(value: 2, label: 'India'),
                DropdownMenuEntry(value: 3, label: 'Saudi'),
                DropdownMenuEntry(value: 4, label: 'Kuwait'),
              ],
              onSelected: (value) => print(value),
            ),
            Divider(),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.mobileNumController,
              focusNode: signUpController.mobileFocus,
              labelText: 'Mobile Number*',
              keyboardType: TextInputType.phone,
              validator: (p0) => signUpController
                  .validateMobile(signUpController.mobileNumController.text),
              errorText: signUpController.mobileError.value,
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.instaLinkController,
              focusNode: signUpController.instaFocus,
              labelText: 'Instagram @',
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.tikTokLindController,
              focusNode: signUpController.tikTokFocus,
              labelText: 'TikTok @',
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Checkbox(
                value: signUpController.userConsent.value,
                onChanged: (value) => signUpController.toggleCheckBox(),
              ),
              title: GestureDetector(
                onTap: () => signUpController.toggleCheckBox(),
                child: Column(
                  children: [
                    Text(
                        "By ticking this box, you give your consent to L'Oréal to process the provided data for the following purposes:Fulfilling L'Oréal requirements to report and record the identity of the attendees in its activities and events Use for compliance purposes and reporting according to L'Oréal and country-specific compliance regulations and code of conduct"),
                    SizedBox(height: 10),
                    Divider()
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  signUpController.signUp();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please fix the errors')));
                }
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  backgroundColor: signUpController.showBrightColor.value
                      ? ColorConstants().buttonLightColor
                      : ColorConstants().buttonLightColor,
                  fixedSize: Size(MediaQuery.of(context).size.width, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12))),
              child: Text(
                signUpController.isLoading.value ? 'Loading...' : 'Register',
                style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}

class TextCapitalizationFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final text = newValue.text;
    final capitalized = text.split(' ').map((word) {
      if (word.isEmpty) return word;
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
    return newValue.copyWith(
      text: capitalized,
      selection: TextSelection.collapsed(offset: capitalized.length),
    );
  }
}
