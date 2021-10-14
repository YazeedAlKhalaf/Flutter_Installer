// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:stacked_services/stacked_services.dart' as _i4;

import '../../services/api/api_service.dart' as _i3;
import '../../services/local_storage_service.dart' as _i5;
import '../../services/router_service.dart' as _i6;
import '../../services/shared_prefs/shared_prefs_service.dart' as _i7;
import '../../services/third_party_services_module.dart' as _i10;
import '../../services/window_size_service.dart' as _i9;
import '../../utils/utils.dart' as _i8; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final thirdPartyServicesModule = _$ThirdPartyServicesModule();
  gh.lazySingleton<_i3.ApiService>(() => _i3.ApiService());
  gh.lazySingleton<_i4.DialogService>(
      () => thirdPartyServicesModule.dialogService);
  gh.lazySingleton<_i5.LocalStorageService>(() => _i5.LocalStorageService());
  gh.lazySingleton<_i4.NavigationService>(
      () => thirdPartyServicesModule.navigationService);
  gh.lazySingleton<_i6.RouterService>(() => _i6.RouterService());
  gh.lazySingleton<_i7.SharedPrefsService>(() => _i7.SharedPrefsService());
  gh.lazySingleton<_i4.SnackbarService>(
      () => thirdPartyServicesModule.snackBarService);
  gh.lazySingleton<_i8.Utils>(() => _i8.Utils());
  gh.factory<_i9.WindowSizeService>(() => _i9.WindowSizeService());
  return get;
}

class _$ThirdPartyServicesModule extends _i10.ThirdPartyServicesModule {
  @override
  _i4.DialogService get dialogService => _i4.DialogService();
  @override
  _i4.NavigationService get navigationService => _i4.NavigationService();
  @override
  _i4.SnackbarService get snackBarService => _i4.SnackbarService();
}
