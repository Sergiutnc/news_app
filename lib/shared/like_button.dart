import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/services/database.dart';

class LikeButton extends StatefulWidget {

  final String userUid;
  final String newsUid;

  LikeButton({ this.userUid, this.newsUid });

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> {

  bool liked = false;
  int numberOfLikes = 0;

  _isLiked() async {
    final result = await Firestore.instance.collection('news').document(widget.newsUid)
        .collection('likes').document(widget.userUid).get();

    if (result != null) {
      this.liked = result.data['isLiked'];
    }

    setState(() {
      liked;
    });
  }

  _getNumberOfLikes() async {

    final result = await Firestore.instance.collection('news')
        .document(widget.newsUid).collection('likes').getDocuments();

    setState(() {
      numberOfLikes = 0;
      for(var item in result.documents){
        if(item.data['isLiked'] == true) numberOfLikes++;
      }
    });

  }

  _pressed() {
    setState(() {
      liked = !liked;
    });
  }

  @override
  Widget build(BuildContext context) {
    _isLiked();
    _getNumberOfLikes();
    return Row(
      children: <Widget>[
        Text('$numberOfLikes'),
        IconButton(
          icon: Icon(liked ? Icons.favorite : Icons.favorite_border),
          color: liked ? Colors.red : Colors.grey,
          onPressed: () async {
            DatabaseService(userUid: widget.userUid).addLike(widget.newsUid, liked);
            _pressed();
          },
        ),
      ],
    );

  }
}
