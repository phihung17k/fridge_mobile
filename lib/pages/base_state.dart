import 'package:flutter/material.dart';
import 'package:fridge_mobile/blocs/base_bloc.dart';
import 'package:get_it/get_it.dart';

import '../animations/loading_widget.dart';

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc> extends State<T> {
  late final B bloc;

  @mustCallSuper
  @override
  void initState() {
    super.initState();
    bloc = GetIt.I.get<B>();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildContent(context),
        StreamBuilder<bool>(
            stream: bloc.loadingStream,
            builder: (context, snapshot) {
              if (snapshot.data == true) {
                return Container(
                  color: Colors.grey.withOpacity(0.4),
                  child: const Center(
                    child: LoadingWidget(),
                  ),
                );
              }
              return const SizedBox();
            }),
      ],
    );
  }

  Widget buildContent(BuildContext context) => Container();

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
