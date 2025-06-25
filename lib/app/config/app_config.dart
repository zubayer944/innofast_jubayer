import 'package:get/get.dart';

class AppConfig extends GetxService {
  static AppConfig get to => Get.find<AppConfig>();
  
  // Configuration variables
  final String appName = 'Jubayer Innofast';
  final String version = '1.0.0';
  final String baseUrl = 'https://api.github.com/';
  final int connectTimeout = 30000; // 30 seconds
  final int receiveTimeout = 30000; // 30 seconds
  
  Future<AppConfig> init() async {
    // Initialize any configuration here
    return this;
  }
}
