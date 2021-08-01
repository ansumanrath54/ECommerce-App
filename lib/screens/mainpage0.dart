import 'package:ecommerce_app/others/cart_icon.dart';
import 'package:ecommerce_app/screens/my_cart.dart';
import 'package:ecommerce_app/screens/profilepage.dart';
import 'package:ecommerce_app/screens/mainpage.dart';
import 'package:ecommerce_app/screens/orderpage.dart';
import 'package:flutter/material.dart';

class MainPage0 extends StatefulWidget {
  const MainPage0({Key? key}) : super(key: key);

  @override
  _MainPage0State createState() => _MainPage0State();
}

class _MainPage0State extends State<MainPage0> {

  int _currentIndex = 0;
  var _pagesData =[MainPage(), OrderPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pagesData[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap:(newIndex) => setState((){_currentIndex = newIndex;}),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.orangeAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Search',
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text('My Orders',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              title: Text('Profile',
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
              backgroundColor: Colors.white
          ),
        ],
      ),
    );
  }
}
