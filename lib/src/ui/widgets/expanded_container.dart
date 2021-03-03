import 'package:flutter/material.dart';

class ExpandedContainer extends StatelessWidget {

  const ExpandedContainer({
    this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: child ?? Container(),
      ),
    );
  }
}
