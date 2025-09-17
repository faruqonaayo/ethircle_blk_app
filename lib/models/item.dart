import 'package:uuid/uuid.dart';

final uuid = Uuid();

class Item {
  Item({
    required this.id,
    required this.name,
    required this.description,
    required this.worth,
    required this.address,
    required this.imageUrl,
    required this.catId,
    this.lat,
    this.long,
    required this.isFavorite,
    required this.createdAt,
    required this.updatedAt,
  });

  Item.create({
    required this.name,
    required this.description,
    required this.worth,
    required this.address,
    required this.imageUrl,
    required this.catId,
    this.lat,
    this.long,
  }) : id = uuid.v4(),
       isFavorite = false,
       createdAt = DateTime.now(),
       updatedAt = DateTime.now();

  final String id;
  final String name;
  final String description;
  final double worth;
  final String address;
  final double? lat;
  final double? long;
  final String imageUrl;
  final String? catId;
  bool isFavorite;
  final DateTime createdAt;
  final DateTime updatedAt;
}
