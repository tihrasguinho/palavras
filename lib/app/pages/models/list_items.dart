class ListItems {
  List<String> lists;
  bool done;

  ListItems({
    required this.lists,
    this.done = false,
  });

  @override
  String toString() => 'ListItems(lists: $lists, done: $done)';
}
