import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapp/models.dart/NewsModle.dart';

class Newsapi {
  List<NewsModle> dataStore = [];
  Future<void> getNews() async {
    Uri url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=e7a52c110b6443ee82fa9966c79a1978");
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData["status"] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null &&
            element["description"] != null &&
            element["author"] != null &&
            element["content"] != null) {
          NewsModle newsModle = NewsModle(
              title: element["title"],
              urlToImage: element["urlToImage"],
              description: element["description"],
              author: element["author"],
              content: element["content"]);
          dataStore.add(newsModle);
        }
      });
    }
  }
}
