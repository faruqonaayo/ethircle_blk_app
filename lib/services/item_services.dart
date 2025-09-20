import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ethircle_blk_app/util/cloudinary.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:ethircle_blk_app/models/item.dart';

class ItemServices {
  static final _fireStore = FirebaseFirestore.instance;
  static final _fireAuth = FirebaseAuth.instance;

  static Future<String> addItem(Item item) async {
    final itemsCollection = _fireStore.collection("items");

    final itemMap = {
      "name": item.name,
      "description": item.description,
      "worth": item.worth,
      "address": item.address,
      "imageUrl": item.imageUrl,
      "catId": item.catId,
      "lat": item.lat,
      "long": item.long,
      "isFavorite": item.isFavorite ? 1 : 0,
      "createdAt": item.createdAt.toIso8601String(),
      "updatedAt": item.updatedAt.toIso8601String(),
    };

    final response = await itemsCollection.add({
      ...itemMap,
      "userID": _fireAuth.currentUser!.uid,
    });

    return response.id;
  }

  static void updateItem(String itemId, Item item) async {
    final itemsCollection = _fireStore.collection("items");
    final itemDoc = await itemsCollection.doc(itemId).get();

    if (itemDoc.exists &&
        itemDoc.data()?["userID"] == _fireAuth.currentUser!.uid) {
      final itemMap = {
        "name": item.name,
        "description": item.description,
        "worth": item.worth,
        "address": item.address,
        "imageUrl": item.imageUrl,
        "catId": item.catId,
        "lat": item.lat,
        "long": item.long,
        "isFavorite": item.isFavorite ? 1 : 0,
        "createdAt": item.createdAt.toIso8601String(),
        "updatedAt": DateTime.now().toIso8601String(),
      };
      await itemsCollection.doc(itemId).update(itemMap);
    }
  }

  static void deleteItem(String itemId) async {
    final itemsCollection = _fireStore.collection("items");
    final itemDoc = await itemsCollection.doc(itemId).get();

    if (itemDoc.exists &&
        itemDoc.data()?["userID"] == _fireAuth.currentUser!.uid) {
      itemsCollection.doc(itemId).delete();
    }
  }

  static Future<String> saveImage(File? image) async {
    if (image == null) {
      return "";
    }

    final imagePath = await uploadToCloudinary(image);

    return imagePath;
  }
}
