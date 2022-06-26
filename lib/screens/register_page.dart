
import 'package:firebase_auth/firebase_auth.dart';
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
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false, //this will force the dialog to only be closed
        // when the close dialog button is tapped
        builder: (context){
      return AlertDialog(
        title: Text ("Error"),
        content: Container(
          child: Text(error),
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

  // Create a new user account
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
    return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password'){
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    // Set the form to loading state
    setState (() {
      _registerFormLoading = true;
    });

    // Run the create account method
    String? _createAccountFeedback = await _createAccount();

    // If the string is not null, we got error while creating an account
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      // Set the form to regular state (not loading)
      setState ((){
        _registerFormLoading = false;
      });
    } else {
      // The string was null, user is logged in, head back to login page
      Navigator.pop(context);
    }
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
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "Create New Account",
                    onPressed: (){
                      //print("Create New Account");
                      // Open the dialog
                      //_alertDialogBuilder();
                      _submitForm();
                      setState (() {
                        _registerFormLoading = true;
                      });
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
                  isLoading: false //_registerFormLoading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
