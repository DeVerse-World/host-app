extension StringExt on String? {
  String? orNull() {
    return this == "" ? null : this;
  }

  String orEmpty() {
    return this ?? "";
  }
}
