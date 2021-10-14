// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i5;
import 'package:flutter/material.dart' as _i6;
import 'package:flutter_installer/src/ui/views/faq/faq_view.dart' as _i3;
import 'package:flutter_installer/src/ui/views/home/home_view.dart' as _i2;
import 'package:flutter_installer/src/ui/views/startup/startup_view.dart'
    as _i1;
import 'package:flutter_installer/src/ui/views/steps/steps_base/steps_base_view.dart'
    as _i4;

class AppRouter extends _i5.RootStackRouter {
  AppRouter([_i6.GlobalKey<_i6.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    StartupRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i1.StartupView());
    },
    HomeRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i2.HomeView());
    },
    FaqRoute.name: (routeData) {
      final args = routeData.argsAs<FaqRouteArgs>();
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.FaqView(onBackPressed: args.onBackPressed));
    },
    StepsBaseRoute.name: (routeData) {
      return _i5.AdaptivePage<dynamic>(
          routeData: routeData, child: _i4.StepsBaseView());
    }
  };

  @override
  List<_i5.RouteConfig> get routes => [
        _i5.RouteConfig(StartupRoute.name, path: '/'),
        _i5.RouteConfig(HomeRoute.name, path: '/home'),
        _i5.RouteConfig(FaqRoute.name, path: '/faq'),
        _i5.RouteConfig(StepsBaseRoute.name, path: '/installing')
      ];
}

/// generated route for [_i1.StartupView]
class StartupRoute extends _i5.PageRouteInfo<void> {
  const StartupRoute() : super(name, path: '/');

  static const String name = 'StartupRoute';
}

/// generated route for [_i2.HomeView]
class HomeRoute extends _i5.PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/home');

  static const String name = 'HomeRoute';
}

/// generated route for [_i3.FaqView]
class FaqRoute extends _i5.PageRouteInfo<FaqRouteArgs> {
  FaqRoute({required dynamic Function()? onBackPressed})
      : super(name,
            path: '/faq', args: FaqRouteArgs(onBackPressed: onBackPressed));

  static const String name = 'FaqRoute';
}

class FaqRouteArgs {
  const FaqRouteArgs({required this.onBackPressed});

  final dynamic Function()? onBackPressed;
}

/// generated route for [_i4.StepsBaseView]
class StepsBaseRoute extends _i5.PageRouteInfo<void> {
  const StepsBaseRoute() : super(name, path: '/installing');

  static const String name = 'StepsBaseRoute';
}
