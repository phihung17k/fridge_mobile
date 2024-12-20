import 'dart:math';

import 'package:flutter/foundation.dart';
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
  late ScrollController controller;
  double itemExtent = 0;
  double scrollHeight = 0;
  double scrollPadding = 20;
  double scrollbarPostition = 0;
  double contentPostition = 0;
  double scrollbarHeight = 0;
  double itemListHeight = 0;
  late Map<String, int> alphabetMap;
  Map<String, double> contentOffsets = {};
  Map<String, double> alphabetOffsets = {};
  late final Iterable<String> alphabet;
  double letterBlockPadding = 8.0;

  double standardizedScrollbarHeight = 0;

  double clampMaxScrollExtent(double value) {
    return value.clamp(0, scrollHeight - scrollbarHeight);
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    alphabet = Iterable.generate(26, (index) => String.fromCharCode(index + 65));
    alphabetMap = {for (String letter in alphabet) letter: (1 + Random().nextInt(5))};
    alphabetMap['A'] = 2;
    alphabetMap['B'] = 5;
    alphabetMap['Z'] = 17;

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {},
    );
    controller.addListener(
      () {
        var offsets = contentOffsets.values;
        for (var i = 0; i < offsets.length; i++) {
          // debugPrint("controller position");

          // set scroll position = get (content offset - 1) when content offset > current content position
          // ex: { A: 0, B: 100, C: 200 } and current content position = 150
          // => identity C offset > current content position
          // => current content position is between B and C => set scroll position is B
          if (i > 0 && offsets.elementAt(i) > controller.position.pixels) {
            setState(() {
              // debugPrint("controller position ${controller.position.pixels}");
              scrollbarPostition = alphabetOffsets.values.elementAt(i - 1);
            });
            break;
          } else if (i == offsets.length - 1 && offsets.elementAt(i) < controller.position.pixels) {
            // case scroll to 'Z', set scroll position when current content position > content offset 'Z'
            setState(() {
              // debugPrint("controller position ${controller.position.pixels}");
              scrollbarPostition = alphabetOffsets.values.elementAt(i);
            });
            break;
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (itemExtent == 0) {
      debugPrint("build itemExtent == 0");
      itemExtent = MediaQuery.sizeOf(context).height / 20;
      itemListHeight = itemExtent * alphabet.length;

      for (var i = 0; i < alphabetMap.length; i++) {
        MapEntry<String, int> entry = alphabetMap.entries.elementAt(i);
        if (i == 0) {
          contentOffsets[entry.key] = 0;
        } else {
          // extent of a letter block =
          //  letter block padding top        [letterBlockPadding]
          //  + letter label                  [itemExtent]
          //  + list of letter block          [itemExtent] * length
          //  + letter block padding bottom   [letterBlockPadding]
          contentOffsets[entry.key] = contentOffsets.values.last +
              letterBlockPadding +
              itemExtent +
              itemExtent * alphabetMap.entries.elementAt(i - 1).value +
              letterBlockPadding;
        }
      }
    }
    return Row(
      children: [
        Expanded(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              // itemExtent: itemExtent,
              controller: controller,
              itemCount: alphabet.length,
              itemBuilder: (BuildContext context, int index) {
                MapEntry<String, int> entry = alphabetMap.entries.elementAt(index);

                return Container(
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey.shade300,
                        height: itemExtent,
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerLeft,
                        child: Text(entry.key),
                      ),
                      for (int i = 1; i <= entry.value; i++)
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
        ),
        Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              RenderBox renderbox = context.findRenderObject() as RenderBox;
              // debugPrint("WidgetsBinding.instance.addPostFrameCallback");

              /// set:
              /// - scrollbar's height
              /// - maximum scroll extent
              if (scrollHeight == 0) {
                setState(() {
                  scrollHeight = renderbox.size.height - scrollPadding * 2;
                  scrollbarHeight = scrollHeight / alphabetMap.length;
                  standardizedScrollbarHeight = clampMaxScrollExtent(scrollbarHeight);
                  alphabetOffsets = {
                    for (int i = 0; i < alphabet.length; i++)
                      alphabet.elementAt(i): scrollbarHeight * i
                  };
                  // debugPrint("WidgetsBinding.instance.addPostFrameCallback");
                });
              }
            },
          );
          // debugPrint("Builder WidgetsBinding.instance.addPostFrameCallback");
          return Container(
            width: 15,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(vertical: scrollPadding),
            height: double.maxFinite,
            color: Colors.yellow.shade100,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                // scroll in range [0..scroll height]
                if (0 <= scrollbarPostition && scrollbarPostition <= scrollHeight) {
                  setState(() {
                    scrollbarPostition += details.delta.dy;
                    debugPrint("onVerticalDragUpdate $scrollbarPostition ${details.localPosition}");
                  });
                }
              },
              onPanDown: (details) {
                // set scrollbar position in range [0..scroll height - scrollbarHeight] to avoid overrflow
                setState(() {
                  int index = (details.localPosition.dy / scrollbarHeight).floor();
                  scrollbarPostition = alphabetOffsets.values.elementAt(index);
                  controller.jumpTo(contentOffsets.values.elementAt(index));
                  debugPrint("onPanDown ${details.localPosition.dy}");
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blueGrey.shade50,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      // set scrollbar position to center when drag
                      top: clampMaxScrollExtent(scrollbarPostition),
                      // top: clampMaxScrollExtent(scrollbarPostition - scrollbarHeight / 2),
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
                        for (int i = 0; i < alphabet.length; i++)
                          Container(
                            height: standardizedScrollbarHeight,
                            // color: i == alphabet.length - 1 ? Colors.amber : null,
                            decoration: i < alphabet.length - 1
                                ? const BoxDecoration(border: Border(bottom: BorderSide()))
                                : null,
                            alignment: Alignment.center,
                            child: Text(
                              alphabet.elementAt(i),
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
