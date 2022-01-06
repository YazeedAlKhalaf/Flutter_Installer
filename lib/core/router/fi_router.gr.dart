// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

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
    },
    VerifyRoute.name: (routeData) {
      final args = routeData.argsAs<VerifyRouteArgs>();
      return AdaptivePage<dynamic>(
          routeData: routeData,
          child: VerifyScreen(
              key: args.key,
              installationPath: args.installationPath,
              isVsCodeSelected: args.isVsCodeSelected,
              isGitSelected: args.isGitSelected,
              isIntellijIdeaSelected: args.isIntellijIdeaSelected,
              isAndroidStudioSelected: args.isAndroidStudioSelected));
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(HomeRoute.name, path: '/'),
        RouteConfig(FaqRoute.name, path: '/faq'),
        RouteConfig(CustomizeRoute.name, path: '/customize'),
        RouteConfig(VerifyRoute.name, path: '/verify')
      ];
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute() : super(HomeRoute.name, path: '/');

  static const String name = 'HomeRoute';
}

/// generated route for
/// [FaqScreen]
class FaqRoute extends PageRouteInfo<void> {
  const FaqRoute() : super(FaqRoute.name, path: '/faq');

  static const String name = 'FaqRoute';
}

/// generated route for
/// [CustomizeScreen]
class CustomizeRoute extends PageRouteInfo<void> {
  const CustomizeRoute() : super(CustomizeRoute.name, path: '/customize');

  static const String name = 'CustomizeRoute';
}

/// generated route for
/// [VerifyScreen]
class VerifyRoute extends PageRouteInfo<VerifyRouteArgs> {
  VerifyRoute(
      {Key? key,
      required String installationPath,
      required bool isVsCodeSelected,
      required bool isGitSelected,
      required bool isIntellijIdeaSelected,
      required bool isAndroidStudioSelected})
      : super(VerifyRoute.name,
            path: '/verify',
            args: VerifyRouteArgs(
                key: key,
                installationPath: installationPath,
                isVsCodeSelected: isVsCodeSelected,
                isGitSelected: isGitSelected,
                isIntellijIdeaSelected: isIntellijIdeaSelected,
                isAndroidStudioSelected: isAndroidStudioSelected));

  static const String name = 'VerifyRoute';
}

class VerifyRouteArgs {
  const VerifyRouteArgs(
      {this.key,
      required this.installationPath,
      required this.isVsCodeSelected,
      required this.isGitSelected,
      required this.isIntellijIdeaSelected,
      required this.isAndroidStudioSelected});

  final Key? key;

  final String installationPath;

  final bool isVsCodeSelected;

  final bool isGitSelected;

  final bool isIntellijIdeaSelected;

  final bool isAndroidStudioSelected;

  @override
  String toString() {
    return 'VerifyRouteArgs{key: $key, installationPath: $installationPath, isVsCodeSelected: $isVsCodeSelected, isGitSelected: $isGitSelected, isIntellijIdeaSelected: $isIntellijIdeaSelected, isAndroidStudioSelected: $isAndroidStudioSelected}';
  }
}
