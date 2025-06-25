import 'package:equatable/equatable.dart';

class RepositoryDetail extends Equatable {
  final String name;
  final String description;
  final String language;
  final int stars;
  final int forks;
  final String ownerAvatar;
  final String ownerName;
  final String ownerUrl;
  final String createdAt;
  final String updatedAt;
  final String license;
  final String defaultBranch;
  final int watchers;
  final int openIssues;
  final bool isFork;
  final String htmlUrl;

  const RepositoryDetail({
    required this.name,
    required this.description,
    required this.language,
    required this.stars,
    required this.forks,
    required this.ownerAvatar,
    required this.ownerName,
    required this.ownerUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.license,
    required this.defaultBranch,
    required this.watchers,
    required this.openIssues,
    required this.isFork,
    required this.htmlUrl,
  });

  factory RepositoryDetail.fromJson(Map<String, dynamic> json) {
    return RepositoryDetail(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      language: json['language'] ?? '',
      stars: json['stargazers_count'] ?? 0,
      forks: json['forks_count'] ?? 0,
      ownerAvatar: json['owner']['avatar_url'] ?? '',
      ownerName: json['owner']['login'] ?? '',
      ownerUrl: json['owner']['html_url'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      license: json['license']?['name'] ?? '',
      defaultBranch: json['default_branch'] ?? '',
      watchers: json['watchers_count'] ?? 0,
      openIssues: json['open_issues_count'] ?? 0,
      isFork: json['fork'] ?? false,
      htmlUrl: json['html_url'] ?? '',
    );
  }

  @override
  List<Object?> get props => [
        name,
        description,
        language,
        stars,
        forks,
        ownerAvatar,
        ownerName,
        ownerUrl,
        createdAt,
        updatedAt,
        license,
        defaultBranch,
        watchers,
        openIssues,
        isFork,
        htmlUrl,
      ];
}
