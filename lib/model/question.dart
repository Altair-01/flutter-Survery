import 'package:flutter/material.dart';
import 'dart:convert';

class Question{
  final int id;
  final String text;

  const Question({required this.id, required this.text});

  factory Question.fromJson(Map<String, dynamic> json){
    return Question(
      id: json['id'],
      text: json['text'],
    );
  }
}