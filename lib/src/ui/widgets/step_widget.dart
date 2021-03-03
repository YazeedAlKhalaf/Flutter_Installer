import 'package:flutter/material.dart';
import 'package:flutter_installer/src/ui/global/app_colors.dart';
import 'package:flutter_installer/src/ui/global/ui_helpers.dart';

enum StepWidgetState {
  done,
  doing,
  notDone,
}

class StepWidget extends StatelessWidget {
  const StepWidget({
    @required this.stepName,
    @required this.stepState,
  });
  final String stepName;
  final StepWidgetState stepState;

  @override
  Widget build(BuildContext context) {
    StatelessWidget decideStepType() {
      switch (stepState) {
        case StepWidgetState.done:
          return Icon(
            Icons.done,
            size: blockSize(context) * 3,
            color: Theme.of(context).accentColor,
          );
          break;
        case StepWidgetState.doing:
          return Icon(
            Icons.fiber_manual_record,
            size: blockSize(context) * 3,
            color: Theme.of(context).accentColor,
          );
          break;
        case StepWidgetState.notDone:
        default:
          return Container();
          break;
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: blockSize(context) * 1.5,
        horizontal: blockSize(context),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: blockSize(context) * 4,
            height: blockSize(context) * 4,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                  maxRadius: blockSize(context) * 2.5,
                  minRadius: blockSize(context) * 2,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                ),
                decideStepType(),
              ],
            ),
          ),
          SizedBox(width: blockSize(context) * 3),
          Text(
            stepName,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: blockSize(context) * 2,
              fontWeight: FontWeight.bold,
              color: textColorWhite,
            ),
          ),
        ],
      ),
    );
  }
}
