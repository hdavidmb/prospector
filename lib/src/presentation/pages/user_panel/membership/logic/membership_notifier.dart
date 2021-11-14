import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MembershipNotifier extends ChangeNotifier {
  final Reader read;
  MembershipNotifier({
    required this.read,
  });

  int _selectedIndex = 1;
  int get selectedIndex => _selectedIndex;
  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  int getPackageSavings(
      {required double price,
      required int months,
      required double basePrice,
      required int baseMonths}) {
    final double fullPrice = basePrice / baseMonths * months;
    final double savings = (fullPrice - price) / fullPrice * 100;
    return savings.round();
  }
}
