import 'package:intl/intl.dart';

String formatPrice(String string) {
  return NumberFormat.decimalPattern().format(
    int.parse(string),
  );
}
