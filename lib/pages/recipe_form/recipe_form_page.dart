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
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Name",
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
                      ),
                      maxLines: null,
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
