import 'package:event_app/auth/login/controller/login_controller.dart';
import 'package:event_app/auth/sign_up/view/sign_up_view.dart';
import 'package:event_app/utils/colors.dart';
import 'package:event_app/utils/common_fuctions.dart';
import 'package:event_app/utils/internet/internet_check.dart';
import 'package:event_app/utils/internet/no_internet_page.dart';
import 'package:event_app/utils/textfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});
  final ConnectivityService connectivityService =
      Get.put(ConnectivityService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (connectivityService.isConnected.value) {
          final LoginController loginController = Get.put(LoginController());
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
                          style: TextStyle(
                              fontSize: 50, fontWeight: FontWeight.bold),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 35),
                          child: Text(
                            'LOG IN',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        CommonTextField(
                          controller: loginController.emailController,
                          focusNode: loginController.emailFocusNode,
                          labelText: 'Email',
                          helperText: 'Enter a valid email*',
                          keyboardType: TextInputType.emailAddress,
                          validator: (p0) => loginController.validateEmail(
                              loginController.emailController.text),
                          errorText: loginController.emailError.value,
                          onChange: (p0) => loginController.onChange(),
                        ),
                        SizedBox(height: height * 0.03),
                        CommonTextField(
                          controller: loginController.passwordController,
                          focusNode: loginController.passwordFocusNode,
                          labelText: 'Password',
                          helperText: 'Enter a password',
                          keyboardType: TextInputType.visiblePassword,
                          showPassword: true,
                          validator: (p0) => loginController.validatePassword(
                              loginController.passwordController.text),
                          errorText: loginController.passwordError.value,
                          onChange: (p0) => loginController.onChange(),
                        ),
                        SizedBox(height: height * 0.03),
                        loginController.isLoading.value
                            ? loadingButton(context)
                            : ElevatedButton(
                                onPressed: () => loginController.login(context),
                                style: ElevatedButton.styleFrom(
                                    elevation: 0,
                                    backgroundColor:
                                        loginController.showBrightColor.value
                                            ? ColorConstants().buttonBrightColor
                                            : ColorConstants().buttonLightColor,
                                    fixedSize: Size(width, 50),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(12))),
                                child: Text(
                                  'Login',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                        TextButton(
                            onPressed: () {},
                            child: Text('Forgot Password?',
                                style: buttonTextStyle())),
                        Transform(
                          transform: Matrix4.translationValues(0, -10, 0),
                          child: TextButton(
                              onPressed: () => Get.to(() => SignUpView()),
                              child: Text('Or Create an Account',
                                  style: buttonTextStyle())),
                        ),
                      ],
                    ),
                  ),
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
}
