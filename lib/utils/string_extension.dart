class StringConstant {
  // This constant character acts as a placeholder in the TextField text value.
  // There will be one character for each of the InputChip displayed.
  static int get replacementChar => 0xFFFE;
  static String get replacementString => String.fromCharCode(replacementChar);
}
