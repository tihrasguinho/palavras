import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palavras/app/pages/home_store.dart';

class HomeController {
  final HomeStore store;

  HomeController(this.store) {
    fetchWords();
  }

  final wordList = ['FESTA', 'AREIA', 'VAMOS', 'GOSTO', 'FORMA', 'HOMEM'];

  void fetchWords() async {
    var json = await rootBundle.loadString('assets/words.json');
    var list = jsonDecode(json)['words'] as List;
    wordList.addAll(list.map((e) => e.toString().toUpperCase()));
  }

  final text = 'FESTA';

  final firstPart = ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'];
  final secondPart = ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L', 'backspace'];
  final thirdPart = ['Z', 'X', 'C', 'V', 'B', 'N', 'M', 'enter'];

  final digits = <String>[];

  bool finalized = false;

  bool ends = false;

  int current = 0;

  final streakNotifier = ValueNotifier<int>(0);
  void addStreak() => streakNotifier.value++;
  void resetStreak() => streakNotifier.value = 0;
  int get streak => streakNotifier.value;

  void next() {
    current = 0;
    digits.clear();
    store.resetList();
    addStreak();

    Hive.box('box').put('streak', streak);
  }

  void startAgain(BuildContext context) {
    Navigator.of(context).pop();
    finalized = false;
    resetStreak();
    digits.clear();
    current = 0;
    store.resetList();
    Hive.box('box').put('streak', 0);
  }

  bool checkText(String str) {
    digits.addAll(str.split(''));

    store.makeAsDone(current);

    if (current <= 3) current++;

    if (str == wordList[streak]) {
      Hive.box('box').put('streak', streak + 1);

      store.update();

      return true;
    } else {
      if (current == 4 && store.value[current].lists.length == 5) throw Exception('FAIL');

      store.update();

      return false;
    }
  }
}
