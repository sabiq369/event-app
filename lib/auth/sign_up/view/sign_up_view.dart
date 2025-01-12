import 'package:event_app/auth/sign_up/controller/sign_up_controller.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/internet/internet_check.dart';
import 'package:event_app/utils/internet/no_internet_page.dart';
import 'package:event_app/utils/textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final _formKey = GlobalKey<FormState>();
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (connectivityService.isConnected.value) {
        final SignUpController signUpController = Get.put(SignUpController());
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
                  children: [
                    Divider(),
                    textFields(context, signUpController),
                  ],
                ),
              ),
            ),
          ),
        );
      } else {
        return NoInternetPage();
      }
    });
  }

  textFields(BuildContext context, SignUpController signUpController) {
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
              labelText: 'Full Name',
              helperText: 'Enter Full Name*',
              keyboardType: TextInputType.name,
              validator: (p0) => signUpController
                  .validateName(signUpController.nameController.text),
              errorText: signUpController.nameError.value,
              textCapitalization: TextCapitalization.words,
              onChange: (p0) => signUpController.checkButtonColor(),
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.emailController,
              focusNode: signUpController.emailFocus,
              labelText: 'Email',
              helperText: 'Enter a valid email*',
              keyboardType: TextInputType.emailAddress,
              validator: (p0) => signUpController
                  .validateEmail(signUpController.emailController.text),
              errorText: signUpController.emailError.value,
              onChange: (p0) => signUpController.checkButtonColor(),
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.passwordController,
              focusNode: signUpController.passwordFocusNode,
              labelText: 'Password',
              helperText: 'Enter a password*',
              keyboardType: TextInputType.visiblePassword,
              showPassword: true,
              validator: (p0) => signUpController
                  .validatePassword(signUpController.passwordController.text),
              errorText: signUpController.passwordError.value,
              onChange: (p0) => signUpController.checkButtonColor(),
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
              onSelected: (value) => signUpController.selectSpeciality(value),
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
                DropdownMenuEntry(value: 2, label: 'KSA'),
                DropdownMenuEntry(value: 3, label: 'EGYPT'),
                DropdownMenuEntry(value: 4, label: 'SPAIN'),
                DropdownMenuEntry(value: 5, label: 'UK'),
                DropdownMenuEntry(value: 6, label: 'USA'),
              ],
              onSelected: (value) => signUpController.selectCountry(value),
            ),
            Divider(),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.mobileNumController,
              focusNode: signUpController.mobileFocus,
              labelText: 'Mobile Number',
              helperText: 'Enter Mobile Number*',
              hintText: 'eg: 0501234567',
              keyboardType: TextInputType.phone,
              validator: (p0) => signUpController.validateUaeMobileNumber(
                  signUpController.mobileNumController.text),
              errorText: signUpController.mobileError.value,
              onChange: (p0) => signUpController.checkButtonColor(),
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.instaLinkController,
              focusNode: signUpController.instaFocus,
              labelText: 'Instagram @',
              helperText: 'Instagram @',
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 20),
            CommonTextField(
              controller: signUpController.tikTokLindController,
              focusNode: signUpController.tikTokFocus,
              labelText: 'TikTok @',
              helperText: 'TikTok @',
              keyboardType: TextInputType.url,
            ),
            SizedBox(height: 20),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  value: signUpController.userConsent.value,
                  onChanged: (value) => signUpController.toggleCheckBox(),
                  activeColor: ColorConstants().buttonBrightColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  side: BorderSide(color: ColorConstants().buttonLightColor),
                ),
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
            signUpController.isLoading.value
                ? loadingButton(context)
                : ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        if (signUpController.country.value == 0) {
                          getSnackBar(
                              title: "Country Not Selected",
                              desc:
                                  "Please choose a country from the dropdown to proceed.",
                              icon: CupertinoIcons.globe);
                        } else if (signUpController.speciality.value == 0) {
                          getSnackBar(
                              title: "Speciality Not Selected",
                              desc:
                                  "Please choose a speciality from the dropdown to proceed.",
                              icon: CupertinoIcons.person_crop_circle);
                        } else if (!signUpController.userConsent.value) {
                          getSnackBar(
                              title: "Consent Required",
                              desc:
                                  "We need your consent to proceed. Please review and accept our terms.",
                              icon: CupertinoIcons.checkmark_circle_fill);
                        }
                        if (signUpController.showBrightColor.value) {
                          signUpController.signUp();
                        }
                      } else {
                        fixErrors(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: signUpController.showBrightColor.value
                            ? ColorConstants().buttonBrightColor
                            : ColorConstants().buttonLightColor,
                        fixedSize: Size(MediaQuery.of(context).size.width, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12))),
                    child: Text(
                      signUpController.isLoading.value
                          ? 'Loading...'
                          : 'Register',
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
