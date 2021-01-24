import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
class FireBaseApi with ChangeNotifier{
  final auth = FirebaseAuth.instance;
   static var cloudFireBase=FirebaseFirestore.instance;
  String name;
  Future<String> logInWithUserAndPassword(String email, String password) async {
    try {
      final UserCredential userCredential =
      await auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = userCredential.user;
      print(user);
      return 'success';
    } catch (error) {
      print('something wrong with log In');
      print(error);
      return handelError(error.toString());
    }
  }



   Future<String> addPatient(String patientName,String gender ,String age ,String phoneNum,String state)async{
    try{
      name=patientName;
      cloudFireBase.collection('patient').add({
        'patientName':patientName,
        'gender':gender,
        'age':age,
        'phoneNum':phoneNum,
        'state':state
      });
    notifyListeners();
      return 'success';
    }catch(error){
      return 'fail';

    }

  }


  Future<void> getResault()async{
   final getData=await cloudFireBase.collection('patient').where('patientName',arrayContains: name).get();
  getData.docs.forEach((element) {
    print(element['age']);
  });

  }


   String handelError(String error) {
     if (error.contains('[firebase_auth/wrong-password]')) {
       return error.substring(30);
     } else if (error.contains('[firebase_auth/user-not-found]')) {
       return error.substring(30);
     } else if (error.contains('[firebase_auth/email-already-in-use]')) {
       return error.substring(36);
     } else if (error.contains('[firebase_auth/weak-password]')) {
       return error.substring(30);
     } else if (error.contains('[firebase_auth/too-many-requests]')) {
       return error.substring(34);
     } else if (error.contains('[firebase_auth/unknown]')) {
       return 'an internal Error try later please';
     }
     return error;
   }

}
