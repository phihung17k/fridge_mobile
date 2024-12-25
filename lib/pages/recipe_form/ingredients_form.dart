import 'package:flutter/material.dart';

import '../../utils/widgets/alphabet_list_scroll.dart';

class IngredientsForm extends StatelessWidget {
  const IngredientsForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ReorderableListView.builder(
        // buildDefaultDragHandles: false,
        padding: const EdgeInsets.all(8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            key: Key("reorder item $index"),
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              leading: const Image(
                image: AssetImage("assets/images/broccoli.png"),
              ),
              title: Text("Title $index"),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {},
        proxyDecorator: (child, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (BuildContext context, Widget? child) {
              // animation's effect for reorder itemw
              return Material(
                color: Colors.transparent,
                child: child,
              );
            },
            child: child,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          String? result = await showModalBottomSheet<String>(
            context: context,
            scrollControlDisabledMaxHeightRatio: 12 / 16,
            builder: (context) {
              return const AlphabetListScroll();
            },
          );
          debugPrint("result: $result");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
