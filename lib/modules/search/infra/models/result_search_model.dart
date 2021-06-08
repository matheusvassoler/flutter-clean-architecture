import 'dart:convert';

import 'package:flutter_clean_architecture/modules/search/domain/entities/result_search.dart';

class ResultSearchModel extends ResultSearch {
  final String title;
  final String content;
  final String img;

  ResultSearchModel({this.title, this.content, this.img});

//  ResultSearchModel({String title, String content, String img}) : super(title: title, content: content, img: img);

  Map<String, dynamic> topMap() {
    return {
      'title': title,
      'content': content,
      'img': img,
    };
  }

  static ResultSearchModel fromMap(Map<String, dynamic> map) {
    if (map == null) {
      return null;
    }

      return ResultSearchModel(
        title: map['login'],
        content: map['node_id'],
        img: map['avatar_url'],
      );
  }

  String toJson() => json.encode(topMap());

  static ResultSearchModel fromJson(String source) => fromMap(json.decode(source));
}