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
    required this.isFavorite,
  });

  Item.create({
    required this.name,
    required this.description,
    required this.worth,
    required this.address,
    required this.imageUrl,
    required this.catId,
  }) : id = uuid.v4(),
       isFavorite = false;

  final String id;
  final String name;
  final String description;
  final double worth;
  final String address;
  final String imageUrl;
  final String catId;
  bool isFavorite;
}
