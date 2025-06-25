import 'package:get/get.dart';

import '../app/bindings/repository_binding.dart';
import '../app/bindings/repository_detail_binding.dart';
import '../app/presentation/screens/profile/profile_screen.dart';
import '../app/bindings/profile_binding.dart';
import '../app/presentation/screens/repository/repository_list_screen.dart';
import '../app/presentation/screens/repository_details/repository_detail_screen.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.PROFILE;

  static final routes = [
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: Routes.REPOSITORY,
      page: () => const RepositoryListScreen(),
      binding: RepositoryBinding(),
    ),

    GetPage(
      name: Routes.REPOSITORY_DETAIL,
      page: () => const RepositoryDetailScreen(),
      binding: RepositoryDetailBinding(),
    ),
  ];
}
