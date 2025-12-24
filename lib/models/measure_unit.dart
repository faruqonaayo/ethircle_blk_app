enum MeasureUnit {
  piece("Piece"),
  kilogram("Kilogram"),
  liter("Liter"),
  meter("Meter"),
  box("Box");

  const MeasureUnit(this.displayName);
  final String displayName;
}
