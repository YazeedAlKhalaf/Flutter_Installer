import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './done_view_model.dart';

class DoneView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DoneViewModel>.reactive(
      viewModelBuilder: () => DoneViewModel(),
      builder: (
        BuildContext context,
        DoneViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'DoneView',
            ),
          ),
        );
      },
    );
  }
}
