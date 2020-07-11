import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './installing_view_model.dart';

class InstallingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InstallingViewModel>.reactive(
      viewModelBuilder: () => InstallingViewModel(),
      builder: (
        BuildContext context,
        InstallingViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'InstallingView',
            ),
          ),
        );
      },
    );
  }
}
