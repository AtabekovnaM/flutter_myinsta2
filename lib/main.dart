import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta2/pages/home_page.dart';
import 'package:flutter_myinsta2/pages/signin_page.dart';
import 'package:flutter_myinsta2/pages/signup_page.dart';
import 'package:flutter_myinsta2/pages/splash_page.dart';
import 'package:flutter_myinsta2/services/prefs_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  Widget _callStartPage() {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          Prefs.saveUserId(snapshot.data.uid);
          return SplashPage();
        } else {
          Prefs.removeUserId();
          return SignInPage();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _callStartPage(),
      routes: {
        SplashPage.id: (context) =>SplashPage(),
        SignInPage.id: (context) =>SignInPage(),
        SignUpPage.id: (context) =>SignUpPage(),
        HomePage.id: (context) =>HomePage(),
      },
    );
  }
}

