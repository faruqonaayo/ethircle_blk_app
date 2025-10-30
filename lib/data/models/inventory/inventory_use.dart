import 'package:flutter/material.dart';

enum InventoryUse {
  business("Business", Icons.business),
  education("Education", Icons.book),
  personal("Personal", Icons.person),
  other("Other", Icons.more_horiz);

  final String text;
  final IconData icon;
  const InventoryUse(this.text, this.icon);
}
