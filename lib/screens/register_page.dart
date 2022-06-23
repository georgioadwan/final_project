import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: 20.0
                ),
                child: Text("Create A New Account",
                  textAlign: TextAlign.center,
                  style: Constants.boldHeading,
                ),
              ),
              Column (
                children: [
                  CustomInput(
                    hintText: "Email",
                  ),
                  CustomInput(
                    hintText: "Password" ,
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: (){
                      print("Create New Account");
                    },
                    outlineBtn: false,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16.0,
                ),
                child: CustomBtn(
                  text: "Back to Login",
                  onPressed: (){
                      Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
