import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../domain/repositories/repository_repository.dart';
import '../domain/entities/repository.dart';

class RepositoryController extends GetxController {
  final RepositoryRepository repository;
  var isLoading = true.obs;
  var error = ''.obs;
  var repos = <Repository>[].obs;
  var hasMore = true.obs;
  var currentPage = 1.obs;
  var perPage = 10.obs;
  var isFetchingMore = false.obs;
  final ScrollController scrollController = ScrollController();

  RepositoryController({required this.repository}) {
    scrollController.addListener(_onScroll);
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with arguments if available
    final initialRepos = Get.arguments as List<Repository>?;
    if (initialRepos != null && initialRepos.isNotEmpty) {
      repos.value = initialRepos;
      currentPage.value = (repos.length / perPage.value).ceil();
    }
    
    // Load more data if needed
    if (repos.isEmpty) {
      fetchRepositories();
    }
  }

  @override
  void onClose() {
    scrollController.removeListener(_onScroll);
    scrollController.dispose();
    super.onClose();
  }

  void _onScroll() {
    if (_shouldLoadMore()) {
      loadMore();
    }
  }

  bool _shouldLoadMore() {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;
    return currentScroll >= maxScroll * 0.8;
  }

  Future<void> fetchRepositories() async {
    isLoading.value = true;
    error.value = '';
    try {
      final result = await repository.getUserRepositories(
        'zubayer944',
        page: currentPage.value,
        perPage: perPage.value,
      );
      result.fold(
        (failure) => error.value = failure.message,
        (reposList) {
          if (reposList.isEmpty) {
            hasMore.value = false;
          } else {
            // Remove duplicates by checking if repository already exists
            final newRepos = reposList.where((newRepo) => 
              !repos.any((existingRepo) => existingRepo.id == newRepo.id)
            ).toList();
            
            if (repos.isEmpty) {
              repos.value = newRepos;
            } else {
              repos.addAll(newRepos);
            }
            currentPage.value++;
          }
        },
      );
    } catch (e) {
      error.value = 'Failed to fetch repositories';
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isFetchingMore.value || !hasMore.value) return;
    isFetchingMore.value = true;
    await fetchRepositories();
  }

  @override
  Future<void> refresh() async {
    currentPage.value = 1;
    hasMore.value = true;
    repos.clear();
    isLoading.value = true;
    await fetchRepositories();
  }

  void onSelectRepoClicked(int index) {
    Get.toNamed('/repository-detail', arguments: repos[index]);
  }
}
