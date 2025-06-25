import 'package:get/get.dart';
import '../domain/entities/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class RepositoryDetailController extends GetxController {
  RxBool isLoading = true.obs;
  RxString error = ''.obs;
  late final Repository repository;

  RepositoryDetailController() {
    repository = Get.arguments as Repository;
  }

  @override
  void onInit() {
    super.onInit();
    isLoading.value = false;
  }

  Future<void> openRepositoryInBrowser() async {
    if (repository.htmlUrl == null) return;
    try {
      await launchUrl(Uri.parse(repository.htmlUrl!), mode: LaunchMode.externalApplication);
    } catch (e) {
      // Handle any errors silently as they might not be critical
    }
  }
}
