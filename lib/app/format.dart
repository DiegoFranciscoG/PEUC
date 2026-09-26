/// Spanish (Ecuador) number and date formatting without extra dependencies.
String decimal(double value, {int digits = 1}) => value.toStringAsFixed(digits).replaceAll('.', ',');

String percent(double value, {int digits = 0}) => '${decimal(value, digits: digits)} %';

String thousands(int value) {
  final digits = value.toString();
  final buffer = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(' ');
    buffer.write(digits[i]);
  }
  return buffer.toString();
}

String shortDate(DateTime date) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(date.day)}/${two(date.month)}/${date.year} ${two(date.hour)}:${two(date.minute)}';
}

String clock(Duration duration) {
  final minutes = duration.inMinutes;
  final seconds = duration.inSeconds % 60;
  return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
}

/// "1 correcta", "2 correctas"...
String count(int n, String singular, String plural) => '$n ${n == 1 ? singular : plural}';
