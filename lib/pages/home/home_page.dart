import 'package:flutter/material.dart';
import 'package:fridge_mobile/models/ingredient_model.dart';
import 'package:fridge_mobile/utils/string_extension.dart';
import 'package:get_it/get_it.dart';

import '../../blocs/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc bloc;

  late TextEditingController textEditingController;

  final OverlayPortalController overlayPortalController = OverlayPortalController();
  final FocusNode focusNode = FocusNode();

  final LayerLink layerLink = LayerLink();

  late final ChipsInputEditingController inputController;
  String _previousText = '';
  TextSelection? _previousSelection;
  List<IngredientModel> _toppings = [];

  @override
  void initState() {
    super.initState();
    bloc = GetIt.I.get<HomeBloc>();
    textEditingController = TextEditingController();
    inputController = ChipsInputEditingController(_toppings);

    bloc.loadIngredients();

    inputController.addListener(
      () {
        // String currentText = inputController.text;
      },
    );
  }

  void _textListener() {
    final String currentText = inputController.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<IngredientModel> values = [..._toppings];

      // If the current number and the previous number of replacements are different, then
      // the user has deleted the InputChip using the keyboard. In this case, we trigger
      // the onChanged callback. We need to be sure also that the current number of
      // replacements is different from the input chip to avoid double-deletion.
      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        // widget.onChanged(values);
        // bloc .add event
        setState(() {
          _toppings = values;
        });
      }
    }

    _previousText = currentText;
    _previousSelection = inputController.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits.where((int u) => u == StringConstant.replacementChar).length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        leading: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Good morning"),
                Text(
                  "ABC",
                  textScaler: TextScaler.linear(1.5),
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        leadingWidth: 120,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Image(
              image: ExactAssetImage("assets/images/man.png", scale: 1.5),
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: CompositedTransformTarget(
              link: layerLink,
              child: OverlayPortal(
                controller: overlayPortalController,
                overlayChildBuilder: (context) {
                  double overlayWidth = MediaQuery.sizeOf(context).width;
                  return Positioned(
                    width: overlayWidth - 20,
                    child: CompositedTransformFollower(
                      link: layerLink,
                      targetAnchor: Alignment.bottomLeft,
                      child: Container(
                        constraints: const BoxConstraints(maxHeight: 200),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey,
                              spreadRadius: 0.1,
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: StreamBuilder<List<IngredientModel>>(
                            stream: bloc.optionsStream,
                            builder: (context, snapshot) {
                              List<IngredientModel> options = snapshot.data ?? [];
                              return ListView.builder(
                                shrinkWrap: true,
                                itemCount: options.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final IngredientModel option = options[index];
                                  Color? color;
                                  if (index == 0) {
                                    color = Theme.of(context).focusColor;
                                  }
                                  return InkWell(
                                    onTap: () {
                                      // onSelected(item);
                                      // List<IngredientModel> tempList =
                                      //     inputController.values.toList();
                                      // tempList.add(item);
                                      // inputController.updateValues(tempList);
                                      inputController.values.add(option);
                                      int length = inputController.values.length;
                                      inputController.value = TextEditingValue(
                                        text: StringConstant.replacementString * length,
                                        selection: TextSelection.collapsed(offset: length),
                                      );
                                      overlayPortalController.hide();
                                      bloc.removeSelectedOption(option);
                                    },
                                    child: Container(
                                      color: color,
                                      padding: const EdgeInsets.all(15.0),
                                      child: Text(option.name!),
                                    ),
                                  );
                                },
                              );
                            }),
                      ),
                    ),
                  );
                },
                child: TextField(
                  controller: inputController,
                  minLines: 1,
                  maxLines: 3,
                  focusNode: focusNode,
                  // onEditingComplete: onFieldSubmitted,
                  onTapOutside: (event) {
                    focusNode.unfocus();
                    // overlayPortalController.hide();
                  },
                  onChanged: (value) {
                    if (value.trim().isEmpty) {
                      overlayPortalController.hide();
                      return;
                    }

                    String textWithoutReplacements =
                        inputController.textWithoutReplacements.trim().toLowerCase();
                    // if (bloc.state.options!.any(
                    //     (item) => item.name!.toLowerCase().contains(textWithoutReplacements))) {
                    //   overlayPortalController.show();
                    // } else {
                    //   overlayPortalController.hide();
                    // }
                    bloc.filterOptions(textWithoutReplacements);
                    bloc.state.options!.isNotEmpty
                        ? overlayPortalController.show()
                        : overlayPortalController.hide();
                  },
                  onTap: () {},
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    suffixIcon: const Icon(
                      Icons.tune_rounded,
                      color: Colors.grey,
                    ),
                    hintText: "Find ingredient",
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 10, bottom: 0, left: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Ingredients",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 10),
              StreamBuilder<List<IngredientModel>>(
                stream: bloc.ingredientListStream,
                builder: (context, snapshot) {
                  List<IngredientModel>? ingredients = snapshot.data;
                  return GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 5,
                      crossAxisSpacing: 5,
                      mainAxisExtent: 120,
                    ),
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                    itemCount: ingredients?.length ?? 0,
                    itemBuilder: (context, index) {
                      IngredientModel ingredient = ingredients![index];
                      return InkWell(
                        onTap: () => bloc.selectIngredient(index),
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                              width: ingredient.isSelected ? 5 : 0.1,
                              color: ingredient.isSelected ? Colors.blue : Colors.transparent,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Image(
                                    image: AssetImage(ingredient.imageUrl!),
                                  ),
                                ),
                                Text(ingredient.name!)
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ChipsInputEditingController extends TextEditingController {
  ChipsInputEditingController(this.values)
      : super(
          text: StringConstant.replacementString * values.length,
        );

  List<IngredientModel> values;

  /// Called whenever chip is either added or removed
  /// from the outside the context of the text field.
  void updateValues(List<IngredientModel> values) {
    if (values.length != this.values.length) {
      final int length = values.length;
      value = TextEditingValue(
        text: StringConstant.replacementString * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    return text.replaceAll(RegExp(StringConstant.replacementString), '');
  }

  String get textWithReplacements => text;

  @override
  TextSpan buildTextSpan(
      {required BuildContext context, TextStyle? style, required bool withComposing}) {
    return super.buildTextSpan(context: context, withComposing: withComposing);

    // List<WidgetSpan> chipWidgets = [];
    // for (var i = 0; i < values.length; i++) {
    //   chipWidgets.add(WidgetSpan(
    //     child: ToppingInputChip(
    //       topping: values[i].name!,
    //       onDeleted: (_) {
    //         // setState(() {
    //         //   _toppings.remove(value);
    //         //   _suggestions = <String>[];
    //         //   debugPrint(
    //         //       "ToppingInputChip AAAAAAAAAAAAAA" + _toppings.join(', '));
    //         // });
    //         List<IngredientModel> tempList = values.toList();
    //         tempList.removeAt(i);
    //         updateValues(tempList);
    //       },
    //       onSelected: (value) {},
    //     ),
    //   ));
    // }

    // return TextSpan(
    //   style: style,
    //   children: <InlineSpan>[
    //     ...chipWidgets,
    //     if (textWithoutReplacements.isNotEmpty)
    //       TextSpan(text: textWithoutReplacements)
    //   ],
    // );
  }
}

class ToppingInputChip extends StatelessWidget {
  const ToppingInputChip({
    super.key,
    required this.topping,
    required this.onDeleted,
    required this.onSelected,
  });

  final String topping;
  final ValueChanged<String> onDeleted;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      child: InputChip(
        key: ObjectKey(topping),
        label: Text(topping),
        avatar: CircleAvatar(
          child: Text(topping[0].toUpperCase()),
        ),
        onDeleted: () => onDeleted(topping),
        onSelected: (bool value) => onSelected(topping),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.all(2),
      ),
    );
  }
}
