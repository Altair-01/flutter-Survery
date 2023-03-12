import 'package:flutter/material.dart';
import 'dart:convert';

class Site{
  final int id;
  final String name;

  const Site({
    required this.id,
    required this.name,
  });

  factory Site.fromJson(Map<String, dynamic> json){
    return Site(
      id: json['id'],
      name: json['name'],
    );
  }
}