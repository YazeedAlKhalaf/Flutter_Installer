import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './steps_base_view_model.dart';

class StepsBaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StepsBaseViewModel>.reactive(
      viewModelBuilder: () => StepsBaseViewModel(),
      builder: (
        BuildContext context,
        StepsBaseViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'StepsBaseView',
            ),
          ),
        );
      },
    );
  }
}
