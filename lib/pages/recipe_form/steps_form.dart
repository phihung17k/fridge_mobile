import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/recipe_form/step_item.dart';

import '../../utils/proxy_decorator.dart';

class StepsForm extends StatefulWidget {
  const StepsForm({super.key});

  @override
  State<StepsForm> createState() => _StepsFormState();
}

class _StepsFormState extends State<StepsForm> {
  int counter = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double imageWidth = MediaQuery.sizeOf(context).width / 4;
    double imageHeight = MediaQuery.sizeOf(context).width / 5;
    return Scaffold(
      body: ReorderableListView.builder(
        itemCount: counter,
        shrinkWrap: true,
        padding: const EdgeInsets.all(10.0),
        itemBuilder: (context, index) {
          return StepItem(
            key: ValueKey("ReorderableListView $index"),
            imageWidth: imageWidth,
            imageHeight: imageHeight,
            index: index,
          );
        },
        onReorder: (oldIndex, newIndex) {},
        proxyDecorator: (child, index, animation) {
          return ProxyDecorator(animation: animation, child: child);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
