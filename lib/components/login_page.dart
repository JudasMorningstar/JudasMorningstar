import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:holy_gram/components/register_page.dart';
import 'package:holy_gram/widgets/customButton.dart';
import 'package:holy_gram/widgets/custom_input.dart';
import 'package:holy_gram/widgets/waves.dart';

import '../constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //build alert dialogbox
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              TextButton(
                child: Text("Close Dialog"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  // Create a new user account
  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _loginEmail, password: _loginPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
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
    setState(() {
      _loginFormLoading = true;
    });

    // Run the create account method
    String _loginFeedback = await _loginAccount();

    // If the string is not null, we got error while create account.
    if (_loginFeedback != null) {
      _alertDialogBuilder(_loginFeedback);

      // Set the form to regular state [not loading].
      setState(() {
        _loginFormLoading = false;
      });
    }
  }

  //default form loading state
  bool _loginFormLoading = false;

  //form input values
  String _loginEmail = "";
  String _loginPassword = "";

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
      body: SafeArea(
        child: Stack(
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
                    "Login",
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
                  CustomInput(
                    prefixIconData: Icons.mail_outline,
                    hintText: "Email",
                    onChanged: (value) {
                      _loginEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 8.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CustomInput(
                        prefixIconData: Icons.lock_outlined,
                        hintText: "Password",
                        onChanged: (value) {
                          _loginPassword = value;
                        },
                        focusNode: _passwordFocusNode,
                        isPasswordField: true,
                        onSubmitted: (value) {
                          _submitForm();
                        },
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            color: Constants.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                  CustomButton(
                    outlineBtn: false,
                    text: "Login",
                    onPressed: () {
                      _submitForm();
                    },
                    isLoading: _loginFormLoading,
                  ),
                  SizedBox(height: 8.0),
                  CustomButton(
                    text: "Create New Account",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterPage(),
                        ),
                      );
                    },
                    outlineBtn: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
