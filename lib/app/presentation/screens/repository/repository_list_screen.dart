import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/repository_controller.dart';

class RepositoryListScreen extends GetView<RepositoryController> {
  const RepositoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Repositories',
        style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black38,
      ),
      body: Obx(() {
        if (controller.isLoading.value && controller.repos.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.error.value.isNotEmpty) {
          return Center(
            child: Text(
              controller.error.value,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (controller.repos.isEmpty) {
          return const Center(child: Text('No repositories found'));
        }

        return RefreshIndicator(
          onRefresh: () async => controller.refresh(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.repos.length + 1,
            controller: controller.scrollController,
            itemBuilder: (context, index) {
              if (index == controller.repos.length) {
                if (controller.isFetchingMore.value) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                return const SizedBox.shrink();
              }

              final repo = controller.repos[index];
              return Card(
                color: Colors.grey[800],
                child: ListTile(
                  leading: const Icon(Icons.folder, color: Colors.blue),
                  title: Text(
                    repo.name ?? "",
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        repo.description ?? "",
                        style: const TextStyle(color: Colors.white70),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${repo.stargazersCount} stars • ${repo.language} • ${repo.forks} forks',
                        style: const TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                  onTap: () => controller.onSelectRepoClicked(index),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}

