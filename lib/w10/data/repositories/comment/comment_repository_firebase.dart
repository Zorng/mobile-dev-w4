import 'package:mobile_dev_w4/w10/data/dtos/comment_dto.dart';
import 'package:mobile_dev_w4/w10/data/repositories/comment/comment_repository.dart';
import 'package:mobile_dev_w4/w10/model/comment/comment.dart';
import 'package:mobile_dev_w4/w10/network/network.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentRepositoryFirebase extends CommentRepository {
  final Uri commentUri = Network.baseUri.replace(path: '/comments.json');

  List<Comment>? _cachedComments;

  @override
  Future<List<Comment>> fetchComments() async {
    final http.Response response = await http.get(commentUri);

    if (response.statusCode == 200) {
      Map<String, dynamic> commentsJson = json.decode(response.body);

      List<Comment> result = [];
      for (final entry in commentsJson.entries) {
        result.add(CommentDto.fromJson(entry.key, entry.value));
      }
      _cachedComments = result;
      return result;
    } else {
      // 2- Throw expcetion if any issue
      throw Exception('Failed to load posts');
    }
  }

  @override
  Future<void> postComment(Comment comment) async {
    final http.Response response = await http.post(
      commentUri,
      body: json.encode(CommentDto.toJson(comment)),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> commentJson = json.decode(response.body);

      String commentId = commentJson.values.first.toString();

      //post return something like this
      // {
      //   "name": "-OpE0A5ijD39gC1NxA3b"
      // }

      //make a get request to get the rest of the content or just use value of comment?
      http.Response responseBody = await http.get(
        commentUri.replace(path: './$commentId.json'),
      );
  
      if (responseBody.statusCode == 200) {
        Future.delayed(Duration(milliseconds: 200));
        Map<String, dynamic> commentBodyJson = json.decode(responseBody.body);
        Comment result = CommentDto.fromJson(commentId, commentBodyJson);

        _cachedComments?.add(result);
      } else {
        throw Exception("failed to get comment body");
      }
      //Comment result = Comment.fromJson(comment, songJson);
    } else {
      throw Exception("failed to post comment");
    }
  }

  @override
  Future<List<Comment>> getComments({bool forceFetch = false}) async {
    if (_cachedComments != null && forceFetch != true) {
      print("get comment from cached");
      return _cachedComments!;
    }

    final comments = await fetchComments();

    _cachedComments = comments;
    print("get comment from api");
    return comments;
  }

  @override
  Future<List<Comment>> fetchCommentsByArtistId(
    String id, {
    bool forceFetch = false,
  }) async {
    final comments = await getComments(forceFetch: forceFetch);
    return comments.where((c) => c.artistId == id).toList();
  }
}
