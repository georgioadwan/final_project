
import 'package:final_project/constants.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String? hintText;
  final Function? onChanged;
  final Function? onSubmitted;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final bool? isPasswordField;
  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isPasswordField });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 24.0,
      ),
      decoration: BoxDecoration(
        color: Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: TextField(
        obscureText: isPasswordField ?? false,
        focusNode: focusNode,
        onChanged: (value) {
          if (onChanged != null) {
            onChanged! (value);
          } else {
            return;
          }
        },
        textInputAction: textInputAction,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          )
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
