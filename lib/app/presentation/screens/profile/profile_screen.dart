import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/profile_controller.dart';
import '../../../domain/entities/profile.dart';
import '../../../core/utils/widgets.dart';
import '../../../domain/entities/repository.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   backgroundColor: const Color(0xFF0D1117),
      //   elevation: 0,
      // ),
      body: Obx(() {
        if (controller.isLoadingUser.value) {
          return AppWidgets.loadingIndicator();
        }

        if (controller.errorUser.isNotEmpty) {
          return AppWidgets.errorWidget(
            controller.errorUser.value,
            onRetry: controller.fetchProfile,
          );
        }

        final user = controller.user.value;
        if (user == null) {
          return AppWidgets.emptyState('No data available');
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              _buildUserInfo(user),
              const SizedBox(height: 16),
              _statsView(user),
              const SizedBox(height: 30),
              _buildRepositoriesSection()
            ],
          ),
        );
      }),
    );
  }

  Widget _buildUserInfo(Profile user) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(user.avatarUrl),
        ),
        const SizedBox(height: 12),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),

        if (user.bio?.isNotEmpty ?? false)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              user.bio!,
              style: const TextStyle(color: Colors.grey, fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ),
        if (user.location != null)
          Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_on_outlined, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  user.location!,
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildRepositoriesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repositories',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        if (controller.repos.isNotEmpty)
          _repositoryList(),
      ],
    );
  }

  Widget _statsView(Profile user) {
    return Column(
      children: [
        _buildStatsRow(
          _statBox("Followers", user.followers.toString()),
          _statBox("Following", user.following.toString()),
        ),
        const SizedBox(height: 12),
        _statBox("Public Repos", user.publicRepos.toString(), fullWidth: true),
      ],
    );
  }

  Widget _buildStatsRow(Widget leftStat, Widget rightStat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(child: leftStat),
        Expanded(child: rightStat),
      ],
    );
  }

  Widget _repositoryList() {
    return Column(
      children: [
        ...controller.repos.take(4).map(
          (repo) => _buildRepositoryItem(repo),
        ),
        if (controller.repos.length > 4)
          SizedBox(height: 10,),
          _buildSeeAllButton(),
      ],
    );
  }

  Widget _buildRepositoryItem(Repository repo) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF161B22),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.code, color: Colors.blue)),
      title: Text(
        repo.name ?? "",
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        '${repo.stargazersCount ?? 0} stars • ${repo.language ?? ""}',
        style: const TextStyle(color: Colors.white70),
      ),
      onTap: () => controller.onRepositoryItemClicked(repo),
    );
  }

  Widget _buildSeeAllButton() {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 16),
        ),
        onPressed: controller.navigateToRepositories,
        child: const Text(
          'See All Repositories',
          style: TextStyle(color: Colors.white),
        ),
      ),
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
        mainAxisSize: MainAxisSize.min,
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

