import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:palavras/app/pages/home_controller.dart';
import 'package:palavras/app/pages/home_store.dart';
import 'package:palavras/app/pages/widgets/first_part_keyboard.dart';
import 'package:palavras/app/pages/widgets/grid_view_builder.dart';
import 'package:palavras/app/pages/widgets/second_part_keyboard.dart';
import 'package:palavras/app/pages/widgets/third_part_keyboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final store = GetIt.I.get<HomeStore>();
  final controller = GetIt.I.get<HomeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (controller.finalized) {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Deseja começar novamente?'),
                content: Text('Sua ultima pontuação foi ${Hive.box('box').get('streak')}'),
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
      },
      child: Scaffold(
        body: ListView(
          children: [
            const SizedBox(height: 100),
            GridViewBuilder(),
            FirstPartKeyboard(),
            SecondPartKeyboard(),
            ThirdPartKeyboard(),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                width: 900,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box('box').listenable(),
                    builder: (context, box, child) {
                      box as Box;

                      return Text('Sequência atual ${box.get('streak')}');
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
