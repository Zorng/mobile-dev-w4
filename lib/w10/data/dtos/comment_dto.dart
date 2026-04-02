import 'package:mobile_dev_w4/w10/model/comment/comment.dart';

class CommentDto {
  static const String contentKey = "content";
  static const String artistIdKey = "artistId";

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[contentKey] is String);
    assert(json[artistIdKey] is String);
    return Comment(id:id ,artistId: json[artistIdKey], content: json[contentKey]);
  }

  static Map<String, dynamic> toJson(Comment comment) {
    return {artistIdKey: comment.artistId, contentKey: comment.content};
  }
}
