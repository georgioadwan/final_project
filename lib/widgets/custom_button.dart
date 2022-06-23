import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final Function onPressed;
  final bool outlineBtn;
  CustomBtn({required this.text,required this.onPressed,required this.outlineBtn});

  @override
  Widget build(BuildContext context) {
    bool? outLineBtn = outlineBtn;
    return GestureDetector(
      onTap: (){
        if (onPressed != null) {
          onPressed();
        } else {
          return;
        }
      },
      child: Container(
      height: 65.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: outLineBtn ? Colors.transparent : Colors.black,
        border: Border.all(
          color: Colors.black,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(12.0),
       ),
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0,
      ),
      child: Text (
      text ?? "Text",
        style: TextStyle(
          fontSize: 16.0,
          color: outlineBtn ? Colors.black : Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
     ),
    );
  }
}
