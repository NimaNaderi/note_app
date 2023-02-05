import 'package:flutter/material.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ValueNotifier<int> notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: notifier,
                builder: (context, value, child) {
                  return Text(
                    notifier.value.toString(),
                    style: TextStyle(fontSize: 48, color: Colors.amber),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () {
                  notifier.value = notifier.value + 1;
                },
                child: Text('Add'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
