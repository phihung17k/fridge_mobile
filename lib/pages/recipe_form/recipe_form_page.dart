import 'package:flutter/material.dart';

class RecipeFormPage extends StatefulWidget {
  const RecipeFormPage({super.key});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
  final _formKey = GlobalKey<FormState>();

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
              child: Text("Save"),
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
                      controller: TextEditingController(text: "00:00"),
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
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(child: SizedBox()),
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        // time
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            SizedBox(
                                              width: 60,
                                              child: ListWheelScrollView.useDelegate(
                                                itemExtent: 50,
                                                diameterRatio: 1.4,
                                                overAndUnderCenterOpacity: 0.5,
                                                perspective: 0.004,
                                                physics: const FixedExtentScrollPhysics(),
                                                childDelegate: ListWheelChildLoopingListDelegate(
                                                  children: [
                                                    for (int i = 0; i < 100; i++)
                                                      Container(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          i < 10 ? "0$i" : "$i",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineMedium,
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                              ":",
                                              style: Theme.of(context).textTheme.headlineLarge,
                                            ),
                                            SizedBox(
                                              width: 60,
                                              child: ListWheelScrollView.useDelegate(
                                                itemExtent: 50,
                                                diameterRatio: 1.4,
                                                overAndUnderCenterOpacity: 0.5,
                                                perspective: 0.004,
                                                physics: const FixedExtentScrollPhysics(),
                                                childDelegate: ListWheelChildLoopingListDelegate(
                                                  children: [
                                                    for (int i = 0; i < 100; i++)
                                                      Container(
                                                        alignment: Alignment.center,
                                                        child: Text(
                                                          i < 10 ? "0$i" : "$i",
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineMedium,
                                                        ),
                                                      )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // fade
                                        Positioned.fill(
                                          child: IgnorePointer(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Theme.of(context).dialogBackgroundColor,
                                                    const Color.fromARGB(0, 255, 255, 255),
                                                    Theme.of(context).dialogBackgroundColor,
                                                  ],
                                                  stops: const [0.05, 0.5, 0.95],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(child: SizedBox()),
                                ],
                              ),
                            );
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
}
