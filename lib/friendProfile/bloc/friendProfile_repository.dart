//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:weave_frontend/models/profileModel.dart';
//
// class GetFriendProfileRepository {
//   final String apiUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/user/$friendId}';
//
//   Future<Profile> fetchProfile(
//       //String token
//       ) async {
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       // headers: {
//       //   'Authorization': 'Bearer $token',
//       // },
//     );
//
//     print('API Response Status: ${response.statusCode}'); // Debugging
//     print('API Response Body: ${response.body}'); // Debugging
//
//     if (response.statusCode == 200) {
//       final Map<String, dynamic> jsonResponse = json.decode(response.body);
//       return Profile.fromJson(jsonResponse['data']);
//     } else {
//       throw Exception('Failed to load profile');
//     }
//   }
// }
//
//
//
//





import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/models/profileModel.dart';

class GetFriendProfileRepository {
  final String baseUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/user/';

  Future<Profile> fetchProfile(String friendId) async {
    final String apiUrl = '$baseUrl$friendId'; // Construct the API URL with friendId
    final response = await http.get(Uri.parse(apiUrl));

    print('API Response Status: ${response.statusCode}'); // Debugging
    print('API Response Body: ${response.body}'); // Debugging

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      return Profile.fromJson(jsonResponse['data']);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

