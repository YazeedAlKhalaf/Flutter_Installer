import 'package:bitsdojo_window/bitsdojo_window.dart' as bitsdojo_window;
import 'package:flutter/material.dart';

class FLWindowBorder extends StatelessWidget {
  const FLWindowBorder({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return bitsdojo_window.WindowBorder(
      color: Colors.transparent,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Material(
              color: Theme.of(context).primaryColorDark,
              child: Column(
                children: <Widget>[
                  bitsdojo_window.WindowTitleBarBox(
                    child: bitsdojo_window.MoveWindow(),
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
