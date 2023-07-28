import 'package:e_commerce_app/pages/forgot_password.dart';
import 'package:e_commerce_app/pages/home.dart';
import 'package:e_commerce_app/pages/login_page.dart';
import 'package:e_commerce_app/pages/register_page.dart';
import 'package:e_commerce_app/pages/verify_Email_Page.dart';
import 'package:e_commerce_app/provider/cart.dart';
import 'package:e_commerce_app/provider/google_signin.dart';
import 'package:e_commerce_app/shared/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    
    MultiProvider(providers: [
ChangeNotifierProvider(
      create: (context) {
        return Cart();
      }),
      ChangeNotifierProvider(create: (context) {
     return GoogleSignInProvider();
    }),
    ],
    
    child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'login': (context) => Login(),
          'register': (context) => Register(),
          'home': (context) => HomePage(),
          'Password': (context) =>  ForgotPassword(),
        },
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          // initialData: initialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            } else if (snapshot.hasError) {
              return showSnackBar(context, "Something went wrong");
            } else if (snapshot.hasData) {
              return VerifyEmailPage(); //HomePage();
            } else {
              return Login();
            }
          },
        ),
      ),
    );
     
  }
}
