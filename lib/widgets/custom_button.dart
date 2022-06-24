import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String? text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;
  CustomBtn({required this.text,required this.onPressed,required this.outlineBtn, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    bool? outLineBtn = outlineBtn;
    bool? _isLoading = isLoading;
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
      child: Stack(
        children: [
          Visibility(
            visible: _isLoading ? false : true,
            child: Center(
              child: Text (
              text ?? "Text",
                style: TextStyle(
                  fontSize: 16.0,
                  color: outlineBtn ? Colors.black : Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Visibility(
            visible: _isLoading,
            child: Center(
              child: SizedBox(
                height: 30.0,
                width: 30.0,
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
     ),
    );
  }
}
