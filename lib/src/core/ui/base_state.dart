import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'helpers/loader.dart';
import 'helpers/messages.dart';

abstract class BaseState<T extends StatefulWidget, C extends BlocBase>
    extends State<T> with Loader, Messages, WidgetsBindingObserver {
  late final C controller;
  @override
  void initState() {
    super.initState();
    controller = context.read<C>();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      onReady();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void onReady() {}

  /// This routine is invoked when the window metrics have changed. Useful for our case
  @override
  void didChangeMetrics() {
    if (MediaQuery.of(context).viewInsets.bottom > 0) {
      SystemChrome.restoreSystemUIOverlays();
    }
  }
}
