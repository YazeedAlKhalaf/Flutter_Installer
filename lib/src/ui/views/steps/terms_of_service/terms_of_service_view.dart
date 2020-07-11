import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import './terms_of_service_view_model.dart';

class TermsOfServiceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TermsOfServiceViewModel>.reactive(
      viewModelBuilder: () => TermsOfServiceViewModel(),
      builder: (
        BuildContext context,
        TermsOfServiceViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: Center(
            child: Text(
              'TermsOfServiceView',
            ),
          ),
        );
      },
    );
  }
}
