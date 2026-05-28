import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants.dart';
import '../../domain/models/post.dart';

class PostService {
  final http.Client client;

  PostService({http.Client? client}) : client = client ?? http.Client();

  Future<List<Post>> fetchPosts() async {
    final response =
        await client.get(Uri.parse('${AppConstants.baseUrl}${AppConstants.postsEndpoint}'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Post.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}