import 'package:flutter/material.dart';
import 'package:fridge_mobile/utils/widgets/alphabet_list_scroll.dart';

class StepsForm extends StatefulWidget {
  const StepsForm({super.key});

  @override
  State<StepsForm> createState() => _StepsFormState();
}

class _StepsFormState extends State<StepsForm> {
  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemCount: 1,
      shrinkWrap: true,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return Row(
          key: ValueKey("reorder $index"),
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
              child: const Center(child: Text("1")),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
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
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.add_photo_alternate_outlined),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.amber,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Image(
                          image: const AssetImage("assets/images/tomato.png"),
                          height: MediaQuery.sizeOf(context).height / 10,
                        ),
                      ),
                      // Container(
                      //   margin: const EdgeInsets.only(right: 10),
                      //   decoration: BoxDecoration(
                      //     shape: BoxShape.rectangle,
                      //     color: Colors.amber,
                      //     borderRadius: BorderRadius.circular(20),
                      //   ),
                      //   child: Image(
                      //     image: const AssetImage("assets/images/tomato.png"),
                      //     height: MediaQuery.sizeOf(context).height / 10,
                      //   ),
                      // ),
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
      onReorder: (oldIndex, newIndex) {},
    );
  }
}
