import 'package:flutter/material.dart';
import 'package:mobile_dev_w4/w10/model/comment/comment.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  const CommentTile({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(

          subtitle: Text("Genre: ${comment.content}"),
         
        ),
      ),
    );
  }
}
