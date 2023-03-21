import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

mixin Loader<T extends StatefulWidget> on State<T> {
  bool isOpen = false;

  void showLoader() {
    if (!isOpen) {
      isOpen = true;
      showDialog(
          context: context,
          builder: (_) => LoadingAnimationWidget.threeArchedCircle(
              color: Theme.of(context).colorScheme.primary, size: 60));
    }
  }

  void hideLoader() {
    if (isOpen) {
      isOpen = false;

      Navigator.pop(context);
    }
  }
}
