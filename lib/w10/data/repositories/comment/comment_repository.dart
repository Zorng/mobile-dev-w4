import 'package:mobile_dev_w4/w10/model/comment/comment.dart';

abstract class CommentRepository {
  Future<List<Comment>> fetchComments();
  Future<List<Comment>> fetchCommentsByArtistId(String id, {
    bool forceFetch = false,
  });
  Future<void> postComment(Comment comment);

  Future<List<Comment>> getComments({bool forceFetch = false}); // get from cached first
}
