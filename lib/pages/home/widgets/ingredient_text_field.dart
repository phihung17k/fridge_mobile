import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/bloc_provider.dart';
import 'package:fridge_mobile/blocs/home/home_bloc.dart';

import '../../../models/ingredient_model.dart';

class IngredientTextField extends StatelessWidget {
  IngredientTextField({super.key});

  final OverlayPortalController overlayPortalController = OverlayPortalController();
  final FocusNode focusNode = FocusNode();
  final LayerLink layerLink = LayerLink();
  final TextEditingController inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    HomeBloc? bloc = BlocProvider.maybeOf<HomeBloc>(context);
    return SizedBox(
      child: CompositedTransformTarget(
        link: layerLink,
        child: OverlayPortal(
          controller: overlayPortalController,
          overlayChildBuilder: (context) {
            return Positioned(
              width: MediaQuery.sizeOf(context).width - 20,
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
                      stream: bloc?.optionsStream,
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
                                overlayPortalController.hide();
                                bloc?.selectOption(option);
                                inputController.text = '';
                                focusNode.requestFocus();
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
            focusNode: focusNode,
            onTapOutside: (event) {
              focusNode.unfocus();
            },
            onChanged: (value) {
              if (value.trim().isEmpty) {
                overlayPortalController.hide();
                return;
              }

              // show overlay option
              bloc?.filterOptions(value);
              bloc!.state.options!.isNotEmpty
                  ? overlayPortalController.show()
                  : overlayPortalController.hide();
            },
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
    );
  }
}
