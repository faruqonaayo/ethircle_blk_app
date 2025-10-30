import 'package:ethircle_blk_app/data/models/inventory/inventory_type.dart';
import 'package:ethircle_blk_app/data/models/inventory/inventory_use.dart';

class Inventory {
  final String id;
  final String name;
  final String description;
  final InventoryType type;
  final InventoryUse use;
  final int rColor;
  final int gColor;
  final int bColor;

  const Inventory({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    required this.use,
    required this.rColor,
    required this.gColor,
    required this.bColor,
  });
}
