import 'package:flutter/material.dart';

class ExpandedContainer extends StatelessWidget {
  final Widget? child;

  const ExpandedContainer({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: child ?? Container(),
      ),
    );
  }
}
