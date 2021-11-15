import 'package:intl/intl.dart';

String getFormattedPrice(
    {required double price, required String currencyCode}) {
  final NumberFormat numberFormat = NumberFormat.simpleCurrency(
      locale: 'en_US', name: currencyCode, decimalDigits: price >= 100 ? 0 : 2);
  return numberFormat.format(price);
}
