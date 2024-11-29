import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/recipe_form/list_wheel_scroll_item.dart';

class CookTimeDialog extends StatefulWidget {
  final double? labelItemExtent;
  final int itemCount;
  final double listWheelScrollWidth;
  final double listWheelScrollItemExtent;
  final double listWheelScrollItemDiameterRatio;
  final double? colonWidth;

  const CookTimeDialog({
    super.key,
    this.labelItemExtent = 70,
    this.itemCount = 60,
    this.listWheelScrollWidth = 50,
    this.listWheelScrollItemExtent = 40,
    this.listWheelScrollItemDiameterRatio = 1.5,
    this.colonWidth = 20,
  });

  @override
  State<CookTimeDialog> createState() => _CookTimeDialogState();
}

class _CookTimeDialogState extends State<CookTimeDialog> {
  int hour = 0;
  int minute = 0;

  String combineTime(int hour, int minute) {
    String result = "";
    result = hour < 10 ? "0$hour" : "$hour";
    result = minute < 10 ? "$result : 0$minute" : "$result : $minute";
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Cook Time'),
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, combineTime(hour, minute)),
          child: const Text("Ok"),
        )
      ],
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height / 4,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: 200,
                height: 30,
                alignment: Alignment.center,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemExtent: widget.labelItemExtent,
                  // padding: EdgeInsets.zero,
                  children: [
                    Text(
                      "Hour",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      "Minute",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                )),
            Expanded(
              child: Stack(
                children: [
                  // time
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListWheelScrollItem(
                        itemCount: 100,
                        listWheelScrollWidth: widget.listWheelScrollWidth,
                        listWheelScrollItemExtent: widget.listWheelScrollItemExtent,
                        listWheelScrollItemDiameterRatio: widget.listWheelScrollItemDiameterRatio,
                        onSelectedItem: (value) => hour = value,
                      ),
                      SizedBox(
                        width: widget.colonWidth,
                        child: Text(
                          ":",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      ListWheelScrollItem(
                        itemCount: 60,
                        listWheelScrollWidth: widget.listWheelScrollWidth,
                        listWheelScrollItemExtent: widget.listWheelScrollItemExtent,
                        listWheelScrollItemDiameterRatio: widget.listWheelScrollItemDiameterRatio,
                        onSelectedItem: (value) => minute = value,
                      ),
                    ],
                  ),
                  // fade
                  Positioned.fill(
                    child: IgnorePointer(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Theme.of(context).dialogBackgroundColor,
                              const Color.fromARGB(0, 255, 255, 255),
                              Theme.of(context).dialogBackgroundColor,
                            ],
                            stops: const [0.05, 0.5, 0.95],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
