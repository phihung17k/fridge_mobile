import 'package:flutter/material.dart';

class ListWheelScrollItem extends StatelessWidget {
  final int itemCount;
  final double listWheelScrollWidth;
  final double listWheelScrollItemExtent;
  final double listWheelScrollItemDiameterRatio;
  final ValueChanged<int>? onSelectedItem;

  const ListWheelScrollItem({
    super.key,
    required this.onSelectedItem,
    this.itemCount = 60,
    this.listWheelScrollWidth = 50,
    this.listWheelScrollItemExtent = 40,
    this.listWheelScrollItemDiameterRatio = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: listWheelScrollWidth,
      child: ListWheelScrollView.useDelegate(
        itemExtent: listWheelScrollItemExtent,
        diameterRatio: listWheelScrollItemDiameterRatio,
        overAndUnderCenterOpacity: 0.5,
        perspective: 0.004,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: onSelectedItem,
        childDelegate: ListWheelChildLoopingListDelegate(
          children: [
            for (int i = 0; i < itemCount; i++)
              Container(
                alignment: Alignment.center,
                child: Text(
                  i < 10 ? "0$i" : "$i",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              )
          ],
        ),
      ),
    );
  }
}
