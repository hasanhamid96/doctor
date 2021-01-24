import 'package:doctor/model/api.dart';
import 'package:doctor/screens/paitntScreen.dart';
import 'package:doctor/widgets/showDialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;

import 'package:unicons/unicons.dart';

class LogInScreen extends StatefulWidget {
  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  bool eyeON = false;
  bool isLogging=false;
  final auth = FirebaseAuth.instance;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 237, 241, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: mediaQuery.height * 0.15),
            Image.asset(
              'assets/images/login.png',
              width: mediaQuery.width * 0.8,
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "يرجى تسجيل الدخول لمشاهدة وتحميل نتائج التحليل",
                style: Theme.of(context).textTheme.headline2,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: EdgeInsets.all(15.0),
              child: Stack(
                overflow: Overflow.visible,
                children: [
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Icon(CupertinoIcons.person),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: mediaQuery.width * 0.65,
                                  child: TextField(
                                      controller: userController,
                                      decoration: InputDecoration(
                                        hintText: 'أسم المستخدم',
                                        border: InputBorder.none,
                                      ),
                                      style:
                                          Theme.of(context).textTheme.headline3,
                                      keyboardType: TextInputType.name)),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Divider(
                            color: Colors.black,
                            thickness: 1.2,
                            endIndent: 15,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(CupertinoIcons.lock),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                  width: mediaQuery.width * 0.65,
                                  child: TextField(
                                    controller: passController,
                                    style:
                                        Theme.of(context).textTheme.headline3,
                                    obscureText: !eyeON ? true : false,
                                    decoration: InputDecoration(
                                      hintText: 'كلمة السر',
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: Icon(!eyeON
                                            ? CupertinoIcons.eye
                                            : CupertinoIcons.eye_slash),
                                        onPressed: () {
                                          setState(() {
                                            eyeON = !eyeON;
                                          });
                                        },
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                      bottom: -20,
                      left: 100,
                      right: 100,
                      child: Container(
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromRGBO(55, 197, 209, 1),
                                  offset: Offset(0.5, 0.5),
                              blurRadius: 26,
                              spreadRadius: 0)
                            ],
                            borderRadius: BorderRadius.circular(8),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(55, 206, 189, 1),
                                  Color.fromRGBO(55, 197, 209, 1),

                                ])),
                        child:isLogging?Center(child: CircularProgressIndicator(strokeWidth: 1.2,)): FlatButton(
                          padding: EdgeInsets.all(13),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          onPressed: () async {
                            setState(() {
                              isLogging=true;
                            });
                            Provider.of<FireBaseApi>(context, listen: false)
                                .logInWithUserAndPassword(
                                    userController.text, passController.text)
                                .then((value) {
                              if (value == 'success'){
                                setState(() {
                                  isLogging=false;
                                });
                                Navigator.of(context)
                                    .pushNamed(PatientScreen.routeName);}
                              else{
                                setState(() {
                                  isLogging=false;
                                });
                                ShowDialog(error: value, context: context)
                                    .showDialog();
                              }

                            });
                          },
                          child: Text(
                            'تسجيل',
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      )),
                  // Positioned(
                  //     top:-70,
                  //     left: 100,
                  //     right: 100,
                  //     child: RaisedButton(
                  //       padding: EdgeInsets.all(13
                  //       ),
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(15)),
                  //       onPressed: ()async{
                  //         final UserCredential userCredential =
                  //         await auth.signInWithEmailAndPassword(
                  //             email: userController.text, password: passController.text);
                  //       },
                  //       child: Text('دخول'),
                  //     )
                  // )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
