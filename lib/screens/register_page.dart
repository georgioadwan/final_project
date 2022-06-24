
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

  // Build an alert dialog to display an error
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: false, //this will force the dialog to only be closed
        // when the close dialog button is tapped
        builder: (context){
      return AlertDialog(
        title: Text ("Error"),
        content: Container(
          child: Text("Just some random text for now"),
        ),
        actions: [
          TextButton (
            onPressed: () { Navigator.pop(context); },
            child: Text("Close Dialog"),
          )
        ],
      );
    }
    );
  }

  // Default Form Loading State
  bool _registerFormLoading = false;

  // Form Input Field Values
  String _registerEmail = "";
  String _registerPassword = "";

  // Focus Node for the input fields
  late FocusNode _passwordFocusNode;
  @override
  void initState() {
    // TODO: implement initState
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
                    onChanged: (value){
                      _registerEmail = value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "Password" ,
                    onChanged: (value){
                      _regiterPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: (){
                      //print("Create New Account");
                      // Open the dialog
                      //_alertDialogBuilder();
                      setState(){
                        _registerFormLoading = true;
                      }
                    },
                    outlineBtn: false,
                    isLoading: _registerFormLoading,
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
                  isLoading: _registerFormLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
