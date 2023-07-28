import 'package:e_commerce_app/constants/custom_text_field.dart';
import 'package:e_commerce_app/constants/mainButton.dart';
import 'package:e_commerce_app/constants/navigateto.dart';
import 'package:e_commerce_app/provider/google_signin.dart';
import 'package:e_commerce_app/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailConteroller = TextEditingController();

  final passConteroller = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailConteroller.text,
        password: passConteroller.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackBar(context, 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showSnackBar(context, 'Wrong password provided for that user.');
      } else {
        showSnackBar(context, 'Error...');
      }
    }
  }

  @override
  void dispose() {
    emailConteroller.dispose();
    passConteroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final googleSignInProvider = Provider.of<GoogleSignInProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  SizedBox(
                    height: 33,
                  ),
                  CustomTextField(
                    controller: emailConteroller,
                    hinttextt: "Enter your Email",
                    isPassword: false,
                    textInputTypee: TextInputType.emailAddress,
                  ),
                  SizedBox(
                    height: 33,
                  ),
                  CustomTextField(
                    controller: passConteroller,
                    hinttextt: "Enter your password",
                    isPassword: true,
                    textInputTypee: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.green,
                        )
                      : MainButton(
                          ontap: () async {
                            if (_formKey.currentState!.validate()) {
                              await signIn();

                              if (!mounted) return;
                              // showSnackBar(context, 'Done ...');
                            } else {
                              showSnackBar(context, 'Error');
                            }
                          },
                          txt: 'Login',
                        ),

                  TextButton(onPressed: () {
                    navigateandfinish(context, 'Password');
                  }, child:const Text('Forgot Password')),
                 
                 
                 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    const  Text('you dont have account'),
                      TextButton(
                        onPressed: () {
                          navigateandfinish(context, 'register');
                        },
                        child: Text('Sign UP'),
                      ),
                    ],
                  ),
                  Text('or'),
                  Divider(
                    color: Colors.black,
                  ),
                  MainButton(txt: 'Google', ontap: () {
                    googleSignInProvider.googlelogin();
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
