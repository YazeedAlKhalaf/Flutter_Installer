import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './summary_view_model.dart';

class SummaryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SummaryViewModel>.reactive(
      viewModelBuilder: () => SummaryViewModel(),
      builder: (
        BuildContext context,
        SummaryViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'SummaryView',
            ),
          ),
        );
      },
    );
  }
}
