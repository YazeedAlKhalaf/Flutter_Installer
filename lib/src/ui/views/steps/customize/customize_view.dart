import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './customize_view_model.dart';

class CustomizeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomizeViewModel>.reactive(
      viewModelBuilder: () => CustomizeViewModel(),
      builder: (
        BuildContext context,
        CustomizeViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'CustomizeView',
            ),
          ),
        );
      },
    );
  }
}
