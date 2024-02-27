import 'dart:convert';
import 'dart:math';
// import 'dart:developer' as dev;
import 'package:bloc_api/features/posts/model/posts_mode.dart';
import 'package:http/http.dart' as http;

class PostsRepo {
  static Future<List<PostsDataModel>> fetchPosts() async {
    List<PostsDataModel> posts = [];
    try {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
      );
      List data = jsonDecode(response.body);

      for (int i = 0; i < data.length; i++) {
        PostsDataModel post = PostsDataModel.fromMap(data[i]);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      return [];
    }
  }

  static Future<bool> addPost(String title, String body) async {
    try {
      var response = await http.post(
        Uri.parse("https://jsonplaceholder.typicode.com/posts"),
        body: {
          "title": title,
          "body": body,
          "userId": '${Random().nextInt(10912)}',
        },
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
