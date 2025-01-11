import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class StepItem extends StatefulWidget {
  final double imageWidth;
  final double imageHeight;
  final int index;
  const StepItem(
      {super.key, required this.imageWidth, required this.imageHeight, required this.index});

  @override
  State<StepItem> createState() => _StepItemState();
}

class _StepItemState extends State<StepItem> {
  final ImagePicker picker = ImagePicker();
  final List<XFile> images = [];
  final TextEditingController textController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey("_StepItemState ${widget.index}"),
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Row(
        key: ValueKey("reorder Row ${widget.index}"),
        spacing: 10,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(
              minHeight: 30,
              minWidth: 30,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColorLight,
            ),
            child: Center(child: Text("${widget.index + 1}")),
          ),
          Expanded(
            child: Column(
              spacing: 15,
              children: [
                TextField(
                  controller: textController,
                  decoration: const InputDecoration(
                    isDense: true,
                  ),
                  textInputAction: TextInputAction.done,
                  maxLines: null,
                  maxLength: 500,
                  buildCounter: (
                    context, {
                    required currentLength,
                    required isFocused,
                    required maxLength,
                  }) {
                    return Row(
                      children: [
                        Text(
                          isFocused ? 'Content ($currentLength/$maxLength)' : 'Content',
                        ),
                      ],
                    );
                  },
                ),
                Row(
                  spacing: 15,
                  children: [
                    for (int i = 0; i < images.length; i++)
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            width: widget.imageWidth,
                            height: widget.imageHeight,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image(
                              fit: BoxFit.cover,
                              image: FileImage(File(images[i].path)),
                            ),
                          ),
                          Positioned(
                            top: -22,
                            right: -22,
                            child: IconButton(
                              color: Colors.red,
                              // padding: EdgeInsets.zero,
                              onPressed: () {
                                images.removeAt(i);
                                setState(() {});
                              },
                              icon: const Icon(Icons.remove_circle_rounded),
                            ),
                          ),
                        ],
                      ),
                    if (images.length < 3)
                      IconButton(
                        onPressed: () {
                          picker.pickImage(source: ImageSource.gallery).then(
                            (value) {
                              if (value != null) {
                                images.add(value);
                                setState(() {});
                              }
                            },
                          );
                        },
                        icon: const Icon(Icons.add_photo_alternate_outlined),
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fixedSize: Size(widget.imageWidth, widget.imageHeight),
                        ),
                      ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
