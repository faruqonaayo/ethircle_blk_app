class Item {
  Item({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.quantity,
    required this.measureUnit,
    required this.inventoryId,
    required this.userId,
  });

  String? id;
  final String name;
  final String description;
  final double price;
  final double quantity;
  final String measureUnit;
  final String inventoryId;
  final String userId;
}
