import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFF0D1117),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoadingUser.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.errorUser.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  controller.errorUser.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.fetchProfile(),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final user = controller.user.value;
        if (user == null) {
          return const Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(user.avatarUrl),
              ),
              const SizedBox(height: 12),

              // Name
              Text(
                user.name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              // Bio
              if (user.bio?.isNotEmpty ?? false)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    user.bio!,
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),

              const SizedBox(height: 16),

              // Stats
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: _statBox("Followers", user.followers.toString()),
                      ),
                      Expanded(
                        child: _statBox("Following", user.following.toString()),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _statBox("Public Repos", user.publicRepos.toString(), fullWidth: true),
                ],
              ),

              const SizedBox(height: 30),

              // Repositories list preview (3 items max)
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Repositories',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              if (controller.repos.isNotEmpty)
                Column(
                  children: [
                    ...controller.repos.take(4).map(
                          (repo) => ListTile(
                        leading: const Icon(Icons.folder, color: Colors.blue),
                        title: Text(
                          repo.name ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
                        subtitle: Text(
                          '${repo.stargazersCount ?? 0} stars • ${repo.language ?? ""}',
                          style: const TextStyle(color: Colors.white70),
                        ),
                        onTap: () => controller.onRepositoryItemClicked(repo),
                      ),
                    ),
                    if (controller.repos.length > 4)
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            controller.navigateToRepositories();
                          },
                          child: const Text(
                            'See All Repositories',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _statBox(String title, String value, {bool fullWidth = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      padding: const EdgeInsets.symmetric(vertical: 16),
      width: fullWidth ? double.infinity : null,
      decoration: BoxDecoration(
        color: const Color(0xFF161B22),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

