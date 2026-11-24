import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';

class MaterialTemplateModel {
  final String id;
  final String title;
  final String englishTitle;
  final String category;
  final String description;
  final String? customItemCountText;
  final List<MaterialItemModel> items;

  const MaterialTemplateModel({
    required this.id,
    required this.title,
    required this.englishTitle,
    required this.category,
    required this.description,
    String? itemCountText,
    required this.items,
  }) : customItemCountText = itemCountText;

  String get itemCountText =>
      customItemCountText ?? '${items.length}টি মালামাল';
}
