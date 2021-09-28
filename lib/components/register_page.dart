import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:holy_gram/widgets/customButton.dart';
import 'package:holy_gram/widgets/custom_input.dart';
import 'package:holy_gram/widgets/waves.dart';

import '../constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //build alert dialogbox
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Oops.."),
          content: Container(
            child: Text(error),
          ),
          actions: [
            TextButton(
              child: Text("Close Dialog"),
              onPressed: () {
                Navigator.pop(context);
              },
            )
          ],
        );
      },
    );
  }

  //create user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        return ('The account already exists for that email.');
      }
      return e.message;
    } catch (e) {
      return (e.toString());
    }
  }

  void _submitForm() async {
    //initiate loading state
    setState(() {
      _registerFormLoading = true;
    });

    //run the create acc method
    String _createAccountFeedback = await _createAccount();

    //if the string is not null, then we get the error message
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);

      //set form to regular state
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      //the string is Null, then this sends user to homepage
      Navigator.pop(context);
    }
  }

  //default form loading state
  bool _registerFormLoading = false;

  //form input values
  String _registerEmail = "";
  String _registerPassword = "";

  //focus Node for input fields
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height - 200,
            color: Constants.primary,
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeOutQuad,
            top: keyboardOpen ? -size.height / 3.7 : 0.0,
            child: Waves(
              size: size,
              yOffset: size.height / 3.0,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(
                //     top: 24.0,
                //   ),
                //   child: Text(
                //     "Create New Account",
                //     textAlign: TextAlign.center,
                //     style: Constants.boldHeading,
                //   ),
                // ),

                CustomInput(
                  prefixIconData: Icons.mail_outline,
                  hintText: "Email",
                  onChanged: (value) {
                    _registerEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                SizedBox(height: 8.0),
                CustomInput(
                  prefixIconData: Icons.lock_outlined,
                  // suffixIconData: Icons.eye,
                  hintText: "Password",
                  onChanged: (value) {
                    _registerPassword = value;
                  },
                  focusNode: _passwordFocusNode,
                  isPasswordField: true,
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                SizedBox(height: 8.0),
                CustomButton(
                  text: "Create New Account",
                  onPressed: () {
                    _submitForm();
                  },
                  isLoading: _registerFormLoading,
                ),
                SizedBox(height: 24.0),
                CustomButton(
                  text: "Back to Login",
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
