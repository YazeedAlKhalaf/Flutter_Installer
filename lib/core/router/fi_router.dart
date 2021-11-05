import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_installer/home/home_screen.dart';
import 'package:flutter_installer/faq/faq_screen.dart';
import 'package:flutter_installer/customize/customize_screen.dart';

part 'fi_router.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: "Screen,Route",
  routes: <AutoRoute>[
    AdaptiveRoute(
      path: "/",
      page: HomeScreen,
      initial: true,
    ),
    AdaptiveRoute(
      path: "/faq",
      page: FaqScreen,
    ),
    AdaptiveRoute(
      path: "/customize",
      page: CustomizeScreen,
    ),
  ],
)
class FIRouter extends _$FIRouter {}
