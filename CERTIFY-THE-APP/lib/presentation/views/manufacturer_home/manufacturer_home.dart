// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:certify/presentation/views/manufacturer_home/components/build_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/create/create_project.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  // late final Animation<double> _animation;
  late final _projectsController;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _projectsController = ref.read(certifyProjectsController.notifier);

    // Future.delayed(Duration.zero, fetchData);
    // _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    await _projectsController.toGetAllManufacturerProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, ref, child) {
        final LoadingState loadingState =
            ref.watch(certifyProjectsController).loadingState;
        final bool isLoading = loadingState == LoadingState.loading;

        return Stack(
          children: [
            ListView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              children: [
                CertifyHeader(
                  heading: "CERTIFY",
                  headerBody: "All Your Products",
                  icon: Icons.add_business_rounded,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateNewProject(),
                      ),
                    );
                  },
                ),
                RefreshIndicator(
                  onRefresh: () async {
                    _projectsController.shouldReload = true;
                    await fetchData();
                  },
                  child: SizedBox(
                    height: 535.h,
                    child: Stack(
                      children: [
                        FutureBuilder(
                          // future: ref
                          //     .read(certifyProjectsController)
                          //     .toGetAllManufacturerProjects(),
                          
                          future: Future.delayed(Durations.medium1),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const TransparentLoadingScreen();
                            } else if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return buildGridView(ref, isLoading, _controller);
                            } else {
                              return const Center(
                                child: TransparentLoadingScreen(),
                              );
                            }
                          },
                        ),
                        if (isLoading) const TransparentLoadingScreen(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
