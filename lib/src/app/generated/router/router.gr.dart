// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_installer/src/ui/views/startup/startup_view.dart';
import 'package:flutter_installer/src/ui/views/home/home_view.dart';
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart';
import 'package:flutter_installer/src/ui/views/steps/steps_base/steps_base_view.dart';

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
    StartupView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StartupView(),
        settings: data,
      );
    },
    HomeView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(),
        settings: data,
      );
    },
    FaqView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FaqView(),
        settings: data,
      );
    },
    StepsBaseView: (RouteData data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => StepsBaseView(),
        settings: data,
      );
    },
  };
}
