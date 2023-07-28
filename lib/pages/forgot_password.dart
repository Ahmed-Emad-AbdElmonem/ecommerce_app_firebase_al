import 'package:e_commerce_app/constants/custom_text_field.dart';
import 'package:e_commerce_app/constants/mainButton.dart';
import 'package:e_commerce_app/constants/navigateto.dart';
import 'package:e_commerce_app/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final emailConteroller = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  
  resetPssword()async{
  isLoading = true;
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailConteroller.text);
    if (!mounted) return;
    navigateandfinish(context, 'login');
    
    }on FirebaseAuthException catch (e) {
      showSnackBar(context, '${e.code}');
    }
    isLoading =false;
    
  }
  
  
  @override
  void dispose() {
    emailConteroller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.green,
        title: const Text(
          'Forgot Password',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(33),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter your Email to reset your password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 30,),
                CustomTextField(
                  validator: (value) {
                    // we return "null" when something is valid
                    return value!.contains(RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                        ? null
                        : "Enter a valid email";
                  },
                  suffixIcon: const Icon(Icons.email),
                  controller: emailConteroller,
                  hinttextt: "Enter your Email",
                  isPassword: false,
                  textInputTypee: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : MainButton(
                        ontap: () async {
                          if (_formKey.currentState!.validate()) {
                          resetPssword();
                          } 
                          else {
                            showSnackBar(context, 'Error');
                          }
                        },
                        txt: 'Reset Password',
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
