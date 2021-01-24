import 'package:doctor/screens/bottomNavBarScreen.dart';
import 'package:flutter/cupertino.dart';
class ShowDialog{
  final String error;
  final BuildContext context;
  ShowDialog({
    @required this.error,
    @required this.context
  });

  showDialog() {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title:error=='success'? ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20)),
            child: Image.asset(
              'assets/images/tick2.png',
              fit: BoxFit.fill,
            )): Text('something went wrong!'),
        content: Text(error=='success'?'Congratulation \n You Made It!':'$error'),
        actions: [

          CupertinoButton(
              child: Text(error=='success'?'تمت الاصافة':'okay',),
              onPressed: () {
                Navigator.of(context).pop();
              })
        ],
      ),
    );
  }
}
