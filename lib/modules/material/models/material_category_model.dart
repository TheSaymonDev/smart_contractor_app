import 'package:flutter/material.dart';

class MaterialCategoryModel {
  final String id;
  final String title;
  final String englishTitle;
  final String countText;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;

  const MaterialCategoryModel({
    required this.id,
    required this.title,
    required this.englishTitle,
    required this.countText,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
  });
}
