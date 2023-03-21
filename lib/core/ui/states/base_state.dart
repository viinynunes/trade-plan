import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trade_plan/core/ui/helpers/loader.dart';

abstract class BaseState<P extends StatefulWidget, C extends BlocBase>
    extends State<P> with Loader {
  late final C bloc;

  @override
  void initState() {
    super.initState();
    bloc = context.read<C>();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  void onReady() {}
}
