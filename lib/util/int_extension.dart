import 'package:intl/intl.dart';

extension PriceParsing on int {
  String changeToPrice() {
    final formatter = NumberFormat("#,##0.#", "en_US");
    var value = formatter.format(this);
    return value;
  }
}
