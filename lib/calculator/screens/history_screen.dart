import 'package:first_mobile_app/calculator/models/calculation.dart';
import 'package:first_mobile_app/calculator/widgets/app_drawer.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              Hive.box<Calculation>('calculations').clear();
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: ValueListenableBuilder(
        valueListenable: Hive.box<Calculation>('calculations').listenable(),
        builder: (context, Box<Calculation> box, _) {
          if (box.values.isEmpty) {
            return const Center(child: Text('No history yet.'));
          }
          return ListView.builder(
            itemCount: box.values.length,
            itemBuilder: (context, index) {
              final actualIndex = box.length - 1 - index;
              final calculation = box.getAt(actualIndex) as Calculation;
              return Dismissible(
                key: Key('${calculation.timestamp.millisecondsSinceEpoch}'),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  box.deleteAt(actualIndex);
                },
                child: ListTile(
                  title: Text(
                    '${calculation.expression} = ${calculation.result}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().add_jm().format(calculation.timestamp),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
