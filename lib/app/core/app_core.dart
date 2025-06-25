import 'package:get/get.dart';
import '../config/app_config.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'network/api_service.dart';
import 'network/network_info.dart';

class AppCore {
  static Future<void> init() async {
    // Initialize core services
    await Get.putAsync<AppConfig>(() => AppConfig().init());
    
    // Initialize network services
    final connectivity = Connectivity();
    await Get.putAsync<NetworkInfo>(() async => NetworkInfoImpl(connectivity));
    await Get.putAsync<ApiService>(() async => ApiService());
  }
}
