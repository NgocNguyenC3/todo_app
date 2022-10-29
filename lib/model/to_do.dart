// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_app/model/tag.dart';

class ToDoModel {
  String title;
  String content;
  int typeColor = 0;
  String time;
  List<TagModel> tags = [];
  ToDoModel({
    required this.title,
    required this.content,
    required this.typeColor,
    required this.time,
    required this.tags,
  });
}

final colorList = [
  Colors.red,
  Colors.orange,
  Colors.green,
];
