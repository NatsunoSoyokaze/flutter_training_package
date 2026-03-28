// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nfc/main.dart';

void main() {
  List inventors = [
    {'first': 'Albert', 'last': 'Einstein', 'year': 1879, 'passed': 1955},
    // 76
    {'first': 'Isaac', 'last': 'Newton', 'year': 1643, 'passed': 1727},
    // 84
    {'first': 'Galileo', 'last': 'Galilei', 'year': 1564, 'passed': 1642},
    // 78
    {'first': 'Marie', 'last': 'Curie', 'year': 1867, 'passed': 1934},
    // 67
    {'first': 'Johannes', 'last': 'Kepler', 'year': 1571, 'passed': 1630},
    // 59
    {'first': 'Nicolaus', 'last': 'Copernicus', 'year': 1473, 'passed': 1543},
    // 70
    {'first': 'Max', 'last': 'Planck', 'year': 1858, 'passed': 1947},
    // 89
    {'first': 'Katherine', 'last': 'Blodgett', 'year': 1898, 'passed': 1979},
    // 81
    {'first': 'Ada', 'last': 'Lovelace', 'year': 1815, 'passed': 1852},
    // 37
    {'first': 'Sarah E.', 'last': 'Goode', 'year': 1855, 'passed': 1905},
    // 50
    {'first': 'Lise', 'last': 'Meitner', 'year': 1878, 'passed': 1968},
    // 90
    {'first': 'Hanna', 'last': 'Hammarström', 'year': 1829, 'passed': 1909},
    // 80
  ];

  // 1. 1500年代に生まれた人の発明者の配列を出力
  print('- 1の解答 -');
  List list1 = inventors
      .where((item) => 1500 <= item['year'] && item['year'] < 1600)
      .toList();
  print(list1);

  // 2. 発明者の「姓（last）」と「名（first）」だけの配列を得る
  print('- 2の解答 -');
  List list2 = inventors.map((item) {
    return {'last': item['last'], 'first': item['first']};
  }).toList();
  print(list2);

  // 3. 発明者の配列を生年月日、古い順に並べ替える
  print('- 3の回答 -');
  inventors.sort((inv1, inv2) => inv1['year'].compareTo(inv2['year']));
  print(inventors);

  // 4. 全ての発明者の寿命の合計は？
  print('- 4の解答 -');
  int totalDeath = inventors.fold(
    0,
    (sum, item) => sum + ((item["passed"] as int) - (item["year"] as int)),
  );
  print(totalDeath);
}
