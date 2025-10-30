import 'package:ethircle_blk_app/data/models/item/measure_unit.dart';

class Item {
  final String id;
  final String name;
  final String? description;
  final MeasureUnit measureUnit;
  final double measurementValue;
  final double pricePerUnit;
  final String? inventoryId;

  const Item({
    required this.id,
    required this.name,
    this.description,
    required this.measureUnit,
    required this.measurementValue,
    required this.pricePerUnit,
    this.inventoryId,
  });
}
