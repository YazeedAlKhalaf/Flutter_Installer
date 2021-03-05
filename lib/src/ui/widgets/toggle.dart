import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

//----------Toggle Widget----------//

class LiteRollingSwitch extends StatefulWidget {
  const LiteRollingSwitch(
      {this.value = true,
      this.textSize = 14.0,
      this.iconOn = '🌞',
      this.iconOff = '🌝',
      this.animationDuration = const Duration(milliseconds: 300),
      this.onTap,
      this.onDoubleTap,
      this.onSwipe,
      this.onChanged});
  @required
  final bool value;
  @required
  final Function(bool) onChanged;
  final double textSize;
  final Duration animationDuration;
  final String iconOn;
  final String iconOff;
  final Function onTap;
  final Function onDoubleTap;
  final Function onSwipe;

  @override
  _RollingSwitchState createState() => _RollingSwitchState();
}

class _RollingSwitchState extends State<LiteRollingSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  double value = 0.0;

  bool turnState;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: widget.animationDuration);
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeInOut);
    animationController.addListener(() {
      setState(() {
        value = animation.value;
      });
    });
    turnState = widget.value;
    turnState ? animationController.forward() : animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        _action();
        if (widget.onDoubleTap != null) {
          widget.onDoubleTap();
        }
      },
      onTap: () {
        _action();
        if (widget.onTap != null) widget.onTap();
      },
      onPanEnd: (DragEndDetails details) {
        _action();
        if (widget.onSwipe != null) widget.onSwipe();
      },
      child: Container(
        padding: const EdgeInsets.all(5),
        width: 50,
        child: Stack(
          children: <Widget>[
            Transform.translate(
              offset: const Offset(0, 0), //original
              child: Opacity(
                opacity: (1 - value).clamp(0.0, 1.0).toDouble(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerRight,
                  height: 40,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 0), //original
              child: Opacity(
                opacity: value.clamp(0.0, 1.0).toDouble(),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  alignment: Alignment.centerLeft,
                  height: 40,
                ),
              ),
            ),
            Transform.translate(
              offset: const Offset(0, 0),
              child: Transform.rotate(
                angle: lerpDouble(0, 0 * pi, value),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    // color: turnState ? Colors.black : Colors.white
                  ),
                  child: Stack(
                    children: <Widget>[
                      Center(
                        child: Opacity(
                          opacity: (1 - value).clamp(0.0, 1.0).toDouble(),
                          child: Text(
                            widget.iconOff,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: Opacity(
                          opacity: value.clamp(0.0, 1.0).toDouble(),
                          child: Text(
                            widget.iconOn,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _action() {
    _determine(changeState: true);
  }

  void _determine({bool changeState = false}) {
    setState(() {
      if (changeState) turnState = !turnState;
      turnState ? animationController.forward() : animationController.reverse();
    });
    widget.onChanged(turnState);
  }
}
