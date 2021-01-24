import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/screens/bottomNavBarScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_up_panel/flutter_sliding_up_panel.dart';

class AnalyseScreen extends StatelessWidget {
  static var routeName = 'AnalyseScreen';
  static var cloudFireBase=FirebaseFirestore.instance;
  String name;
  String age;
  String phone;
  String gender;
  String state;
  bool isLoading=false;
  @override
  Widget build(BuildContext context) {
    final patientName=ModalRoute.of(context).settings.arguments as String ;



    final mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: FutureBuilder<QuerySnapshot>(
            future: cloudFireBase.collection('patient').where('patientName',isEqualTo: patientName).get(),
            builder: (context, snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Positioned(
                  top: 300,
                  child: CircularProgressIndicator(),);
              }
              // snapshot.data.docs.first.forEach((element) {
                name= snapshot.data.docs.first.data()['patientName'];
                age= snapshot.data.docs.first.data()['age'];
                phone= snapshot.data.docs.first.data()['phoneNum'];
                gender= snapshot.data.docs.first.data()['gender'];
                state= snapshot.data.docs.first.data()['state'];
              // });
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomPaint(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),
                  Positioned(
                      left: 10,
                      top: 15,
                      child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).popAndPushNamed(BottomNavBar.routeName);
                          })),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          'التحاليل',
                          style: TextStyle(
                            fontSize: 35.0,
                            letterSpacing: 1.5,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          image: DecorationImage(
                            image: AssetImage('assets/images/Person-Icon.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('${name} '),
                      Text(' الجنس : $gender'),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        elevation: 10,
                        semanticContainer: true,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.greenAccent,
                                    Colors.lightBlueAccent
                                  ])),
                          padding: EdgeInsets.only(
                              top: mediaQuery.height * 0.04,
                              right: mediaQuery.width * 0.25,
                              left: mediaQuery.width * 0.25,
                              bottom: mediaQuery.height * 0.04),
                          // width: mediaQuery.width*0.9,
                          // height: mediaQuery.height*0.2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              RaisedButton.icon(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                icon: Icon(
                                  Icons.download_rounded,
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.only(
                                    left: 35, right: 35, top: 10, bottom: 10),
                                onPressed: () {},
                                label: Text(
                                  'تحميل',
                                  style: Theme.of(context).textTheme.headline5,
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                'تم رفع النتيجة',
                                style: TextStyle(
                                  fontSize: 25.0,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: Card(
                          elevation: 10,
                          semanticContainer: true,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.only(
                                top: mediaQuery.height * 0.04,
                                right: mediaQuery.width * 0.03,
                                left: mediaQuery.width * 0.03,
                                bottom: mediaQuery.height * 0.04),
                            // width: mediaQuery.width*0.9,
                            // height: mediaQuery.height*0.2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('$name') ,
                                     Text(':الاسم') ,

                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('$gender') ,
                                      Text(':الجنس') ,
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('$age') ,
                                      Text(':العمر') ,
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('$state') ,
                                      Text(':الحالة ') ,

                                    ],
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ],
              );
            },

          ),
        ),
      ),
    );
  }
}

class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color.fromRGBO(49, 61, 75, 1);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
