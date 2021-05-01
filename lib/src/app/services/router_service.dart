import 'package:injectable/injectable.dart';

import 'package:flutter_installer/src/app/generated/router/router.dart';

@lazySingleton
class RouterService {
  final AppRouter router = AppRouter();
}
