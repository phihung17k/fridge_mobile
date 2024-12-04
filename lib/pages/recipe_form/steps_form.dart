import 'package:flutter/material.dart';

class StepsForm extends StatefulWidget {
  const StepsForm({super.key});

  @override
  State<StepsForm> createState() => _StepsFormState();
}

class _StepsFormState extends State<StepsForm> {
  ScrollController _controller = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 10,
      controller: _controller,
      trackVisibility: true,
      child: ListView.builder(
        // primary: true,
        controller: _controller,
        itemCount: 100,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Scrollable 1 : Index $index'),
          );
        },
      ),
    );
  }
}
