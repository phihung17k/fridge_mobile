import 'package:flutter/material.dart';

class ItemBlock extends StatelessWidget {
  final double labelExtent;
  final double itemExtent;
  final String label;
  final int numOfItem;
  final double itemBlockPadding;
  const ItemBlock({
    super.key,
    this.labelExtent = 0,
    this.itemExtent = 0,
    this.label = "#",
    this.numOfItem = 0,
    this.itemBlockPadding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: itemBlockPadding),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          Container(
            // color: Colors.lightBlue.shade300,
            height: labelExtent,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            alignment: Alignment.centerLeft,
            child: Text(label),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (int i = 1; i <= numOfItem; i++)
                  Container(
                    height: itemExtent,
                    padding: const EdgeInsets.all(16.0),
                    alignment: Alignment.centerLeft,
                    child: Text("Scrollable $label : Index $i"),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
