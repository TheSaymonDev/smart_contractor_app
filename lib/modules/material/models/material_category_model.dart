import 'package:flutter/material.dart';

class MaterialCategoryModel {
  final String id;
  final String title;
  final String englishTitle;
  final String templateCountText;
  final IconData icon;

  const MaterialCategoryModel({
    required this.id,
    required this.title,
    required this.englishTitle,
    required this.templateCountText,
    required this.icon,
  });

  String get countText => templateCountText;
}
