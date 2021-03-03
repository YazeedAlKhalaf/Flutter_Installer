import 'package:auto_route/auto_route_annotations.dart';
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart';
import 'package:flutter_installer/src/ui/views/installed/installed.dart';
import 'package:flutter_installer/src/ui/views/startup/startup_view.dart';
import 'package:flutter_installer/src/ui/views/home/home_view.dart';
import 'package:flutter_installer/src/ui/views/steps/steps_base/steps_base_view.dart';

@AdaptiveAutoRouter(
  routes: <AutoRoute<dynamic>>[
    AdaptiveRoute<dynamic>(page: StartupView, path: '/', initial: true),
    AdaptiveRoute<dynamic>(page: HomeView, path: '/home'),
    AdaptiveRoute<dynamic>(page: FaqView, path: '/faq'),
    AdaptiveRoute<dynamic>(page: StepsBaseView, path: '/installing'),
    AdaptiveRoute<dynamic>(page: Installed, path: '/installed'),
  ],
)
class $Router {}
