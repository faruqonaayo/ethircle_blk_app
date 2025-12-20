import 'package:flutter/material.dart';

enum InventoryUse {
  personal,
  business,
  education,
  others;

  Color get color {
    switch (this) {
      case InventoryUse.personal:
        return Colors.blue;
      case InventoryUse.business:
        return Colors.green;
      case InventoryUse.education:
        return Colors.orange;
      case InventoryUse.others:
        return Colors.deepPurple;
    }
  }

  String get name {
    switch (this) {
      case InventoryUse.personal:
        return 'Personal';
      case InventoryUse.business:
        return 'Business';
      case InventoryUse.education:
        return 'Education';
      case InventoryUse.others:
        return 'Others';
    }
  }
}
