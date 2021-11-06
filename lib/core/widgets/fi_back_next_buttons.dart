import 'package:flutter/material.dart';

class FIBackNextButtons extends StatelessWidget {
  const FIBackNextButtons({
    Key? key,
    required this.onBackPressed,
    required this.onNextPressed,
  }) : super(key: key);

  final void Function()? onBackPressed;
  final void Function()? onNextPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ElevatedButton.icon(
          onPressed: onBackPressed,
          icon: const Icon(Icons.arrow_left_rounded),
          label: Text(
            "Back",
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        ElevatedButton.icon(
          onPressed: onNextPressed,
          label: const Icon(Icons.arrow_right_rounded),
          icon: Text(
            "Next",
            style: Theme.of(context).textTheme.button?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
      ],
    );
  }
}
