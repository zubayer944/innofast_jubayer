import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/repository_detail_controller.dart';

class RepositoryDetailScreen extends GetView<RepositoryDetailController> {
  const RepositoryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text('Repository Detail'),
        backgroundColor: Colors.black38,
        foregroundColor: Colors.white,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
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
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.repository.name ?? "",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                controller.repository.description ?? "",
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
              const SizedBox(height: 24),

              // Info Card
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: const Color(0xFF161B22),
                  border: Border.all(color: const Color(0xFF2A2F3A)),
                ),
                padding: const EdgeInsets.all(16),
                child: Wrap(
                  spacing: 56,
                  runSpacing: 16,
                  children: [
                    _buildInfoTile(
                      Icons.star,
                      '${controller.repository.stargazersCount}',
                      'Stars',
                    ),
                    _buildInfoTile(
                      Icons.call_split,
                      '${controller.repository.forks}',
                      'Forks',
                    ),
                    _buildInfoTile(
                      Icons.error_outline,
                      '${controller.repository.openIssues}',
                      'Open issues',
                    ),
                    // _buildInfoTile(Icons.label, controller.repository.language ?? "", 'Language'), repo.visibility),
                    _buildInfoTile(Icons.code, controller.repository.language ?? "None", 'Language'),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoTile(IconData icon, String value, String label) {
    return SizedBox(
      width: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 25),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

}
