import 'package:authentication_with_bloc_app/app/modules/authentication/login/bloc/login_bloc.dart';
import 'package:authentication_with_bloc_app/app/modules/home/presentation/bloc/home_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../modules/authentication/login/pages/login_screen.dart';
import '../../modules/authentication/register/bloc/register_bloc.dart';
import '../../modules/authentication/register/pages/register_screen.dart';
import '../../modules/home/presentation/pages/home_screen.dart';
import 'app_routes.dart';

class AppRouter {
  static String determineInitialRoute(String? userToken) {
    if (userToken != null && userToken.isNotEmpty && userToken != 'null') {
      return '/home';
    } else {
      return '/login';
    }
  }

  static GoRouter router(String initial) {
    return GoRouter(
      initialLocation: initial,
      routes: [
        GoRoute(
          name: AppRoutes.login,
          path: '/login',
          builder: (context, state) => BlocProvider(
            create: (context) => LoginBloc(),
            child: const LoginScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.register,
          path: '/register',
          builder: (context, state) => BlocProvider(
            create: (context) => RegisterBloc(),
            child: const RegisterScreen(),
          ),
        ),
        GoRoute(
          name: AppRoutes.home,
          path: '/home',
          builder: (context, state) {
            return MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => HomeBloc(),
                ),
              ],
              child: const HomeScreen(),
            );
          },
        ),
      ],
    );
  }
}
