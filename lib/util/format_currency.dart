import 'package:intl/intl.dart';

class FormatCurrency {
  final formatCurrency = NumberFormat.simpleCurrency();

  String formattedCost(int cost) {
    return formatCurrency.format(cost);
  }
}
