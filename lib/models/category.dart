import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Category {
  const Category({
    required this.id,
    required this.name,
    required this.description,
    required this.aValue,
    required this.rValue,
    required this.gValue,
    required this.bValue,
    required this.createdAt,
    required this.updatedAt,
  });

  Category.create({
    required this.name,
    required this.description,
    required this.aValue,
    required this.rValue,
    required this.gValue,
    required this.bValue,
  }) : id = uuid.v4(),
       createdAt = DateTime.now(),
       updatedAt = DateTime.now();

  final String id;
  final String name;
  final String description;
  final double aValue;
  final int rValue;
  final int gValue;
  final int bValue;
  final DateTime createdAt;
  final DateTime updatedAt;
}
