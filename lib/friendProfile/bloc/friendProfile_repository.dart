import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:weave_frontend/models/profileModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetFriendProfileRepository {
  final String baseUrl = 'https://weave-backend-pyfu.onrender.com/api/v1/user/';
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  Future<String?> _getStoredToken() async {
    final storedToken = await secureStorage.read(key: 'token');
    return storedToken;
  }

  Future<Profile> fetchProfile(String friendId) async {
    final String apiUrl = '$baseUrl$friendId'; // Construct the API URL with friendId
    final token = await _getStoredToken();

    if (token == null) {
      throw Exception('Token is missing');
    }

    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
      },
    );

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

