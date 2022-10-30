// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class ToDoModel {
  String title;
  String content;
  int typeColor = 0;
  String time;
  ToDoModel({
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

  ToDoModel cpy() {
    return ToDoModel(
        title: title, content: content, typeColor: typeColor, time: time);
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
  'Easy',
];
