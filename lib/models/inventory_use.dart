import 'package:flutter/material.dart';

enum InventoryUse {
  personal("Personal", Colors.blue),
  business("Business", Colors.green),
  education("Education", Colors.orange),
  others("Others", Colors.deepPurple);

  const InventoryUse(this.displayName, this.displayColor);

  final String displayName;
  final Color displayColor;
}
