import 'package:flutter_installer/src/app/generated/router/router.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class RouterService {
  final AppRouter router = AppRouter();
}
