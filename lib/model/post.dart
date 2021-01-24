import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor/model/api.dart';
import 'package:flutter/cupertino.dart';

class Post with ChangeNotifier{
  final String id;
  final String title;
  final Timestamp dateTime;
  final String description;
  final String imageUrl;

  Post(
      {
        @required this.id,
        @required this.title,
      @required this.dateTime,
      @required this.description,
      @required this.imageUrl});
}

class Posts with ChangeNotifier{
  final _mealsSnapshot = <DocumentSnapshot>[];
  int documentLimit = 6;

  List<Post> _items = [
    // Post(
    //   id: 'c1',
    //     title: 'عيد فطر سعيد',
    //     dateTime: DateTime.now(),
    //     description: 'الدكتور حسن حامد يوجه ب ارق العبارات واندى الكلمات ...',
    //     imageUrl: 'https://cdn.eventfinda.com.au/uploads/events/transformed/599327-271464-34.jpg?v=2'),
    // Post(
    //     id: 'c2',
    //     title: 'تخفيضات الموسم',
    //     dateTime: DateTime.now(),
    //     description: 'الدكتور حسن حامد يعمل تخفيضات لمراجعين الاعزاء ...',
    //     imageUrl: 'https://content.very.co.uk/assets/static/2020/09/contingency/25-tiered-codes-fashion-all/mobile-sitewide.jpg'),
    // Post(
    //     id: 'c3',
    //     title: 'عيد فطر سعيد',
    //     dateTime: DateTime.now(),
    //     description: 'الدكتور حسن حامد يوجه ب ارق العبارات واندى الكلمات ...',
    //     imageUrl: 'https://cdn.eventfinda.com.au/uploads/events/transformed/599327-271464-34.jpg?v=2'),
    // Post(
    //     id: 'c4',
    //     title: 'تخفيضات الموسم',
    //     dateTime: DateTime.now(),
    //     description: 'الدكتور حسن حامد يعمل تخفيضات لمراجعين الاعزاء ...',
    //     imageUrl: 'https://content.very.co.uk/assets/static/2020/09/contingency/25-tiered-codes-fashion-all/mobile-sitewide.jpg'),
  ];

  List<Post> get items {
    return [..._items];
  }
   Future<QuerySnapshot> postApi(int limit, {DocumentSnapshot startAfter}) async {
    final refUsers = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime',descending: true)
        .limit(limit);

    if (startAfter == null) {
      return refUsers.get().timeout(Duration(minutes: 1));
    } else {
      return refUsers.startAfterDocument(startAfter).get();
    }

  }

  Future<void> getPosts()async{
    List<Post>loadedPosts=[];
    try{
      final snap = await postApi(
        documentLimit,
        startAfter: _mealsSnapshot.isNotEmpty ? _mealsSnapshot.last : null,
      );

      _mealsSnapshot.addAll(snap.docs);
      // print(_mealsSnapshot);
      _mealsSnapshot.forEach((element) {
        loadedPosts.add(Post(
            id: element.id,
            title: element['title'],
            description: element['description'],
            dateTime: element['dateTime'],
            imageUrl: element['imageUrl']
        ));
      });
      _items=loadedPosts;
      notifyListeners();
    }catch(error){
      print(error);
    }
  }

}
