import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/app_core.dart';
import 'app/presentation/app_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await AppCore.init();
  
  runApp(const AppView());
}
