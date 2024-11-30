import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/recipe_form/cook_time_dialog.dart';

class RecipeFormPage extends StatefulWidget {
  const RecipeFormPage({super.key});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _timeController;

  int hour = 0;
  int minute = 0;

  String combineTime(int hour, int minute) {
    String result = "";
    result = hour < 10 ? "0$hour" : "$hour";
    result = minute < 10 ? "$result : 0$minute" : "$result : $minute";
    return result;
  }

  @override
  void initState() {
    super.initState();
    _timeController = TextEditingController(text: combineTime(hour, minute));
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Recipe Form"),
          forceMaterialTransparency: true,
          // scrolledUnderElevation: 2,
          // surfaceTintColor: Colors.amber,
          actions: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert_outlined)),
            TextButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  ScaffoldMessengerState state = ScaffoldMessenger.of(context);
                  state.removeCurrentSnackBar();
                  state.showSnackBar(
                    const SnackBar(
                      content: Text('Processing Data'),
                      duration: Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                }
              },
              child: const Text("Save"),
            ),
          ],
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            onTap: (value) {},
            tabs: const <Widget>[
              Tab(text: "Overview"),
              Tab(text: "Ingredients"),
              Tab(text: "Steps"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Name",
                        labelStyle: Theme.of(context).textTheme.labelLarge,
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
                    TextField(
                      decoration: InputDecoration(
                        labelText: "Description",
                        labelStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _timeController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Cook Time",
                        labelStyle: Theme.of(context).textTheme.labelLarge,
                        prefixIcon: const Icon(Icons.access_time_rounded),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        )),
                      ),
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
                  ],
                ),
              ),
            ),
            Text("2"),
            Text("3"),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timeController.dispose();
    super.dispose();
  }
}
