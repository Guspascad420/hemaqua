String formatNumber(double number) {
  String formatted = number.toStringAsFixed(2);

  if (formatted.endsWith('.00')) {
    return formatted.substring(0, formatted.length - 3);
  } else if (formatted.endsWith('.0')) {
    return formatted.substring(0, formatted.length - 2);
  }
  return formatted;
}