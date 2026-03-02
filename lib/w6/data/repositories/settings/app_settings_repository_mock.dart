import 'package:mobile_dev_w4/w6/data/repositories/settings/app_settings_repository.dart';
import 'package:mobile_dev_w4/w6/model/settings/app_settings.dart';

class AppSettingsRepositoryMock implements AppSettingsRepository {
  AppSettings currentSetting = AppSettings(themeColor: ThemeColor.blue);
  
  @override
  Future<AppSettings> load() async {
    return currentSetting;
  }

  @override
  Future<void> save(AppSettings? settings) async {
    currentSetting.copyWith(themeColor: settings!.themeColor);
  }
}
