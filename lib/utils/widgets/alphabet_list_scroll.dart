import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fridge_mobile/utils/widgets/item_block.dart';

class AlphabetListScroll extends StatefulWidget {
  const AlphabetListScroll({super.key});

  @override
  State<AlphabetListScroll> createState() => _AlphabetListScrollState();
}

class _AlphabetListScrollState extends State<AlphabetListScroll> {
  /// Controls the content part.
  late ScrollController controller;

  /// Height of a label in the content part (scroll view).
  ///
  /// [labelExtent] is 1/20 viewport.
  ///
  /// Defaults to 0.
  double labelExtent = 0;

  /// Height of a item in the content part (scroll view).
  ///
  /// [itemExtent] is 1/20 viewport.
  ///
  /// Defaults to 0.
  double itemExtent = 0;

  /// Padding of the item block in the content part.
  double itemBlockPadding = 5.0;

  /// Height of the scroll line in the alphabet scroll part.
  ///
  /// [scrollLineHeight] is viewport - [scrollLinePadding].
  ///
  /// Defaults to 0.
  double scrollLineHeight = 0;

  /// Height of the scroll line padding in the alphabet scroll part.
  ///
  /// Defaults to 60.
  double scrollLinePadding = 60;

  /// Height of the scroll bar.
  ///
  /// This value depends on number of the letter list in [alphabetMap].
  /// The value is calculated by [scrollLineHeight] / [alphabetMap]'s length.
  ///
  /// Defaults to 0.
  double scrollbarHeight = 0;

  /// Position of scroll bar inside the alphabet scroll line.
  ///
  /// This value is calculated from top of viewport, in range [0..scroll height].
  ///
  /// Defaults to 0.
  double scrollbarPostition = 0;

  /// Dump data
  ///
  /// The value is used in the content part.
  /// Key is the letter, Value is number of the letter.
  /// For example, Key is 'A', Value is 5. Meaning a label 'A' and 5 item start 'A'.
  late Map<String, int> alphabetMap;

  /// The offsets in content part.
  ///
  /// Key is letter.
  /// Value is the content position that start by the label item:
  /// Height of a item block = item block padding top       [itemBlockPadding]
  ///                          + label item                 [labelExtent]
  ///                          + list of item block         [itemExtent] * [alphabetMap]'s length
  ///                          + item block padding bottom  [itemBlockPadding]
  ///
  /// The content position = the last content position + Height of the item block
  Map<String, double> contentOffsets = {};

  /// The offsets in the alphabet scroll part.
  ///
  /// Key is letter.
  /// Value is the letter position in scroll line.
  /// Value is calculated by [scrollbarHeight] * index of letter in [alphabet]
  Map<String, double> alphabetScrollOffsets = {};

  /// Maximum extent that scrollbar can be scroll in range [0..scrollHeight].
  double maxScrollExtent = 0;

  /// Whether the letter overlay is diplaying.
  ///
  /// [isOverlayVisible] is true during a scroll event or when tapping on the alphabet scroll line.
  /// Otherwise, [isOverlayVisible] is false.
  ///
  /// Defaults to false.
  bool isOverlayVisible = false;

  /// Whether the vertical drag is occurring.
  ///
  /// [isVerticalDrag] is true during a drag event.
  /// Otherwise, [isVerticalDrag] is false.
  ///
  /// Defaults to false.
  bool isVerticalDrag = false;

  /// The letter is scrolled in the alphabet scroll line.
  late String currentLetter;

  /// Width of the alphabet scroll line.
  ///
  /// Defaults to 15.
  double alphabetScrollLineWidth = 15;

  /// The letter index in the alphabet scroll line.
  ///
  /// The value is identity if the content part scrolls to end.
  int unableScrollLetterIndex = 0;

  /// Whether letter is visible in the alphabet scroll line.
  ///
  /// Defaults to false.
  bool isLetterVisible = false;

  double clampMaxScrollExtent(double value) {
    return value.clamp(0, scrollLineHeight - scrollbarHeight);
  }

  @override
  void initState() {
    super.initState();
    controller = ScrollController();
    Iterable<String> alphabet = Iterable.generate(26, (index) => String.fromCharCode(index + 65));
    alphabetMap = {for (String letter in alphabet) letter: (1 + Random().nextInt(5))};
    currentLetter = alphabetMap.keys.first;

    controller.addListener(
      () {
        if (!isVerticalDrag) {
          Iterable<double> offsets = contentOffsets.values;
          for (var i = 0; i < offsets.length; i++) {
            /// set scroll position = get the previous item offset (content offset - 1)
            /// when content offset > current content position
            /// ex: { A: 0, B: 100, C: 200 } and current content position = 150
            /// => identity C offset > current content position
            /// => current content position is between B and C => set scroll position is B
            if (i > 0 && offsets.elementAt(i) > controller.position.pixels) {
              setState(() {
                scrollbarPostition = alphabetScrollOffsets.values.elementAt(i - 1);
              });
              break;
            } else if (i == offsets.length - 1 &&
                offsets.elementAt(i) < controller.position.pixels) {
              // case scroll to 'Z', set scroll position when current content position > content offset 'Z'
              setState(() {
                scrollbarPostition = alphabetScrollOffsets.values.elementAt(i);
              });
              break;
            }
          }
        }
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        /// initial value
        if (scrollLineHeight == 0) {
          setState(() {
            scrollLineHeight = controller.position.viewportDimension - scrollLinePadding * 2;
            scrollbarHeight = scrollLineHeight / alphabetMap.length;
            maxScrollExtent = clampMaxScrollExtent(scrollbarHeight);
            alphabetScrollOffsets = {
              for (int i = 0; i < alphabetMap.keys.length; i++)
                alphabetMap.keys.elementAt(i): scrollbarHeight * i
            };
          });
        }
      },
    );
  }

