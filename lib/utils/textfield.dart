import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonTextField extends StatefulWidget {
  CommonTextField(
      {Key? key,
      required this.controller,
      required this.labelText,
      required this.focusNode,
      this.validator,
      this.onChange,
      this.showPassword = false,
      this.keyboardType,
      this.errorText})
      : super(key: key);
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final String labelText;
  final void Function(String)? onChange;
  final bool showPassword;
  final TextInputType? keyboardType;
  final String? errorText;

  @override
  State<CommonTextField> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  bool visibility = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      onChanged: widget.onChange,
      validator: widget.validator,
      textInputAction: TextInputAction.next,
      obscureText: widget.showPassword
          ? visibility
              ? true
              : false
          : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        suffixIcon: widget.showPassword
            ? GestureDetector(
                onTap: () => changeVisibility(),
                child:
                    Icon(visibility ? Icons.visibility_off : Icons.visibility),
              )
            : SizedBox(),
      ),
    );
  }

  changeVisibility() {
    setState(() {
      visibility = !visibility;
    });
  }
}
