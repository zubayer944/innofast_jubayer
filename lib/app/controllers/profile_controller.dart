import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../domain/repositories/profile_repository.dart';
import '../domain/entities/profile.dart';
import '../domain/entities/repository.dart';

class ProfileController extends GetxController {
  final ProfileRepository repository;
  var user = Rx<Profile?>(null);
  var isLoadingUser = false.obs;
  var errorUser = ''.obs;
  var repos = <Repository>[].obs;

  ProfileController({required this.repository});

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  Future<void> fetchProfile() async {
    print('Starting profile fetch');
    isLoadingUser.value = true;
    errorUser.value = '';
    try {
      print('Fetching profile data...');
      final profileResult = await repository.getProfile();
      profileResult.fold(
        (failure) {
          print('Profile fetch failed: ${failure.message}');
          errorUser.value = failure.message;
          isLoadingUser.value = false;
        },
        (profile) async {
          print('Profile fetch successful');
          user.value = profile;
          print('Fetching repositories...');
          // Only fetch repositories if profile fetch was successful
          try {
            final reposResult = await repository.getUserRepositories('zubayer944');
            reposResult.fold(
              (failure) {
                print('Repositories fetch failed: ${failure.message}');
                errorUser.value = failure.message;
              },
              (reposList) {
                print('Repositories fetch successful, count: ${reposList.length}');
                repos.value = reposList;
              },
            );
          } catch (e) {
            print('Error fetching repositories: $e');
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