  Widget displayLetterOverlay() {
    if (isOverlayVisible) {
      return AnimatedPositioned(
        top: clampMaxScrollExtent(scrollbarPostition) + scrollLinePadding - 60 / 4,
        right: alphabetScrollLineWidth + 40,
        duration: Duration.zero,
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.lightGreen,
          ),
          child: Center(
            child: Text(
              currentLetter,
              style: const TextStyle(fontSize: 40, color: Colors.white),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    if (itemExtent == 0) {
      double height = MediaQuery.sizeOf(context).height;
      itemExtent = height / 20;
      labelExtent = height / 24;
      for (var i = 0; i < alphabetMap.length; i++) {
        MapEntry<String, int> entry = alphabetMap.entries.elementAt(i);
        if (i == 0) {
          contentOffsets[entry.key] = 0;
        } else {
          contentOffsets[entry.key] = contentOffsets.values.last +
              itemBlockPadding +
              labelExtent +
              itemExtent * alphabetMap.entries.elementAt(i - 1).value +
              itemBlockPadding;
        }
      }
    }
    return Stack(
      children: [
        // Scroll view / Content part
        ColoredBox(
          color: Colors.grey.shade100,
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              controller: controller,
              itemCount: alphabetMap.keys.length,
              itemBuilder: (BuildContext context, int index) {
                MapEntry<String, int> entry = alphabetMap.entries.elementAt(index);
                return ItemBlock(
                  labelExtent: labelExtent,
                  itemExtent: itemExtent,
                  label: entry.key,
                  numOfItem: entry.value,
                  itemBlockPadding: itemBlockPadding,
                );
              },
            ),
          ),
        ),
        // Scroll line
        Positioned(
          right: 0,
          child: Container(
            width: alphabetScrollLineWidth,
            margin: EdgeInsets.zero,
            padding: EdgeInsets.symmetric(vertical: scrollLinePadding),
            // color: Colors.yellow.shade100,
            child: GestureDetector(
              onVerticalDragUpdate: (details) {
                // ensure scrollbarPostition in range [0..scroll height]
                if (0 <= details.localPosition.dy && details.localPosition.dy <= scrollLineHeight) {
                  int index = (details.localPosition.dy / scrollbarHeight)
                      .floor()
                      .clamp(0, contentOffsets.length - 1);
                  MapEntry<String, double> offsetMap = contentOffsets.entries.elementAt(index);

                  setState(() {
                    // scrollbarPostition += details.delta.dy;
                    scrollbarPostition = details.localPosition.dy;
                    currentLetter = offsetMap.key;
                    isVerticalDrag = true;
                    isOverlayVisible = true;
                    if (unableScrollLetterIndex == 0 && controller.position.extentAfter == 0) {
                      unableScrollLetterIndex = index;
                    }
                  });

                  if (controller.position.extentAfter > 0 || unableScrollLetterIndex > index) {
                    controller.jumpTo(contentOffsets.values.elementAt(index));
                  }
                }
              },
              onVerticalDragEnd: (details) {
                setState(() {
                  isVerticalDrag = false;
                  isOverlayVisible = false;
                });
              },
              onPanDown: (details) {
                /// set scrollbar position in range [0..scroll height - scrollbarHeight] to
                /// avoid overflow
                int index = (details.localPosition.dy / scrollbarHeight).floor();
                MapEntry<String, double> offsetMap = alphabetScrollOffsets.entries.elementAt(index);
                setState(() {
                  scrollbarPostition = offsetMap.value;
                  currentLetter = offsetMap.key;
                  isOverlayVisible = true;
                  if (unableScrollLetterIndex == 0 && controller.position.extentAfter == 0) {
                    unableScrollLetterIndex = index;
                  }
                });
                if (controller.position.extentAfter > 0 || unableScrollLetterIndex > index) {
                  controller.jumpTo(contentOffsets.values.elementAt(index));
                }
              },
              onPanCancel: () {
                setState(() {
                  isOverlayVisible = false;
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
                      top: clampMaxScrollExtent(scrollbarPostition),
                      duration: isVerticalDrag ? Duration.zero : const Duration(milliseconds: 150),
                      child: Container(
                        width: 15,
                        height: scrollbarHeight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.lightGreen,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        for (int i = 0; i < alphabetMap.keys.length; i++)
                          Container(
                            height: maxScrollExtent,
                            // decoration: i < alphabetMap.keys.length - 1
                            //     ? const BoxDecoration(border: Border(bottom: BorderSide()))
                            //     : null,
                            alignment: Alignment.center,
                            child: Text(
                              isLetterVisible ? alphabetMap.keys.elementAt(i) : "",
                              style: Theme.of(context).textTheme.labelMedium,
                            ),
                          )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        displayLetterOverlay(),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
