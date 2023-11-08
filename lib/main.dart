import 'package:authentication_with_bloc_app/app/config/routers/app_router.dart';
import 'package:authentication_with_bloc_app/app/data/local_storage.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await LocalStorage.removeUserId();
  // await LocalStorage.removeStringToken();
  final token = await LocalStorage.getStringToken();
  runApp(MyApp(initialRoute: AppRouter.determineInitialRoute(token)));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Authentication Bloc Pattern',
      routerConfig: AppRouter.router(initialRoute),
    );
  }
}
