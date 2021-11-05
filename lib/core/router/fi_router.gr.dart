// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'fi_router.dart';

class _$_FIRouter extends RootStackRouter {
  _$_FIRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const HomeScreen());
    },
    FaqRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const FaqScreen());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/'),
        RouteConfig(FaqRoute.name, path: '/faq')
      ];
}

/// generated route for [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for [FaqScreen]
class FaqRoute extends PageRouteInfo<void> {
  const FaqRoute() : super(name, path: '/faq');

  static const String name = 'FaqRoute';
}
