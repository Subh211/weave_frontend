import 'package:weave_frontend/models/likeModel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LikeRepository {
  Future<List<Like>> fetchLikes(String postId, String friendId) async {
    final response = await http.get(Uri.parse('https://weave-backend-pyfu.onrender.com/api/v1/post/alllikes/$friendId?postId=$postId'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Like.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load likes');
    }
  }
}
