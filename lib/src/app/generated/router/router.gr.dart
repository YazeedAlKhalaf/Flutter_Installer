// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/views/faq/faq_view.dart';
import '../../../ui/views/home/home_view.dart';
import '../../../ui/views/installed/installed.dart';
import '../../../ui/views/startup/startup_view.dart';
import '../../../ui/views/steps/steps_base/steps_base_view.dart';

class Routes {
  static const String startupView = '/';
  static const String homeView = '/home';
  static const String faqView = '/faq';
  static const String stepsBaseView = '/installing';
  static const String installed = '/installed';
  static const Set<String> all = <String>{
    startupView,
    homeView,
    faqView,
    stepsBaseView,
    installed,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final List<RouteDef> _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.faqView, page: FaqView),
    RouteDef(Routes.stepsBaseView, page: StepsBaseView),
    RouteDef(Routes.installed, page: Installed),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final Map<Type, AutoRouteFactory> _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (BuildContext context) => StartupView(),
        settings: data,
      );
    },
    HomeView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (BuildContext context) => HomeView(),
        settings: data,
      );
    },
    FaqView: (RouteData data) {
      final FaqViewArguments args =
          data.getArgs<FaqViewArguments>(nullOk: false);
      return buildAdaptivePageRoute<dynamic>(
        builder: (BuildContext context) =>
            FaqView(onBackPressed: args.onBackPressed),
        settings: data,
      );
    },
    StepsBaseView: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (BuildContext context) => StepsBaseView(),
        settings: data,
      );
    },
    Installed: (RouteData data) {
      return buildAdaptivePageRoute<dynamic>(
        builder: (BuildContext context) => Installed(),
        settings: data,
      );
    }
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// FaqView arguments holder class
class FaqViewArguments {
  FaqViewArguments({@required this.onBackPressed});
  final dynamic Function() onBackPressed;
}
