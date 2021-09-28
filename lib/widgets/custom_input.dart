import 'package:flutter/material.dart';

import '../constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final IconData prefixIconData;
  final IconData suffixIconData;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isPasswordField;
  final Color color;

  CustomInput({
    this.hintText,
    this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.textInputAction,
    this.isPasswordField,
    this.color,
    this.prefixIconData,
    this.suffixIconData,
  });

  @override
  Widget build(BuildContext context) {
    bool _isPasswordField = isPasswordField ?? false;

    return Container(
      decoration: BoxDecoration(
          color: color ?? Color(0xfff2f2f2),
          borderRadius: BorderRadius.circular(12.0)),
      child: TextField(
        obscureText: _isPasswordField,
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        cursorColor: Constants.primary,
        // style: TextStyle(
        //   color: Constants.secondary,
        // ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(
              color: Constants.primary,
            ),
          ),
          border: InputBorder.none,
          // hintText: hintText ?? "Hint text...",
          // contentPadding: EdgeInsets.symmetric(
          //   horizontal: 24.0,
          //   vertical: 20.0,
          // ),
          prefixIcon: Icon(
            prefixIconData,
            color: Constants.primary,
          ),
          suffixIcon: Icon(
            suffixIconData,
            color: Constants.primary,
          ),
          labelStyle: TextStyle(
            color: Constants.primary,
          ),
          focusColor: Constants.primary,
          labelText: hintText,
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
