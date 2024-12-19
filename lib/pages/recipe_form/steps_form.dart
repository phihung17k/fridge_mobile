import 'dart:math';

import 'package:flutter/material.dart';

class StepsForm extends StatefulWidget {
  const StepsForm({super.key});

  @override
  State<StepsForm> createState() => _StepsFormState();
}

class CustomScrollableScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that does not let the user scroll.
  const CustomScrollableScrollPhysics({super.parent});

  @override
  CustomScrollableScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollableScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  bool get allowUserScrolling => true;

  @override
  bool get allowImplicitScrolling => false;
}

class _StepsFormState extends State<StepsForm> {
  late ScrollController _controller;
  double itemExtent = 0;
  double scrollHeight = 0;
  double scrollPadding = 20;
  double scrollbarPostition = 0;
  double scrollbarHeight = 0;
  double itemListHeight = 0;
  int itemsCount = 0;
  late Map<String, int> alphabetMap;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    Iterable<int> alphabetList = Iterable.generate(26);
    alphabetMap = {
      for (var item in alphabetList) String.fromCharCode(item + 65): Random().nextInt(5)
    };
    alphabetMap['B'] = 27;
    itemsCount = alphabetList.length;
  }

  @override
  Widget build(BuildContext context) {
    if (itemExtent == 0) {
      itemExtent = MediaQuery.sizeOf(context).height / 20;
      itemListHeight = itemExtent * itemsCount;
    }
    return Row(
      children: [
        Expanded(
          child:
              // Stack(
              //   children: [
              ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: true),
            child: ListView.builder(
              // itemExtent: itemExtent,
              controller: _controller,
              itemCount: itemsCount,
              itemBuilder: (BuildContext context, int index) {
                MapEntry<String, int> entry = alphabetMap.entries.elementAt(index);
                return Container(
                  // color: index % 2 == 0 ? Colors.grey.shade300 : null,
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  // child: Text('Scrollable 1 : Index $index'),
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade300,
                        height: itemExtent,
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(entry.key),
                      ),
                      for (int i = 0; i <= entry.value; i++)
                        Container(
                          color: Colors.blue.shade300,
                          height: itemExtent,
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.centerLeft,
                          child: Text("Scrollable ${entry.key} : Index $i"),
                        )
                    ],
                  ),
                );
              },
            ),
          ),
          // Positioned(
          //   bottom: 10,
          //   right: 10,
          //   width: 100,
          //   height: 30,
          //   child: TextField(
          //     onSubmitted: (value) {
          //       // debugPrint(_controller.position.toString());
          //       // debugPrint(_controller.positions.toString());
          //       // debugPrint(_controller.position.pixels.toString());
          //       // debugPrint(_controller.positions.length.toString());
          //       _controller.jumpTo(itemExtent * int.parse(value));
          //     },
          //   ),
          // ),
          //   ],
          // ),
        ),
        Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              var renderbox = context.findRenderObject() as RenderBox;

              /// set:
              /// - scrollbar's height
              /// - maximum scroll extent
              if (scrollHeight == 0) {
                setState(() {
                  scrollHeight = renderbox.size.height - scrollPadding * 2;
                  scrollbarHeight = scrollHeight / 26;
                  // debugPrint("WidgetsBinding.instance.addPostFrameCallback");
                });
              }
            },
          );

          return Container(
            width: 15,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(vertical: scrollPadding),
            height: double.maxFinite,
            color: Colors.yellow.shade100,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blueGrey.shade50,
              ),
              child: GestureDetector(
                onVerticalDragUpdate: (details) {
                  setState(() {
                    scrollbarPostition += details.delta.dy;
                    debugPrint("onVerticalDragUpdate");
                  });
                },
                onPanDown: (details) {
                  // set scrollbar position in range [0..scroll height - scrollbarHeight] to avoid overrflow
                  setState(() {
                    scrollbarPostition = details.localPosition.dy;
                    debugPrint("onPanDown");
                    // _controller.jumpTo(value)
                  });
                },
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      // set scrollbar position to center when drag
                      top: (scrollbarPostition - scrollbarHeight / 2)
                          .clamp(0, scrollHeight - scrollbarHeight),
                      duration: Duration.zero,
                      child: Container(
                        width: 15,
                        height: scrollbarHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightBlue,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        for (int i = 65; i <= 90; i++)
                          Container(
                            height: scrollbarHeight.clamp(0, scrollHeight - scrollbarHeight),
                            decoration: i != 90
                                ? const BoxDecoration(border: Border(bottom: BorderSide()))
                                : null,
                            alignment: Alignment.center,
                            child: Text(
                              String.fromCharCode(i),
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        })
      ],
    );
  }
}
