import 'package:flutter/material.dart';
import 'package:palavras/app/pages/models/list_items.dart';

class HomeStore extends ValueNotifier<List<ListItems>> {
  HomeStore() : super([ListItems(lists: []), ListItems(lists: []), ListItems(lists: []), ListItems(lists: []), ListItems(lists: [])]);

  void resetList() {
    value = [ListItems(lists: []), ListItems(lists: []), ListItems(lists: []), ListItems(lists: []), ListItems(lists: [])];

    notifyListeners();
  }

  void addLetter(String str, int current) {
    if (value[current].lists.length <= 4) {
      var lists = value;

      lists[current].lists.add(str);

      value = lists;

      notifyListeners();
    }
  }

  void removeLetter(int current) {
    if (value[current].lists.isNotEmpty) {
      var lists = value;

      lists[current].lists.removeAt(lists[current].lists.length - 1);

      value = lists;

      notifyListeners();
    }
  }

  void makeAsDone(int current) {
    if (value[current].lists.isNotEmpty) {
      var lists = value;

      lists[current].done = true;

      value = lists;

      notifyListeners();
    }
  }

  void update() => notifyListeners();
}
