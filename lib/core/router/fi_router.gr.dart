// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

part of 'fi_router.dart';

class _$FIRouter extends RootStackRouter {
  _$FIRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const HomeScreen());
    },
    FaqRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const FaqScreen());
    },
    CustomizeRoute.name: (routeData) {
      return AdaptivePage<dynamic>(
          routeData: routeData, child: const CustomizeScreen());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/'),
        RouteConfig(FaqRoute.name, path: '/faq'),
        RouteConfig(CustomizeRoute.name, path: '/customize')
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

/// generated route for [CustomizeScreen]
class CustomizeRoute extends PageRouteInfo<void> {
  const CustomizeRoute() : super(name, path: '/customize');

  static const String name = 'CustomizeRoute';
}
