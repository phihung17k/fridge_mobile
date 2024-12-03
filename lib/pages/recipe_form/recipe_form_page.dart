import 'package:flutter/material.dart';
import 'package:fridge_mobile/pages/recipe_form/overview_form.dart';

class RecipeFormPage extends StatefulWidget {
  const RecipeFormPage({super.key});

  @override
  State<RecipeFormPage> createState() => _RecipeFormPageState();
}

class _RecipeFormPageState extends State<RecipeFormPage> {
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
  void initState() {
    super.initState();
    _timeController = TextEditingController(text: combineTime(hour, minute));
    _servingController = TextEditingController(text: "1");
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Form(
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
              Builder(builder: (context) {
                return TextButton(
                  onPressed: () {
                    if (!Form.of(context).validate()) {
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
                );
              }),
            ],
            bottom: const TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: <Widget>[
                Tab(text: "Overview"),
                Tab(text: "Ingredients"),
                Tab(text: "Steps"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              const OverviewForm(),
              Scaffold(
                body: ReorderableListView.builder(
                  // buildDefaultDragHandles: false,
                  padding: const EdgeInsets.all(8),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Card(
                      key: Key("reorder item $index"),
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                        leading: const Image(
                          image: AssetImage("assets/images/broccoli.png"),
                        ),
                        title: Text("Title $index"),
                        trailing: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.close,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    );
                  },
                  onReorder: (oldIndex, newIndex) {},
                  proxyDecorator: (child, index, animation) {
                    return AnimatedBuilder(
                      animation: animation,
                      builder: (BuildContext context, Widget? child) {
                        // animation's effect for reorder itemw
                        return Material(
                          color: Colors.transparent,
                          child: child,
                        );
                      },
                      child: child,
                    );
                  },
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          color: Colors.amber,
                        );
                      },
                    );
                  },
                  child: const Icon(Icons.add),
                ),
              ),
              Text("3"),
            ],
          ),
        ),
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
