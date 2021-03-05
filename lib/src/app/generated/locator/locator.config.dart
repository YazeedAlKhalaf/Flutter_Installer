// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:flutter_installer/src/app/services/api/api_service.dart';
import 'package:flutter_installer/src/app/services/local_storage_service.dart';
import 'package:flutter_installer/src/app/services/shared_prefs/shared_prefs_service.dart';
import 'package:flutter_installer/src/app/services/third_party_services_module.dart';
import 'package:flutter_installer/src/app/utils/utils.dart';
import 'package:flutter_installer/src/app/services/window_size_service.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final GetItHelper gh = GetItHelper(get, environment, environmentFilter);
  final _$ThirdPartyServicesModule thirdPartyServicesModule =
      _$ThirdPartyServicesModule();
  gh.lazySingleton<ApiService>(() => ApiService());
  gh.lazySingleton<DialogService>(() => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<LocalStorageService>(() => LocalStorageService());
  gh.lazySingleton<NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<SharedPrefsService>(() => SharedPrefsService());
  gh.lazySingleton<SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  gh.lazySingleton<Utils>(() => Utils());
  gh.factory<WindowSizeService>(() => WindowSizeService());
  return get;
}

class _$ThirdPartyServicesModule extends ThirdPartyServicesModule {
  @override
  DialogService get dialogService => DialogService();
  @override
  NavigationService get navigationService => NavigationService();
  @override
  SnackbarService get snackBarService => SnackbarService();
}
