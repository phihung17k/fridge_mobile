import 'package:flutter/material.dart';
import 'package:fridge_mobile/models/ingredient_model.dart';

import '../../../blocs/bloc_provider.dart';
import '../../../blocs/home/home_bloc.dart';
import '../../../utils/app_color.dart';

class OptionChip extends StatefulWidget {
  final IngredientModel ingredient;
  const OptionChip({super.key, required this.ingredient});

  @override
  State<OptionChip> createState() => _OptionChipState();
}

class _OptionChipState extends State<OptionChip> with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  late final Animation<double> scaleAnimation;

  IngredientModel get ingredient => widget.ingredient;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(controller);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        controller.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    HomeBloc? bloc = BlocProvider.maybeOf<HomeBloc>(context);
    return ScaleTransition(
      key: widget.key,
      scale: scaleAnimation,
      child: Chip(
        label: Text(ingredient.name!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: const BorderSide(color: Colors.grey),
        ),
        backgroundColor: AppColor.chipColor,
        onDeleted: () {
          controller.reverse().whenComplete(() => bloc?.restoreOption(ingredient));
        },
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
