class Inventory {
  Inventory({
    this.id,
    required this.name,
    required this.description,
    required this.use,
  });

  String? id;
  final String name;
  final String description;
  final String use;
}
