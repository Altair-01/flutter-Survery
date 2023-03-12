import 'package:flutter/material.dart';
import 'dart:convert';

class Agent{
  final int id;
  final String fullName;
  final String email;
  final int site;

  const Agent({
    required this.id,
    required this.fullName,
    required this.email,
    required this.site,
  });

  factory Agent.fromJson(Map<String, dynamic> json){
    return Agent(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      site: json['site'],
    );
  }
}