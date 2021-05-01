import 'package:auto_route/annotations.dart';
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart';
import 'package:flutter_installer/src/ui/views/startup/startup_view.dart';
import 'package:flutter_installer/src/ui/views/home/home_view.dart';
import 'package:flutter_installer/src/ui/views/steps/steps_base/steps_base_view.dart';

export 'router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "View,Route",
  routes: <AutoRoute>[
    AdaptiveRoute(page: StartupView, path: '/', initial: true),
    AdaptiveRoute(page: HomeView, path: '/home'),
    AdaptiveRoute(page: FaqView, path: '/faq'),
    AdaptiveRoute(page: StepsBaseView, path: '/installing'),
  ],
)
class $AppRouter {}
