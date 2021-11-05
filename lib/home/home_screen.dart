import 'package:flutter/material.dart';
import 'package:flutter_installer/core/fl_constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Opacity(
              opacity: 0.15,
              child: Image.asset(
                'assets/images/logo_flutter_1080px_clr.png',
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              Image.asset(
                'assets/images/flutter_installer_logo.png',
                width: 100,
              ),
              Text(
                "Flutter Installer",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: FLConstants.unit),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(FLConstants.unit),
                ),
                onPressed: () {
                  // TODO(yazeedalkhalaf): navigate to customization screen.
                },
                child: Text(
                  "Get Started",
                  style: Theme.of(context).textTheme.headline5?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const Spacer(),
              Text(
                "Made using Flutter 💙",
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              Text(
                "Flutter and the related logo are trademarks of Google LLC.\nWe are not endorsed by or affiliated with Google LLC.",
                style: Theme.of(context).textTheme.subtitle2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: FLConstants.unit),
            ],
          ),
        ],
      ),
    );
  }
}
