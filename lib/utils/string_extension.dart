class StringConstant {
  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static int get replacementChar => 0xFFFE;
  static String get replacementString => String.fromCharCode(replacementChar);

  static String get recipeDescriptionSample =>
      "Một số khu vực ở Valencia ghi nhận lượng mưa hơn 300 mm trong ngày hôm đó, theo cơ quan khí tượng Tây Ban Nha AEMET. Tại thị trấn Chiva, lượng mưa gần 500 mm trút xuống trong 8 giờ.";
}
