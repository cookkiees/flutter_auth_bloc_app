import 'package:authentication_with_bloc_app/app/config/routers/app_routes.dart';
import 'package:authentication_with_bloc_app/app/data/local_storage.dart';
import 'package:authentication_with_bloc_app/app/modules/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUserId();
  }

  void getUserId() async {
    final userId = await LocalStorage.getUserId();

    if (userId != 0) {
      if (mounted) {
        BlocProvider.of<HomeBloc>(context).add(
          HomeUserInitialEvent(userId: userId.toString()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return AppBar(
                centerTitle: false,
                backgroundColor: Colors.white,
                leading: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 32.0,
                    ),
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        height: 10,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (state is HomeSuccess) {
              return AppBar(
                backgroundColor: Colors.white,
                surfaceTintColor: Colors.white,
                centerTitle: false,
                leading: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.black,
                      backgroundImage:
                          NetworkImage("${state.user?.profilepicture}"),
                    ),
                  ),
                ),
                title: InkWell(
                  onTap: () {},
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi ${state.user?.name}',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${state.user?.location}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          const Icon(
                            Icons.keyboard_arrow_down,
                            size: 18,
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                actions: [
                  const SizedBox(width: 12),
                  Flexible(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () async {
                        await LocalStorage.removeStringToken();
                        await LocalStorage.removeUserId();
                        if (mounted) {
                          context.pushReplacementNamed(AppRoutes.login);
                        }
                      },
                      child: const Icon(
                        Icons.logout,
                        size: 18.0,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
              );
            } else {
              return Text(state.error.toString());
            }
          },
        ),
      ),
      body: const SizedBox.shrink(),
    );
  }
}
