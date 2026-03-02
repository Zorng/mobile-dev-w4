import 'package:flutter/widgets.dart';
import 'package:mobile_dev_w4/w6/data/repositories/settings/app_settings_repository.dart';

import '../../model/settings/app_settings.dart';

class AppSettingsState extends ChangeNotifier {
  AppSettingsRepository repository;
  AppSettings? _appSettings;

  AppSettingsState({required this.repository});

  Future<void> init() async {
    _appSettings = await repository.load();
  }

  ThemeColor get theme => _appSettings?.themeColor ?? ThemeColor.blue;

  Future<void> changeTheme(ThemeColor themeColor) async {
    if (_appSettings == null) return;
    _appSettings = _appSettings!.copyWith(themeColor: themeColor);
    repository.save(_appSettings!);

    notifyListeners();
  }
}
