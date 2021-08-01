import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/loginpage.dart';
import 'package:ecommerce_app/screens/mainpage0.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/api.dart';


class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  late String email;
  late String password;
  late String confirmPassword;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back,size: 20,color: Colors.black,),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Text('Sign up', style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),),
                  SizedBox(height: 20,),
                  Text('Create an account', style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey[700]
                  ),)
                ],
              ),
              Column(
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: "Email"),
                    onChanged: (value){
                      email=value;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Password"),
                    onChanged: (value){
                      password=value;
                    },
                    obscureText: true,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: "Confirm Password"),
                    onChanged: (value){
                      confirmPassword=value;
                    },
                    obscureText: true,
                  ),

                ],
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 3,left: 3),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async{
                        signUpUser();
                      },
                      color: Colors.lightBlueAccent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text('Sign up', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                        },
                        child: Text(' Login',style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18
                        ),),
                      )
                    ],
                  ),
                  SignInButton(
                    Buttons.Google,
                    text: "Sign up with Google",
                    onPressed: () async {
                      signinGoogle();
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> signinGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    final snackBar = SnackBar(
      content: Text("You're signed in successfully!"),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);

    await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage0()));
      await Api.loginUser(value.user!);
    });
  }

  Future<void> signUpUser() async {
    if(password.toString() == confirmPassword.toString())
    {
      try{
        await auth.createUserWithEmailAndPassword(
            email: email, password: password).then((value) async {
              await Api.loginUser(value.user!);
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage0()));
        });
      }
      catch(e){
        showDialog(context: context, builder: (ctx) => AlertDialog(
          title: Text("Information"),
          content: Text("Please input correct Email"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text("OK"),
            ),
          ],
        ),
        );
      }
    }
    else
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: Text("Alert!"),
        content: Text("Password did not match"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("OK"),
          ),
        ],
      ),
      );
  }
}
