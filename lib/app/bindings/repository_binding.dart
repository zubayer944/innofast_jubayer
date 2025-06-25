import 'package:get/get.dart';
import '../controllers/repository_controller.dart';
import '../core/network/api_service.dart';
import '../core/network/network_info.dart';
import '../data/repositories/repository_repository_impl.dart';

class RepositoryBinding extends Bindings {
  @override
  void dependencies() {
    final networkInfo = Get.find<NetworkInfo>();
    final apiService = Get.find<ApiService>();
    
    final repository = RepositoryRepositoryImpl(
      apiService: apiService,
      networkInfo: networkInfo,
    );
    
    Get.lazyPut<RepositoryController>(() => RepositoryController(
      repository: repository,
    ));
  }
}
