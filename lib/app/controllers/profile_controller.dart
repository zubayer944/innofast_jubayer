import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/entities/profile.dart';
import '../domain/entities/repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  Rx<Profile?> user = Rx<Profile?>(null);
  RxBool isLoadingUser = false.obs;
  var errorUser = ''.obs;
  RxList<Repository> repos = <Repository>[].obs;

  ProfileController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    isLoadingUser.value = true;
    errorUser.value = '';
    try {
      final profileResult = await repository.getProfile();
      profileResult.fold(
        (failure) {
          errorUser.value = failure.message;
          isLoadingUser.value = false;
        },
        (profile) async {
          user.value = profile;
          // Only fetch repositories if profile fetch was successful
          try {
            final reposResult = await repository.getUserRepositories('zubayer944');
            reposResult.fold(
              (failure) {
                errorUser.value = failure.message;
              },
              (reposList) {
                repos.value = reposList;
              },
            );
          } catch (e) {
            errorUser.value = 'Failed to fetch repositories: $e';
          }
          isLoadingUser.value = false;
        },
      );
    } catch (e) {
      print('Unexpected error: $e');
      errorUser.value = 'Failed to fetch data: $e';
      isLoadingUser.value = false;
    }
  }

  void navigateToRepositories() {
    Get.toNamed(Routes.REPOSITORY,arguments: repos);
  }

  void onRepositoryItemClicked(Repository repo) {
    Get.toNamed(Routes.REPOSITORY_DETAIL, arguments: repo);
  }
}
