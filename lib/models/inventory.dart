class Inventory {
  Inventory({
    this.id,
    required this.name,
    required this.description,
    required this.use,
    required this.userId,
  });

  String? id;
  final String name;
  final String description;
  final String use;
  final String userId;
}
