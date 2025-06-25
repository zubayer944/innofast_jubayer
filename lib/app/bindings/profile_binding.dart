import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../core/network/api_service.dart';
import '../core/network/network_info.dart';
import '../data/repositories/profile_repository_impl.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    final networkInfo = Get.find<NetworkInfo>();
    final repository = ProfileRepositoryImpl(
      apiService: Get.find<ApiService>(),
      networkInfo: networkInfo,
    );
    
    Get.put(repository);
    Get.lazyPut<ProfileController>(() => ProfileController(
      repository: repository,
    ));
  }
}
