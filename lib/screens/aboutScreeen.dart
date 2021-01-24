import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {

   Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 1.1,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/about.jpg',
                  )),
            ),
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Positioned(
                    left: 180,
                    right: 100,
                    top: 60,
                    bottom: 680,
                    child: Opacity(
                      opacity: 0.0,
                      child: RaisedButton(
                         onPressed: (){
                           openMap(33.298140,44.430468);
                         },
                      ),
                    )),
                Positioned(
                  left: 30,
                  right: 30,
                  bottom: 100,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(19.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Theme.of(context).accentColor,
                              ),
                              Text(
                                'العنوان',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            'العراق واسط, الصويرة,مقابل مستشفى الصويرة العامة',
                            style: Theme.of(context).textTheme.bodyText2,textDirection: TextDirection.rtl,
                          ),
                          Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.call,
                                color: Theme.of(context).accentColor,
                              ),
                              Text(
                                'الأتصال ',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Text(
                            '- info@lab.com',
                            style: Theme.of(context).textTheme.bodyText2,textDirection: TextDirection.rtl,
                          ),
                          Text(
                            '- 07830003082',
                            style: Theme.of(context).textTheme.bodyText2,textDirection: TextDirection.rtl,
                          ),
                          Text(
                            '- 077100069771',
                            style: Theme.of(context).textTheme.bodyText2,textDirection: TextDirection.rtl,
                          ),
                          Divider(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.account_circle_outlined,
                                color: Theme.of(context).accentColor,
                              ),
                              Text(
                                'الطاقم ',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'الدكتور حسن حامد',
                                style: Theme.of(context).textTheme.headline1,textDirection: TextDirection.rtl,
                              ),
                              SizedBox(width: 20,),
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage( 'assets/images/person.jpg',),
                              ),

                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
