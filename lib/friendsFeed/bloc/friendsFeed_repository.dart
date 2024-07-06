import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/models/usersFeedModel.dart';

class UserPostRepository {

  final String apiUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/feed/feed/user';

  Future<List<usersPost>> fetchUserPosts(String token) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('API Response Status: ${response.statusCode}'); // Debugging
    print('API Response Body: ${response.body}'); // Debugging

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print('responseData $responseData');
      final List<dynamic> postsJson = responseData['data'];
      print('postsJson $postsJson');
      final finalPosts = postsJson.map((json) => usersPost.fromJson(json)).toList();
      print('finalPosts $finalPosts');
      return finalPosts;
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
