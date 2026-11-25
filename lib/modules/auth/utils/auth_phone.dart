/// Accepts local and +880 formats and sends the local format to the API.
String? normalizeAuthPhone(String phone) {
  const bengaliDigits = '০১২৩৪৫৬৭৮৯';
  var normalized = phone
      .replaceAllMapped(RegExp(r'[০-৯]'), (match) {
        return bengaliDigits.indexOf(match[0]!).toString();
      })
      .replaceAll(RegExp(r'[\s-]'), '');
  if (normalized.startsWith('+880')) {
    normalized = normalized.substring(3);
  }
  return RegExp(r'^01[3-9]\d{8}$').hasMatch(normalized) ? normalized : null;
}
