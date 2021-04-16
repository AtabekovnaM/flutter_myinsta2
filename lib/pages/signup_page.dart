import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myinsta2/model/user_model.dart';
import 'package:flutter_myinsta2/pages/home_page.dart';
import 'package:flutter_myinsta2/pages/signin_page.dart';
import 'package:flutter_myinsta2/services/auth_service.dart';
import 'package:flutter_myinsta2/services/data_service.dart';
import 'package:flutter_myinsta2/services/prefs_service.dart';
import 'package:flutter_myinsta2/services/utils_service.dart';

class SignUpPage extends StatefulWidget {
  static final String id = 'signup_page';
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;
  var emailController = TextEditingController();
  var fullnameController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  _doSignUp(){
    String name = fullnameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();
    if(name.isEmpty || email.isEmpty || password.isEmpty) return;
    if(password != cpassword){
      Utils.fireToast("Password and confirm password does not match");
      return;
    }
    //#EmailValidation

    //#PasswordValidation

    setState(() {
      isLoading = true;
    });
    User user = new User(fullname: name, email: email, password: password);
    AuthService.signUpUser(context, name, email, password).then((
        value) =>
    {
      _getFirebaseUser(user, value),
    });
  }

  _getFirebaseUser(User user, Map<String, FirebaseUser> map) async {
    setState(() {
      isLoading = false;
    });
    FirebaseUser firebaseUser;
    if (!map.containsKey("SUCCESS")) {
      if (map.containsKey("ERROR_EMAIL_ALREADY_IN_USE"))
        Utils.fireToast("Email already in use");
      if (map.containsKey("ERROR"))
        Utils.fireToast("Try again later");
      return;
    }
    firebaseUser = map["SUCCESS"];
    if (firebaseUser == null) return;

    await Prefs.saveUserId(firebaseUser.uid);
    DataService.storeUser(user).then((value) => {
      Navigator.pushReplacementNamed(context, HomePage.id),
    });
  }

  _callSignInPage(){
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20),
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromRGBO(252,175,69,1),
                      Color.fromRGBO(245,96,64,1),
                    ]
                ),
              ),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Instagram",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 45,
                                  fontFamily: "Billabong"
                              ),
                            ),
                            SizedBox(height: 20,),
                            // #fullname
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: fullnameController,
                                decoration: InputDecoration(
                                  hintText: "Fullname",
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(fontSize: 17.0,color: Colors.white54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            // #email
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: emailController,
                                decoration: InputDecoration(
                                  hintText: "Email",
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(fontSize: 17.0,color: Colors.white54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            // #password
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(fontSize: 17.0,color: Colors.white54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            // #cpassword
                            Container(
                              height: 50,
                              padding: EdgeInsets.only(left: 10,right: 10),
                              decoration: BoxDecoration(
                                color: Colors.white54.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: TextField(
                                style: TextStyle(color: Colors.white),
                                controller: cpasswordController,
                                decoration: InputDecoration(
                                  hintText: "Confirm Password",
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(fontSize: 17.0,color: Colors.white54),
                                ),
                              ),
                            ),
                            SizedBox(height: 10,),
                            // #signup
                            GestureDetector(
                              onTap: (){
                                _doSignUp();
                              },
                              child: Container(
                                  height: 50,
                                  padding: EdgeInsets.only(left: 10,right: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white54.withOpacity(0.2), width: 2
                                    ),
                                    borderRadius: BorderRadius.circular(7),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign Up",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17
                                      ),
                                    ),
                                  )
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account",
                              style: TextStyle(color: Colors.white,fontSize: 16),
                            ),
                            SizedBox(width: 10,),
                            GestureDetector(
                              onTap: _callSignInPage,
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),

                  isLoading ?
                  Center(
                    child: CircularProgressIndicator(),
                  ): SizedBox.shrink(),
                ],
              )
          ),
        )
    );
  }
}
