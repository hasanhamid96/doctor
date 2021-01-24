// import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/model/api.dart';
import 'package:doctor/screens/analyeseScreen.dart';
import 'package:doctor/widgets/showDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PatientScreen extends StatefulWidget {
  static var routeName = 'logScreen';

  @override
  _PatientScreenState createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final _key = GlobalKey<FormState>();
  final _nameFocusNode = FocusNode();
  final _genderFocusNode = FocusNode();
  final _ageFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _stateFocusNode = FocusNode();
  bool isLogIn = false;
  String patientName = '';
  var gender = '';
  var age = '';
  var phoneNum = '';
  var state = '';
  bool init = false;
  bool isOpenKeyBoard = false;
  static var cloudFireBase=FirebaseFirestore.instance;
  String _controllerDropDownCateogry;

  Widget textField(BuildContext context, String label, FocusNode focusNode) {
    return TextFormField(
      focusNode: focusNode,
      validator: (value) {
        if (value.isEmpty) return 'please fill the blank';
        if (label == 'رقم الموبايل') {
          if (value.isEmpty) return 'please fill the blank';
          if (value.toString() == null) return 'please fill the blank';
          if (value.length < 11) return 'please write more characters';

          if (!value.startsWith('07')) return 'please write valid phone number';
        }
        return null;
      },
      maxLengthEnforced: true,
      maxLength: label == 'رقم الموبايل' ? 11 : 50,
      keyboardType: label == 'رقم الموبايل'
          ? TextInputType.phone
          : label == 'العمر'?
          TextInputType.phone:
        null,
      onSaved: (newValue) {
        if (label == 'العمر')
          age  = newValue;
        else if (label == 'اسم المريض')
          patientName = newValue;
        else if (label == 'تشخيص الحالة')
          state  = newValue;
        else if (label == 'رقم الموبايل')
          phoneNum = newValue;
      },
      style: Theme.of(context).textTheme.headline3,
      key: ValueKey(label),
      decoration: InputDecoration(
        counterStyle: Theme.of(context).textTheme.headline3,
        counterText: "",
        contentPadding: EdgeInsets.all(13),
        // focusedErrorBorder: OutlineInputBorder(
        //     // borderRadius: BorderRadius.circular(25),
        //     borderSide: BorderSide(
        //   color: Colors.orange,
        // )),
        // enabledBorder: OutlineInputBorder(
        //     // borderRadius: BorderRadius.circular(25),
        //     borderSide: BorderSide(color: Colors.grey, width: 1.5)),
        // focusedBorder: OutlineInputBorder(
        //     // borderRadius: BorderRadius.circular(25),
        //     borderSide: BorderSide(
        //       color: Colors.orange,
        //     )),
        // errorBorder: OutlineInputBorder(
        //     borderRadius: BorderRadius.circular(25),
        //     borderSide: BorderSide(
        //       color: Colors.redAccent,
        //     )),
        labelText: '$label',
        errorStyle: TextStyle(
          color: Colors.redAccent,
        ),
        labelStyle: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget RaisedButtonFunc(
      String label,
      IconData icons,
      ) {
    return Container(
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
      child: FlatButton.icon(
        icon: Icon(icons,color: Colors.white,),
        padding: EdgeInsets.all(13),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)),
        onPressed: ()  {
          return _onSave();
        },
        label: Text(
          'تسجيل',
          style: Theme.of(context).textTheme.headline5,
        ),
      ),
    );

  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _genderFocusNode.dispose();
    _ageFocusNode.dispose();
    _phoneFocusNode.dispose();
    _stateFocusNode.dispose();

    super.dispose();
  }

  void _onSave() {
    var isValid = _key.currentState.validate();
    if (isValid) {
      setState(() {
        init = true;
      });
        _key.currentState.save();
        Provider.of<FireBaseApi>(context, listen: false)
            .addPatient(patientName,gender, age,phoneNum,state)
            .then((value) {
          if (value == 'success') {
            setState(() {
              init = false;
            });
            ShowDialog(error: value,context: context).showDialog();
              Navigator.of(context).pushReplacementNamed(AnalyseScreen.routeName,arguments: patientName);
          } else {
            setState(() {
              init = false;
            });
            ShowDialog(error: value,context: context).showDialog();
          }
        });

      }
    }
  List<String> items = [
    'ذكر',
    'أنثى',

  ];

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final isLandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: Form(
        key: _key,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: isLandScape ? 25 : 105.0,
                    left: 15,
                    right: 15,
                    bottom: 15),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (!isLandScape)
                        SizedBox(
                          height: 20,
                        ),
                      Stack(
                        overflow: Overflow.visible,
                        children: [
                          // Positioned(
                          //     top: isLandScape ? 10 : 13,
                          //     child: Image.asset(
                          //       'assets/images/line.png',
                          //       width: isLandScape
                          //           ? mediaQuery.width * 0.22
                          //           : mediaQuery.width * 0.45,
                          //     )),
                          Text(
                          'يرجى ادخال البيانات',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textField(context, 'اسم المريض', _nameFocusNode   ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color:Theme.of(context).accentColor,
                        ),
                        padding: EdgeInsets.all(15),
                        margin: EdgeInsets.only(top: 10,bottom: 10),

                        child: DropdownButtonFormField<String>(
                          validator: (value) {
                            if (value == null) return 'اختار الجنس';
                            return null;
                          },
                          onSaved: (newValue) {
                            setState(() {
                              gender=newValue;
                            });

                          },
                          elevation: 8,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline5,
                          dropdownColor: Colors.white,
                          isExpanded: true,
                          decoration: InputDecoration.collapsed(
                            enabled: true,
                            hintText: 'الجنس',
                            hintStyle: Theme
                                .of(context)
                                .textTheme
                                .headline3,
                          ),
                          items: items.map((String dropDownStringItem) {
                            return DropdownMenuItem<String>(
                              value: dropDownStringItem,
                              child: Text(
                                "$dropDownStringItem",
                                style: Theme
                                    .of(context)
                                    .textTheme
                                    .headline3,
                              ),
                            );
                          }).toList(),
                          // onChanged: (value) => print(value),
                          onChanged: (value) {
                            setState(() {
                              _controllerDropDownCateogry = value;
                            });
                          },
                          value: _controllerDropDownCateogry,
                        ),
                      ),

                      textField(context, 'العمر'        , _ageFocusNode    ),
                      textField(context, 'رقم الموبايل'      , _phoneFocusNode  ),
                      textField(context, 'تشخيص الحالة'      , _stateFocusNode  ),
                      SizedBox(
                        height: 5,
                      ),

                      SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
           ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all( 30.0),
        margin: EdgeInsets.only(
            left: 50.0, right:40),
        child: RaisedButtonFunc(
            'حفظ',
           Icons.save,
        ),
      ),
    );
  }
}

// Container(
//   margin: const EdgeInsets.only(right:100.0),
//   child: RaisedButtonFunc(
//       isLogIn ? 'LOG IN' : 'SIGN UP',
//       isLogIn ? Icons.arrow_forward : Icons.person,
//       isLogIn ? true : false,
//       0),
// ),
