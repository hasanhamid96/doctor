import 'package:doctor/screens/analyeseScreen.dart';
import 'package:doctor/widgets/detailsPostScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'model/api.dart';
import 'model/post.dart';
import 'screens/MainScreen.dart';
import 'screens/bottomNavBarScreen.dart';
import 'screens/paitntScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: Post()),
          ChangeNotifierProvider.value(value: Posts()),
          ChangeNotifierProvider.value(value: FireBaseApi()),
        ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.green,
          accentColor: Color.fromRGBO(69, 222, 191, 1),
          buttonColor: Color.fromRGBO(49, 61, 75, 1),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          textTheme: ThemeData.dark().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(69, 222, 191, 1),fontSize: 20,fontWeight: FontWeight.normal, fontFamily: 'Tajawal-Regular',),
            bodyText2: TextStyle(color: Colors.black45,fontSize: 20,fontWeight: FontWeight.normal, fontFamily: 'Tajawal-Regular',),
            headline1: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.normal, fontFamily: 'Tajawal-Regular'),
            headline2: TextStyle(color: Colors.black,fontSize: 22,fontWeight: FontWeight.bold, fontFamily: 'Tajawal-Regular'),
            headline3: TextStyle(color: Colors.black,fontSize: 15,fontWeight: FontWeight.bold, fontFamily: 'Tajawal-Regular'),
            headline4: TextStyle(color: Colors.black45,fontSize: 15,fontWeight: FontWeight.bold, fontFamily: 'Tajawal-Regular'),
            headline5: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold, fontFamily: 'Tajawal-Regular'),
          )
        ),
        routes: {
          DetailsPostScreen.routeName:(ctx)=>DetailsPostScreen(),
          PatientScreen.routeName:(ctx)=>PatientScreen(),
          AnalyseScreen.routeName:(ctx)=>AnalyseScreen(),
          BottomNavBar.routeName:(ctx)=>BottomNavBar()

        },
        home:BottomNavBar()
      ),
    );
  }
}
