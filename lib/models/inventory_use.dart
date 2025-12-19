enum InventoryUse {
  personal,
  business,
  education,
  others;

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
