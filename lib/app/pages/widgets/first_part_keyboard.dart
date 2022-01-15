import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:palavras/app/pages/home_controller.dart';
import 'package:palavras/app/pages/home_store.dart';
import 'package:palavras/app/pages/models/list_items.dart';

class FirstPartKeyboard extends StatelessWidget {
  FirstPartKeyboard({Key? key}) : super(key: key);

  final controller = GetIt.I.get<HomeController>();
  final store = GetIt.I.get<HomeStore>();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ListItems>>(
      valueListenable: store,
      builder: (context, value, child) {
        return Center(
          child: SizedBox(
            height: 64,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: _firstPartBuilder(context),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _firstPartBuilder(BuildContext context) {
    final data = <Widget>[];

    for (var i = 0; i < controller.firstPart.length; i++) {
      final contains = store.value[controller.current].lists.any((e) => e == controller.firstPart[i]);
      final notContains = controller.digits.contains(controller.firstPart[i]) && !controller.text.split('').contains(controller.firstPart[i]);

      data.add(
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (controller.finalized) return;

            store.addLetter(controller.firstPart[i], controller.current);
          },
          child: Container(
            margin: const EdgeInsets.all(4),
            width: 68,
            decoration: BoxDecoration(
              color: contains
                  ? Colors.green
                  : notContains
                      ? Colors.grey.shade700
                      : Colors.blueGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: Text(
              controller.firstPart[i],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      );
    }

    return data;
  }
}
