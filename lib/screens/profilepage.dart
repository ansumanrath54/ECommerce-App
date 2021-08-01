import 'package:ecommerce_app/screens/mainpage0.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/loginpage.dart';
import 'package:ecommerce_app/screens/signup.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../services/SharePrefs.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final googleSignIn = GoogleSignIn();
  User? user = FirebaseAuth.instance.currentUser;

  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Welcome',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30
                    ),),
                    SizedBox(height: 10,),
                    user != null
                        ? Text("${user?.email.toString()}",
                      style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20, color: Colors.green),
                    )
                        : Text("Guest",
                      style: TextStyle( fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
                    ),
                    SizedBox(height: 15,),
                    Text('Automatic identity verification which enables you to verify the identity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 15
                      ),)
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/Illustration.jpg')
                      )
                  ),
                ),
                Column(
                  children: [
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => (LoginPage())));
                      },
                      color: Colors.greenAccent,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.black
                          ),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text('Login', style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18
                      ),),
                    ),
                    SizedBox(height: 20,),
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
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => (SignupPage())));
                        },
                        color: Colors.yellow,
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
                    TextButton(
                      onPressed: () async {
                        try {
                          await googleSignIn.disconnect();
                        }
                        catch(e) {
                          print(e);
                        }
                        await FirebaseAuth.instance.signOut();
                        await LocalSharedPreference.clearToken();
                        final snackBar = SnackBar(
                          content: Text("You're logged out!"),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage0()));
                      },
                      child: Text('Log Out',style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: Colors.black
                      ),),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
