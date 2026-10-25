class MaterialItemModel {
  final String id;
  final String name;
  final String size;
  final String brand;
  final double quantity;
  final String unit;
  final double unitPrice;
  final String note;
  final bool isSelected;

  const MaterialItemModel({
    required this.id,
    required this.name,
    this.size = '',
    this.brand = '',
    this.quantity = 0,
    this.unit = 'টি',
    this.unitPrice = 0,
    this.note = '',
    this.isSelected = true,
  });

  double get totalPrice => quantity * unitPrice;

  MaterialItemModel copyWith({
    String? id,
    String? name,
    String? size,
    String? brand,
    double? quantity,
    String? unit,
    double? unitPrice,
    String? note,
    bool? isSelected,
  }) {
    return MaterialItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      size: size ?? this.size,
      brand: brand ?? this.brand,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      unitPrice: unitPrice ?? this.unitPrice,
      note: note ?? this.note,
      isSelected: isSelected ?? this.isSelected,
    );
  }
}
