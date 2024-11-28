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
                                children: [
                                  Flexible(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: 60,
                                          child: ListWheelScrollView.useDelegate(
                                            itemExtent: 50,
                                            diameterRatio: 0.6,
                                            overAndUnderCenterOpacity: 0.5,
                                            perspective: 0.005,
                                            physics: const FixedExtentScrollPhysics(),
                                            // scrollBehavior: ScrollBehavior(),
                                            // useMagnifier: true,
                                            // magnification: 1.5,
                                            childDelegate: ListWheelChildBuilderDelegate(
                                              childCount: 100,
                                              builder: (context, index) {
                                                return Text(
                                                  index < 10 ? "0$index" : "$index",
                                                  style: Theme.of(context).textTheme.headlineMedium,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 60,
                                          child: ListWheelScrollView.useDelegate(
                                            itemExtent: 50,
                                            diameterRatio: 0.6,
                                            overAndUnderCenterOpacity: 0.5,
                                            perspective: 0.005,
                                            physics: const FixedExtentScrollPhysics(),
                                            // scrollBehavior: ScrollBehavior(),
                                            // useMagnifier: true,
                                            // magnification: 1.5,
                                            childDelegate: ListWheelChildBuilderDelegate(
                                              childCount: 60,
                                              builder: (context, index) {
                                                return Text(
                                                  index < 10 ? "0$index" : "$index",
                                                  style: Theme.of(context).textTheme.headlineMedium,
                                                );
                                              },
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
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
