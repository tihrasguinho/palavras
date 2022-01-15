import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:palavras/app/pages/home_controller.dart';
import 'package:palavras/app/pages/home_store.dart';

class GridViewBuilder extends StatelessWidget {
  GridViewBuilder({Key? key}) : super(key: key);

  final store = GetIt.I.get<HomeStore>();
  final controller = GetIt.I.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ValueListenableBuilder(
        valueListenable: store,
        builder: (context, value, child) {
          return SizedBox(
            width: 400,
            height: 400,
            child: Column(
              children: _gridBuilder(context),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _itemsBuilder(List<String> items, BuildContext context) {
    final data = <Widget>[];

    for (var i = 0; i < 5; i++) {
      data.add(
        Container(
          height: 64,
          width: 64,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Text(
            items.length > i ? items[i] : '',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      );
    }

    return data;
  }

  List<Widget> _itemsDoneBuilder(List<String> items, BuildContext context) {
    final data = <Widget>[];

    for (var i = 0; i < 5; i++) {
      final list = controller.wordList[controller.streak].split('');
      final contains = list.any((e) => e == items[i]);
      final exactly = list[i] == items[i];
      final notContains = list.any((e) => e != items[i]);

      data.add(
        Container(
          height: 64,
          width: 64,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: contains && exactly
                ? Colors.green
                : contains
                    ? Colors.amber
                    : notContains
                        ? Colors.grey.shade900
                        : null,
            borderRadius: BorderRadius.circular(4),
            border: contains || notContains ? null : Border.all(color: Colors.white),
          ),
          alignment: Alignment.center,
          child: Text(
            items.length > i ? items[i] : '',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      );
    }

    return data;
  }

  List<Widget> _gridBuilder(BuildContext context) {
    final data = <Widget>[];

    for (var i = 0; i < store.value.length; i++) {
      final item = store.value[i];
      final isDone = item.done;

      data.add(
        Row(children: isDone ? _itemsDoneBuilder(item.lists, context) : _itemsBuilder(item.lists, context)),
      );
    }

    return data;
  }
}
