import 'package:flutter/material.dart';

import 'cook_time_dialog.dart';

class OverviewForm extends StatefulWidget {
  const OverviewForm({super.key});

  @override
  State<OverviewForm> createState() => _OverviewFormState();
}

class _OverviewFormState extends State<OverviewForm> with AutomaticKeepAliveClientMixin {
  late final TextEditingController _timeController;
  late final TextEditingController _servingController;
  int hour = 0;
  int minute = 0;

  String combineTime(int hour, int minute) {
    String result = "";
    result = hour < 10 ? "0$hour" : "$hour";
    result = minute < 10 ? "$result : 0$minute" : "$result : $minute";
    return result;
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(text: combineTime(hour, minute));
    _servingController = TextEditingController(text: "1");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name", style: Theme.of(context).textTheme.labelLarge),
          TextFormField(
            decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
            ),
            maxLines: null, // multi line
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name is not empty";
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          Text("Description", style: Theme.of(context).textTheme.labelLarge),
          const TextField(
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
            ),
            maxLines: null,
          ),
          const SizedBox(height: 10),
          Text("Duration", style: Theme.of(context).textTheme.labelLarge),
          TextField(
            controller: _timeController,
            readOnly: true,
            decoration: const InputDecoration(
                filled: true,
                border: InputBorder.none,
                prefixIcon: Icon(Icons.access_time_rounded), // fix prefix & content align
                prefix: null, // not use
                contentPadding: EdgeInsets.all(15)), // fix prefix & content align
            textAlignVertical: TextAlignVertical.center, // fix prefix & content align
            onTap: () {
              showDialog<(int, int)>(
                context: context,
                builder: (context) {
                  return CookTimeDialog(
                    initialHour: hour,
                    initialMinute: minute,
                  );
                },
              ).then(
                ((int, int)? value) {
                  if (value != null) {
                    hour = value.$1;
                    minute = value.$2;
                    _timeController.text = combineTime(value.$1, value.$2);
                  }
                },
              );
            },
          ),
          const SizedBox(height: 10),
          Text("Serving", style: Theme.of(context).textTheme.labelLarge),
          TextField(
            controller: _servingController,
            decoration: const InputDecoration(
              filled: true,
              border: InputBorder.none,
              prefixIcon: Icon(Icons.person_outline),
              contentPadding: EdgeInsets.all(15),
            ),
            textAlignVertical: TextAlignVertical.center,
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timeController.dispose();
    _servingController.dispose();
    super.dispose();
  }
}
