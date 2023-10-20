import 'package:intl/intl.dart';

class CurrencyFormarter {
  static var currencyFormatter =
      NumberFormat.currency(locale: 'ID', symbol: "Rp ", decimalDigits: 0);

  String currency(price) {
    return currencyFormatter.format(price);
  }
}
