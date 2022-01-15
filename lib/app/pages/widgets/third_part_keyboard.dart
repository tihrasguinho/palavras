import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palavras/app/pages/home_controller.dart';
import 'package:palavras/app/pages/home_store.dart';
import 'package:palavras/app/pages/models/list_items.dart';

class ThirdPartKeyboard extends StatelessWidget {
  ThirdPartKeyboard({Key? key}) : super(key: key);

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
              children: _thirdPartBuilder(context),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _thirdPartBuilder(BuildContext context) {
    final data = <Widget>[];

    for (var i = 0; i < controller.thirdPart.length; i++) {
      final contains = store.value[controller.current].lists.any((e) => e == controller.thirdPart[i]);

      final isEnter = controller.thirdPart[i] == 'enter';

      final notContains = controller.digits.contains(controller.thirdPart[i]) && !controller.text.split('').contains(controller.thirdPart[i]);

      data.add(
        InkWell(
          hoverColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onTap: () async {
            if (controller.finalized) return;

            if (isEnter) {
              if (store.value[controller.current].lists.length == 5) {
                final str = store.value[controller.current].lists.join();

                try {
                  var check = controller.checkText(str);

                  if (check) {
                    await showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text('BOA!!!'),
                        content: const Text('Deseja ir para próxima palavra?'),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          MaterialButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              controller.next();
                            },
                            color: Colors.blueGrey,
                            child: const SizedBox(
                              height: 42,
                              child: Center(child: Text('Sim, por favor!')),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              controller.finalized = true;
                              Navigator.of(ctx).pop();
                            },
                            color: Colors.grey.shade600,
                            child: const SizedBox(
                              height: 42,
                              child: Center(child: Text('Não, desejo sair.')),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                } on Exception catch (e) {
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Você errou!'),
                        content: const Text('Deseja iniciar novamente?'),
                        actionsAlignment: MainAxisAlignment.spaceEvenly,
                        actions: [
                          MaterialButton(
                            onPressed: () => controller.startAgain(context),
                            color: Colors.blueGrey,
                            child: const SizedBox(
                              height: 42,
                              child: Center(child: Text('Sim, por favor!')),
                            ),
                          ),
                          const SizedBox(height: 10),
                          MaterialButton(
                            onPressed: () {
                              controller.finalized = true;
                              Navigator.of(context).pop();
                            },
                            color: Colors.grey.shade600,
                            child: const SizedBox(
                              height: 42,
                              child: Center(child: Text('Não, desejo sair.')),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            } else {
              store.addLetter(controller.thirdPart[i], controller.current);
            }
          },
          child: Container(
            margin: EdgeInsets.only(
              top: 4,
              bottom: 4,
              left: isEnter ? 32 : 4,
              right: 4,
            ),
            width: isEnter ? 150 : 68,
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
              isEnter ? 'Enter' : controller.thirdPart[i],
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
        ),
      );
    }

    return data;
  }
}
