import 'package:doctor/model/post.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class DetailsPostScreen extends StatelessWidget {
  static var routeName='DetailsPostScreen';
  @override
  Widget build(BuildContext context) {

    final id=ModalRoute.of(context).settings.arguments as String ;
    final post = Provider
        .of<Posts>(context).items.firstWhere((element) => element.id==id);

    return Scaffold(
      backgroundColor: Color.fromRGBO(236, 237, 241, 1),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
               leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
                  Navigator.of(context).pop();
                }),
              backgroundColor: Theme
                  .of(context)
                  .accentColor,
              elevation: 0,
              expandedHeight: 150.0,
              floating: false,
              pinned: true,
              snap: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                  title: Text(
                    '${post.title}',
                    maxLines: 1,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: TextStyle(
                      color: Colors.white, fontFamily: 'Tajawal-Regular',fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  background: Hero(
                    tag: post.id,
                    child: Image.network(
                      "${post.imageUrl}",
                      fit: BoxFit.cover,
                    ),
                  )
              ),
            ),
          ];
        },

body: Container(
  height: 50,
  margin: EdgeInsets.only(top: 30,left: 10,right: 10,bottom: 10),
  child:   Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    elevation: 7,
     child:Padding(
       padding: const EdgeInsets.all(16.0),
       child: Column(
         mainAxisSize: MainAxisSize.min,
         crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'الدكتور حسن حامد',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline3,
                    textDirection: ui.TextDirection.rtl,
                  ),
                  Text(
                    '${DateFormat.yMd().format(post.dateTime.toDate())}',
                    style: Theme
                        .of(context)
                        .textTheme
                        .headline4,
                    textDirection: ui.TextDirection.rtl,
                  ),
                ],
              ),
              SizedBox(width: 20,),
              CircleAvatar(
                radius: 25,
                backgroundImage: AssetImage(
                  'assets/images/person.jpg',),
              ),

            ],
          ),
          Divider(),
          Text('${post.description}',textDirection: ui.TextDirection.rtl,)
        ],
    ),
     ),
  ),
),
      ),
    );
  }
}
