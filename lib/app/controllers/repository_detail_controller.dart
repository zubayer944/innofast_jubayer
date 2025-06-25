import 'package:get/get.dart';
import '../domain/entities/repository.dart';

class RepositoryDetailController extends GetxController {
  var isLoading = true.obs;
  var error = ''.obs;
  late final Repository repository;

  RepositoryDetailController() {
    repository = Get.arguments as Repository;
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
  }
}
