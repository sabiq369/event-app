import 'package:event_app/auth/login/controller/login_controller.dart';
import 'package:event_app/auth/sign_up/view/sign_up_view.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: SizedBox(
            width: width,
            height: height,
            child: Form(
              key: loginController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'LDB ME',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.05),
                  Text(
                    'LOG IN',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: height * 0.04),
                  Obx(() {
                    return CommonTextField(
                      controller: loginController.emailController,
                      focusNode: loginController.emailFocusNode,
                      labelText: 'Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (p0) => loginController
                          .validateEmail(loginController.emailController.text),
                      errorText: loginController.emailError.value,
                    );
                  }),
                  SizedBox(height: height * 0.03),
                  CommonTextField(
                    controller: loginController.passwordController,
                    focusNode: loginController.passwordFocusNode,
                    labelText: 'Password*',
                    keyboardType: TextInputType.visiblePassword,
                    showPassword: true,
                    validator: (p0) => loginController.validatePassword(
                        loginController.passwordController.text),
                    errorText: loginController.passwordError.value,
                  ),
                  SizedBox(height: height * 0.03),
                  Obx(() {
                    return ElevatedButton(
                      onPressed: () {
                        if (loginController.formKey.currentState?.validate() ??
                            false) {
                          loginController.login();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Please fix the errors')));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: loginController.showBrightColor.value
                              ? ColorConstants().buttonLightColor
                              : ColorConstants().buttonLightColor,
                          fixedSize: Size(width, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12))),
                      child: Text(
                        loginController.isLoading.value
                            ? 'Loading...'
                            : 'Login',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
                  TextButton(
                      onPressed: () {},
                      child:
                          Text('Forget Password?', style: buttonTextStyle())),
                  Transform(
                    transform: Matrix4.translationValues(0, -10, 0),
                    child: TextButton(
                        onPressed: () => Get.to(() => SignUpView()),
                        child: Text('Or Create an Account',
                            style: buttonTextStyle())),
                  ),
                  // SizedBox(height: height * 0.1)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
