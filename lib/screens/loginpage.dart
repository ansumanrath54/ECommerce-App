import 'package:ecommerce_app/screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_app/screens/mainpage0.dart';
import 'package:flutter_signin_button/button_list.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ecommerce_app/services/api.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final auth=FirebaseAuth.instance;
  late String email;
  late String password;


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Text('Login', style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold
                        ),),
                        SizedBox(height: 20,),
                        Text('Login to your account', style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700]
                        ),)
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
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
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
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
                            loginUser();
                          },
                          color: Colors.lightBlueAccent,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Text('Login', style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18
                          ),),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            TextButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                              },
                              child: Text(' Sign Up',style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18
                              ),),
                            )
                          ],
                        ),
                        SignInButton(
                          Buttons.Google,
                          text: "Sign in with Google",
                          onPressed: () async {
                            loginGoogle();
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.7,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/background.jpg'),
                        fit: BoxFit.cover
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void loginUser() async{
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password)
        .then((FirebaseUser) async{
      await Api.loginUser(FirebaseUser.user!);
      final snackBar = SnackBar(
        content: Text("You're successfully logged in!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage0()));
    })
        .catchError((e){
      print(e);
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: Text("Alert!"),
        content: Text("Invalid Email or Password"),
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
    });
  }

  Future<void> loginGoogle() async {
    await FirebaseAuth.instance.signOut();
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
}
