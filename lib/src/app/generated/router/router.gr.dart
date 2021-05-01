// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:flutter/material.dart' as _i2;
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart' as _i5;
import 'package:flutter_installer/src/ui/views/home/home_view.dart' as _i4;
import 'package:flutter_installer/src/ui/views/startup/startup_view.dart'
    as _i3;
import 'package:flutter_installer/src/ui/views/steps/steps_base/steps_base_view.dart'
    as _i6;

class AppRouter extends _i1.RootStackRouter {
  AppRouter([_i2.GlobalKey<_i2.NavigatorState> navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    StartupRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i3.StartupView());
    },
    HomeRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i4.HomeView());
    },
    FaqRoute.name: (routeData) {
      final args =
          routeData.argsAs<FaqRouteArgs>(orElse: () => const FaqRouteArgs());
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.FaqView(onBackPressed: args.onBackPressed));
    },
    StepsBaseRoute.name: (routeData) {
      return _i1.AdaptivePage<dynamic>(
          routeData: routeData, child: _i6.StepsBaseView());
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(StartupRoute.name, path: '/'),
        _i1.RouteConfig(HomeRoute.name, path: '/home'),
        _i1.RouteConfig(FaqRoute.name, path: '/faq'),
        _i1.RouteConfig(StepsBaseRoute.name, path: '/installing')
      ];
}

class StartupRoute extends _i1.PageRouteInfo {
  const StartupRoute() : super(name, path: '/');

  static const String name = 'StartupRoute';
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/home');

  static const String name = 'HomeRoute';
}

class FaqRoute extends _i1.PageRouteInfo<FaqRouteArgs> {
  FaqRoute({dynamic Function() onBackPressed})
      : super(name,
            path: '/faq', args: FaqRouteArgs(onBackPressed: onBackPressed));

  static const String name = 'FaqRoute';
}

class FaqRouteArgs {
  const FaqRouteArgs({this.onBackPressed});

  final dynamic Function() onBackPressed;
}

class StepsBaseRoute extends _i1.PageRouteInfo {
  const StepsBaseRoute() : super(name, path: '/installing');

  static const String name = 'StepsBaseRoute';
}
