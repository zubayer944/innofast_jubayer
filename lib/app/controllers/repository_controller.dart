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
    repos = Get.arguments;
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
            if (repos.isEmpty) {
              repos.value = reposList;
            } else {
              repos.addAll(reposList);
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
