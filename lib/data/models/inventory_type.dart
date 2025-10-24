import 'package:flutter/material.dart';

enum InventoryType {
  consumable('Consumable', Colors.green),
  nonConsumable('Non Consumable', Colors.blue),
  mixed('Mixed', Colors.purple);

  final String text;
  final Color color;
  const InventoryType(this.text, this.color);
}
