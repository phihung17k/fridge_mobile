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
  late double itemExtent;
  double alphabetHeight = 0;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    itemExtent = 50;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            children: [
              // ScrollConfiguration(
              // behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              // behavior: ScrollBehavior(),
              // child:
              ListView.builder(
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
              // ),
              Positioned(
                bottom: 10,
                right: 10,
                width: 100,
                height: 30,
                child: TextField(
                  onSubmitted: (value) {
                    // debugPrint(_controller.position.toString());
                    // debugPrint(_controller.positions.toString());
                    // debugPrint(_controller.position.pixels.toString());
                    // debugPrint(_controller.positions.length.toString());
                    _controller.jumpTo(itemExtent * int.parse(value));
                  },
                ),
              ),
            ],
          ),
        ),
        Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback(
            (_) {
              var renderbox = context.findRenderObject() as RenderBox;
              debugPrint("test");
              if (alphabetHeight == 0) {
                setState(() {
                  alphabetHeight = renderbox.size.height - 20;
                });
              }
            },
          );

          return Container(
            width: 10,
            margin: EdgeInsets.zero,
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: double.maxFinite,
            color: Colors.yellow.shade100,
            child: Scrollbar(
              child: ListView(
                children: [
                  for (int i = 65; i <= 90; i++)
                    Container(
                      height: alphabetHeight / 26,
                      color: i % 2 == 0 ? Colors.blue.shade300 : null,
                      alignment: Alignment.center,
                      child: Text(
                        String.fromCharCode(i),
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )
                ],
              ),
            ),
          );
        })
      ],
    );
  }
}
