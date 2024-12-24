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
    return AlphabetListScroll();
  }
}
