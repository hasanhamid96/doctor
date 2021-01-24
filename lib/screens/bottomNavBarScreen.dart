import 'package:connectivity/connectivity.dart';
import 'package:doctor/screens/MainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:unicons/unicons.dart';
import 'aboutScreeen.dart';
import 'logInScreen.dart';

class BottomNavBar extends StatefulWidget {
  static var routeName='/s';
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  List<Widget> _Screens=[
    MainScreen(),
    LogInScreen(),
    AboutScreen(),
  ];
  int _index=0;
  bool isConnect=true;
  void onTap(int tap){
    setState(() {
      _index=tap;
    });
  }
  void connect()async{
    var connectivity=await Connectivity().checkConnectivity();
    if(connectivity!=ConnectivityResult.mobile&&connectivity!=ConnectivityResult.wifi){
      setState(() {
        isConnect=false;
      });
    }
    else {
      setState(() {
        isConnect=true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    connect();
    return Scaffold(
      extendBody: true,
      backgroundColor: isConnect?Colors.transparent:Colors.white,
      body:isConnect?_Screens[_index]:
     Center(child: Text('no internet please connect to WiFi',style: Theme.of(context).textTheme.headline2,),),
      bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(25),
              topLeft: Radius.circular(25)
          ),
        child:BottomNavigationBar(
          selectedIconTheme: IconThemeData(color: Theme.of(context).accentColor),
          currentIndex: _index,
          onTap: onTap,
          selectedItemColor: Theme.of(context).accentColor,
          unselectedItemColor: Colors.black,
          unselectedLabelStyle: Theme.of(context).textTheme.headline1,
         selectedLabelStyle: Theme.of(context).textTheme.bodyText1,
          items: [
            BottomNavigationBarItem(

            icon: Icon(UniconsLine.polygon ,size: 30),
          title: Text('الرئيسية' )

            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.flask,size: 30),
                title: Text('التحاليل',)

            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.analytics,size: 30),
                title: Text('المختبر',)

            )
          ],
        ),
      ),
    );
  }
}

