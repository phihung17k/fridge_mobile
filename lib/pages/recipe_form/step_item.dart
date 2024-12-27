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
  final List<Future<XFile?>> images = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      key: ValueKey("_StepItemState ${widget.index}"),
      margin: const EdgeInsets.only(bottom: 10),
      color: Colors.transparent,
      child: Row(
        key: ValueKey("reorder Row ${widget.index}"),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
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
              children: [
                TextField(
                  decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 8),
                  ),
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
                const SizedBox(height: 10),
                Row(
                  children: [
                    for (int i = 0; i < images.length; i++)
                      FutureBuilder<XFile?>(
                        future: images[i],
                        builder: (context, snapshot) {
                          if (!snapshot.hasData || snapshot.data == null || snapshot.hasError) {
                            return const SizedBox();
                          }
                          return Container(
                            width: widget.imageWidth,
                            height: widget.imageHeight,
                            margin: const EdgeInsets.only(right: 8),
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            clipBehavior: Clip.hardEdge,
                            child: Image(
                              fit: BoxFit.cover,
                              image: FileImage(File(snapshot.data!.path)),
                            ),
                          );
                        },
                      ),
                    if (images.length < 3)
                      IconButton(
                        onPressed: () {
                          images.add(picker.pickImage(source: ImageSource.gallery));
                          setState(() {});
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
