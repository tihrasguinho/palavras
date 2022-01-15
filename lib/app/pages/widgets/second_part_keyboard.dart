import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:palavras/app/pages/home_controller.dart';
import 'package:palavras/app/pages/home_store.dart';
import 'package:palavras/app/pages/models/list_items.dart';

class SecondPartKeyboard extends StatelessWidget {
  SecondPartKeyboard({Key? key}) : super(key: key);

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
              children: _secondPartBuilder(context),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _secondPartBuilder(BuildContext context) {
    final data = <Widget>[];

    for (var i = 0; i < controller.secondPart.length; i++) {
      final contains = store.value[controller.current].lists.any((e) => e == controller.secondPart[i]);
      final isBackspace = controller.secondPart[i] == 'backspace';

      final notContains = controller.digits.contains(controller.secondPart[i]) && !controller.text.split('').contains(controller.secondPart[i]);

      data.add(
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () {
            if (controller.finalized) return;

            if (isBackspace) {
              if (controller.current == 4) {
                if (!store.value[controller.current].done) {
                  store.removeLetter(controller.current);
                }
              } else {
                store.removeLetter(controller.current);
              }
            } else {
              store.addLetter(controller.secondPart[i], controller.current);
            }
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: isBackspace ? 32 : 4,
              right: 4,
            ),
            width: isBackspace ? 150 : 68,
            decoration: BoxDecoration(
              color: contains
                  ? Colors.green
                  : notContains
                      ? Colors.grey.shade700
                      : Colors.blueGrey,
              borderRadius: BorderRadius.circular(4),
            ),
            alignment: Alignment.center,
            child: isBackspace
                ? const Icon(Icons.backspace_rounded)
                : Text(
                    controller.secondPart[i],
                    style: Theme.of(context).textTheme.headline5,
                  ),
          ),
        ),
      );
    }

    return data;
  }
}
