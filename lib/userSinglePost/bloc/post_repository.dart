import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/models/postModel.dart';

// class PostRepository {
//   final String apiUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/feed/feed';
//
//   Future<List<Post>> fetchPosts(String token) async {
//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: {
//         'Authorization': 'Bearer $token',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       print('resssssssssssss ${response.body}');
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);
//       List<dynamic> data = jsonResponse['data'];
//       return data.map((json) => Post.fromJson(json)).toList();
//     } else {
//       throw Exception('Failed to load posts');
//     }
//   }
// }

class PostRepository {
  final String apiUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/feed/feed';

  Future<List<Post>> fetchPosts(String token) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    print('API Response Status: ${response.statusCode}'); // Debugging
    print('API Response Body: ${response.body}'); // Debugging

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      List<dynamic> data = jsonResponse['data'];
      return data.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
