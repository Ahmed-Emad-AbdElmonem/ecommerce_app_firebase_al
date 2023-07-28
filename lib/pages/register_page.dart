import 'package:e_commerce_app/constants/custom_text_field.dart';
import 'package:e_commerce_app/constants/mainButton.dart';
import 'package:e_commerce_app/constants/navigateto.dart';
import 'package:e_commerce_app/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final emailConteroller = TextEditingController();

  final passConteroller = TextEditingController();
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  bool isvisible = true;

  bool isPaasword8char = false;
  bool isPaaswordhas1number = false;
  bool isPaaswordhasUpperCase = false;
  bool isPaaswordhasLowerCase = false;
  bool isPaaswordhasSpecialchar = false;
  isPaaswordChanged(String password) {
    isPaasword8char = false;
    isPaaswordhas1number = false;
    isPaaswordhasUpperCase = false;
    isPaaswordhasLowerCase = false;
    isPaaswordhasSpecialchar = false;

    setState(() {
      if (password.contains(RegExp(r'.{8,}'))) {
        isPaasword8char = true;
      }

      if (password.contains(RegExp(r'[0-9]'))) {
        isPaaswordhas1number = true;
      }

      if (password.contains(RegExp(r'[A-Z]'))) {
        isPaaswordhasUpperCase = true;
      }

      if (password.contains(RegExp(r'[a-z]'))) {
        isPaaswordhasLowerCase = true;
      }

      if (password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
        isPaaswordhasSpecialchar = true;
      }
    });
  }

  register() async {
    setState(() {
      isLoading = true;
    });
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailConteroller.text,
        password: passConteroller.text,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showSnackBar(context, 'weak password');
      } else if (e.code == 'email-already-in-use') {
        showSnackBar(context, 'The account already exists for that email.');
      } else {
        showSnackBar(context, 'please try again later');
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void dispose() {
    emailConteroller.dispose();
    passConteroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 33,
                  ),
                  CustomTextField(
                    hinttextt: "Enter your user name",
                    isPassword: false,
                    textInputTypee: TextInputType.emailAddress,
                    suffixIcon: Icon(Icons.person),
                  ),
                  CustomTextField(
                    validator: (value) {
                      // we return "null" when something is valid
                      return value!.contains(RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
                          ? null
                          : "Enter a valid email";
                    },
                    suffixIcon: Icon(Icons.email),
                    controller: emailConteroller,
                    hinttextt: "Enter your Email",
                    isPassword: false,
                    textInputTypee: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 33,
                  ),
                  CustomTextField(
                    onChanged: (password) {
                      isPaaswordChanged(password);
                    },
                    validator: (value) {
                      // we return "null" when something is valid
                      return value!.length < 8
                          ? "Enter at least 8 characters"
                          : null;
                    },
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isvisible = !isvisible;
                          });
                        },
                        icon: isvisible
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off)),
                    controller: passConteroller,
                    hinttextt: "Enter your password",
                    isPassword: isvisible ? true : false,
                    textInputTypee: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                isPaasword8char ? Colors.green : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text('at least 8 character'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPaaswordhas1number
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      SizedBox(
                        width: 11,
                      ),
                      Text('at least 1 number'),
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPaaswordhasUpperCase
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text('has uppercase'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPaaswordhasLowerCase
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text('has lower case'),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: isPaaswordhasSpecialchar
                                ? Colors.green
                                : Colors.white,
                            border: Border.all(color: Colors.grey)),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 15,
                        ),
                      ),
                      const SizedBox(
                        width: 11,
                      ),
                      const Text('has special character'),
                    ],
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
                              await register();
                              navigateandfinish(
                                context,
                                'login',
                              );
                              if (!mounted) return;
                              showSnackBar(context, 'Done ...');
                            } else {
                              showSnackBar(context, 'Error');
                            }
                          },
                          txt: 'register',
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('you have account'),
                      TextButton(
                        onPressed: () {
                          navigateandfinish(context, 'login');
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                  
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
