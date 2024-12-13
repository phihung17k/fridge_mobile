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
  double itemExtent = 50;
  double scrollHeight = 0;
  double scrollPadding = 20;
  double scrollbarPostition = 0;
  double scrollbarHeight = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child:
              // Stack(
              //   children: [
              ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: ListView.builder(
              itemExtent: itemExtent,
              controller: _controller,
              itemCount: 100,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: index % 2 == 0 ? Colors.grey.shade300 : null,
                  padding: const EdgeInsets.all(8.0),
                  alignment: Alignment.centerLeft,
                  child: Text('Scrollable 1 : Index $index'),
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
                  debugPrint("WidgetsBinding.instance.addPostFrameCallback");
                  // debugPrint("scrollHeight $scrollHeight");
                  // debugPrint("scrollbarHeight $scrollbarHeight");
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
