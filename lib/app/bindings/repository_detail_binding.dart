import 'package:get/get.dart';
import '../controllers/repository_detail_controller.dart';

class RepositoryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RepositoryDetailController>(() =>
        RepositoryDetailController());
  }
}
