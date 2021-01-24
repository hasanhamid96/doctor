import 'package:carousel_slider/carousel_slider.dart';
import 'package:doctor/model/api.dart';
import 'package:doctor/model/post.dart';
import 'package:doctor/widgets/detailsPostScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:provider/provider.dart';
import 'package:unicons/unicons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List imgList = [
    'https://2f35da97a9ad36d49db6-4d1987fef3a36cccd5478db4931039f0.ssl.cf3.rackcdn.com/assets/media/2017/09/UK-fashion-week-blog.jpg',
    'https://cdn.eventfinda.com.au/uploads/events/transformed/599327-271464-34.jpg?v=2',
    "https://content.very.co.uk/assets/static/2020/09/contingency/25-tiered-codes-fashion-all/mobile-sitewide.jpg",
    'https://2f35da97a9ad36d49db6-4d1987fef3a36cccd5478db4931039f0.ssl.cf3.rackcdn.com/assets/media/2017/09/UK-fashion-week-blog.jpg',
  ];

  _launchURL() async {
    const url = 'https://h-alkararlab.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  bool isLoaded = true;
  bool isConnect=true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<FireBaseApi>(context).getResault();
    Provider.of<Posts>(context).getPosts().then((value) {
      if(mounted)
      setState(() {
        isLoaded = false;
      });
    });
  }
  // void connect()async{
  //   var connectivity=await Connectivity().checkConnectivity();
  //   if(connectivity!=ConnectivityResult.mobile&&connectivity!=ConnectivityResult.wifi){
  //   setState(() {
  //     isConnect=false;
  //   });
  //   }
  // else {
  //     setState(() {
  //       isConnect=true;
  //     });
  //   }
  //
  // }


  @override
  Widget build(BuildContext context) {

    final List<Widget> imageSliders = imgList
        .map((item) => GestureDetector(
              onTap: () {
                _launchURL();
              },
              child: Container(
                child: Container(
                  margin: EdgeInsets.all(1.0),
                  child: Card(
                    color: Theme.of(context).accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(item,
                            fit: BoxFit.cover, width: 1000.0)),
                  ),
                ),
              ),
            ))
        .toList();
    final posts = Provider.of<Posts>(context).items;
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromRGBO(236, 237, 241, 1),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(236, 237, 241, 1),
          centerTitle: true,
          // actions: [
          //   IconButton(
          //       icon: Icon(
          //         UniconsLine.analytics,
          //         color: Colors.black,
          //       ),
          //       onPressed: () {
          //         Navigator.of(context).pushReplacementNamed(routeName).nav
          //       })
          // ],
          title: Text(
            'الرئيسية',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: isLoaded
            ? Center(child: CircularProgressIndicator()):
            SingleChildScrollView(
            child: Column(children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: true,
            ),
            items: imageSliders,
          ),
          SizedBox(
            height: 20,
          ),
         ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: posts.length,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          DetailsPostScreen.routeName,
                          arguments: posts[index].id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(15),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 7,
                        child: Column(
                          children: [
                            Hero(
                              transitionOnUserGestures: true,
                              tag: posts[index].id,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(15),
                                    topRight: Radius.circular(15),
                                  ),
                                  child: Image.network(
                                    '${posts[index].imageUrl}',
                                    fit: BoxFit.cover,
                                    height: mediaQuery.height * 0.3,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'الدكتور حسن حامد',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline3,
                                        textDirection: ui.TextDirection.rtl,
                                      ),
                                      Text(
                                        '${DateFormat.yMd().format(posts[index].dateTime.toDate())}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4,
                                        textDirection: ui.TextDirection.rtl,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: AssetImage(
                                      'assets/images/person.jpg',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '${posts[index].title}',
                                style: Theme.of(context).textTheme.headline2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
        ])));
  }
}
