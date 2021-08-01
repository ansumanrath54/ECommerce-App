import 'package:ecommerce_app/screens/mainpage0.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 230.0),
              child: Text(
                'SkillKart',
                style: TextStyle(
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 320),
              child: Text(
                'Powered By',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Image(
                  image: AssetImage('assets/images/Zairzalogo.jpg'),
                  width: 271.0,
                  height: 52.0,
                )
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => (MainPage0())));
        },
        child: Icon(Icons.navigate_next)
      ),
    );
  }
}
