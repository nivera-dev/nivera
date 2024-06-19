import 'package:flutter/material.dart';
import 'package:niveraapp/constants.dart';


class CustomTextFormField extends StatelessWidget {

  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      //enabled: enabled,
      controller: controller,
      keyboardType: textInputType,
      onSaved: (value) => {},//onSaved(value!),
      cursorColor: ColorPalette.subColor,
      style: const TextStyle(color: Colors.black),
      obscureText: obscureText,
      /*validator: (value) {
        return RegExp(regEx).hasMatch(value!) ? null : 'Enter a valid value!';
      },*/
      decoration: InputDecoration(
        fillColor: ColorPalette.greyFloor,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0),
            borderSide: const BorderSide(
              width: 0,
              style: BorderStyle.none,
            )
        ),
        hintText: hintText,
        hintStyle: mRobotoBold.copyWith(color: const Color(0xff797979)),
      ),
    );
  }
}