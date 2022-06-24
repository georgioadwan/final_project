import 'package:final_project/screens/register_page.dart';
import 'package:final_project/widgets/custom_button.dart';
import 'package:final_project/widgets/custom_input.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
              top: 24.0
            ),
            child: Text("Welcome User, \nLogin to your account",
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
                text: "Login",
                onPressed: (){
                  print("Click to login");
                },
                outlineBtn: false,
                isLoading: false,
              ),
            ],
          ),
          Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ),
              child: CustomBtn(
            text: "Create New Account",
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RegisterPage())
              );
            },
            outlineBtn: true,
                isLoading: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
