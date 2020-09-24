// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../ui/views/faq/faq_view.dart';
import '../../../ui/views/home/home_view.dart';
import '../../../ui/views/startup/startup_view.dart';
import '../../../ui/views/steps/steps_base/steps_base_view.dart';

class Routes {
  static const String startupView = '/';
  static const String homeView = '/home-view';
  static const String faqView = '/faq-view';
  static const String stepsBaseView = '/steps-base-view';
  static const all = <String>{
    startupView,
    homeView,
    faqView,
    stepsBaseView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.startupView, page: StartupView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.faqView, page: FaqView),
    RouteDef(Routes.stepsBaseView, page: StepsBaseView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    StartupView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    HomeView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    FaqView: (data) {
      final args = data.getArgs<FaqViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => FaqView(onBackPressed: args.onBackPressed),
        settings: data,
      );
    },
    StepsBaseView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StepsBaseView(),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// FaqView arguments holder class
class FaqViewArguments {
  final dynamic Function() onBackPressed;
  FaqViewArguments({@required this.onBackPressed});
}
