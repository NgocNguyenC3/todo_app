// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/components/to_do_item.dart';

class ToDoModel {
  int id;
  String title;
  String content;
  int typeColor = 0;
  DateTime time;
  ToDoModel({
    required this.id,
    required this.title,
    required this.content,
    required this.typeColor,
    required this.time,
  });

  void changedLevel() {
    if (typeColor == 2) {
      typeColor = 0;
      return;
    }

    typeColor++;
  }

  static toJSONEncodableList(List<ToDoModel> items) {
    return items.map((item) {
      return item.toJSONEncodable();
    }).toList();
  }

  dynamic toJSONEncodable() {
    Map<String, dynamic> m = {};

    m['title'] = title;
    m['content'] = content;
    m['typeColor'] = typeColor;
    m['time'] = formatDate(time);
    return m;
  }
}

final colorList = [
  Colors.red,
  Colors.orange,
  Colors.green,
];

final level = [
  'Importance',
  'Medium',
  'Not important',
];
