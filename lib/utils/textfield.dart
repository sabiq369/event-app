import 'package:event_app/utils/colors.dart';
import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  const CommonTextField(
      {super.key,
      required this.controller,
      required this.labelText,
      required this.focusNode,
      required this.helperText,
      this.validator,
      this.onChange,
      this.showPassword = false,
      this.keyboardType,
      this.errorText,
      this.textCapitalization = TextCapitalization.none,
      this.hintText});
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final String labelText;
  final String helperText;
  final void Function(String)? onChange;
  final bool showPassword;
  final TextInputType? keyboardType;
  final String? errorText;
  final TextCapitalization textCapitalization;
  final String? hintText;

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
      textCapitalization: widget.textCapitalization,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: widget.showPassword
          ? visibility
              ? true
              : false
          : false,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        hintText: widget.hintText,
        helperText: widget.helperText,
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

class FilledTextField extends StatelessWidget {
  const FilledTextField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.expand,
    this.validator,
    this.onChange,
    this.errorText,
  });
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final String? errorText;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      onChanged: onChange,
      validator: validator,
      minLines: expand ? null : 1,
      maxLines: expand ? null : 1,
      expands: expand ? true : false,
      textInputAction: TextInputAction.next,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        errorText: errorText,
        filled: true,
        fillColor: ColorConstants().contBgColor,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
