import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:khabar/models/article_model.dart';

class News {
  List<ArticleModel> news = [];

  Future<void> getnews() async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=dab8b325692d4be18ee228bb84441cde");
    var response = await http.get(url);

    var jsondata = jsonDecode(response.body);

    if (jsondata['status'] == 'ok') {
      jsondata['articles'].forEach(
        (element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ArticleModel articleModel = ArticleModel(
                title: element['title'],
                author: element["author"] ??
                    "Unknown Author", // Provide a default value
                description: element["description"] ??
                    "No description available", // Provide a default value
                url: element["url"],
                urlTOImage: element["urlToImage"],
                content: element["content"] ??
                    "No content available" // Provide a default value
                );

            news.add(articleModel);
          }
        },
      );
    }
  }
}

class CategoryNewsClass {
  List<ArticleModel> news = [];

  Future<void> getnews(String category) async {
    var url = Uri.parse(
        "https://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=dab8b325692d4be18ee228bb84441cde");
    var response = await http.get(url);

    var jsondata = jsonDecode(response.body);

    if (jsondata['status'] == 'ok') {
      jsondata['articles'].forEach(
        (element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"] ?? "",
              description: element["description"] ?? "",
              url: element["url"],
              urlTOImage: element["urlToImage"],
              content: element["context"] ?? "",
            );
            news.add(articleModel);
          }
        },
      );
    }
  }
}
