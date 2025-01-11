import 'package:flutter/material.dart';

class CookTimeDialog extends StatefulWidget {
  final int? initialHour;
  final int? initialMinute;
  final double? labelItemExtent;
  final int itemCount;
  final double listWheelScrollWidth;
  final double listWheelScrollOpacity;
  final double listWheelScrollPerspective;
  final double listWheelScrollItemExtent;
  final double listWheelScrollItemDiameterRatio;
  final double? colonWidth;

  const CookTimeDialog({
    super.key,
    this.initialHour = 0,
    this.initialMinute = 0,
    this.labelItemExtent = 70,
    this.itemCount = 60,
    this.listWheelScrollWidth = 50,
    this.listWheelScrollOpacity = 0.5,
    this.listWheelScrollPerspective = 0.004,
    this.listWheelScrollItemExtent = 40,
    this.listWheelScrollItemDiameterRatio = 1.5,
    this.colonWidth = 20,
  });

  @override
  State<CookTimeDialog> createState() => _CookTimeDialogState();
}

class _CookTimeDialogState extends State<CookTimeDialog> {
  late FixedExtentScrollController _hourScrollController;
  late FixedExtentScrollController _minuteScrollController;
  final int hourLength = 100;
  final int minuteLength = 60;

  int standardizeTime(int time, int length) {
    /// fix error: get negative value when scroll reverse
    /// if time = -1 mean time = length - 1
    while (time < 0) {
      time += length;
    }
    while (time > length) {
      time -= length;
    }
    return time;
  }

  @override
  void initState() {
    super.initState();

    _hourScrollController = FixedExtentScrollController(initialItem: widget.initialHour!);
    _minuteScrollController = FixedExtentScrollController(initialItem: widget.initialMinute!);
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
          onPressed: () {
            Navigator.pop(context, (
              standardizeTime(_hourScrollController.selectedItem, hourLength),
              standardizeTime(_minuteScrollController.selectedItem, minuteLength),
            ));
          },
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
                      SizedBox(
                        width: widget.listWheelScrollWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: _hourScrollController,
                          itemExtent: widget.listWheelScrollItemExtent,
                          diameterRatio: widget.listWheelScrollItemDiameterRatio,
                          overAndUnderCenterOpacity: widget.listWheelScrollOpacity,
                          perspective: widget.listWheelScrollPerspective,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: [
                              for (int i = 0; i < hourLength; i++)
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
                      ),
                      SizedBox(
                        width: widget.colonWidth,
                        child: Text(
                          ":",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                      ),
                      SizedBox(
                        width: widget.listWheelScrollWidth,
                        child: ListWheelScrollView.useDelegate(
                          controller: _minuteScrollController,
                          itemExtent: widget.listWheelScrollItemExtent,
                          diameterRatio: widget.listWheelScrollItemDiameterRatio,
                          overAndUnderCenterOpacity: widget.listWheelScrollOpacity,
                          perspective: widget.listWheelScrollPerspective,
                          physics: const FixedExtentScrollPhysics(),
                          childDelegate: ListWheelChildLoopingListDelegate(
                            children: [
                              for (int i = 0; i < minuteLength; i++)
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

  @override
  void dispose() {
    _hourScrollController.dispose();
    _minuteScrollController.dispose();
    super.dispose();
  }
}
