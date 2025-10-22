import 'package:uuid/uuid.dart';

import 'package:ethircle_blk_app/data/models/inventory.dart';

final uuid = Uuid();

class InventoryService {
  static Inventory createNewInventory({
    required String name,
    required String description,
    required String type,
    required String use,
    required int rColor,
    required int gColor,
    required int bColor,
  }) {
    return Inventory(
      id: uuid.v4(),
      name: name,
      description: description,
      type: type,
      use: use,
      rColor: rColor,
      gColor: gColor,
      bColor: bColor,
    );
  }
}
