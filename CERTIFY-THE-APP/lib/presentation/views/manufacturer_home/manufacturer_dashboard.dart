import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:certify/presentation/views/home/home.dart';
import 'package:certify/presentation/views/manufacturer_home/components/nav_bar_item.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_home.dart';
import 'package:certify/presentation/views/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ManufacturerHome extends HookConsumerWidget {
  const ManufacturerHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final GlobalKey<NavigatorState> homeKey = GlobalKey<NavigatorState>();
    // final GlobalKey<NavigatorState> certifyKey = GlobalKey<NavigatorState>();
    // final GlobalKey<NavigatorState> profileKey = GlobalKey<NavigatorState>();
    debugPrint('Consumer Home rebuilt: ${DateTime.now()}');
    List<String> listOfString = [
      "Home",
      "All Products",
      "Profile",
    ];

    final List<Widget> tabs = [
      const Home(),
      const CertifiedHome(),
      const Profile(),
    ];

    final dashboardController = ref.watch(dashBoardControllerProvider);
    final selectedPageIndex = dashboardController.myPage;
    return Scaffold(
      body: tabs[selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: (value) {
          dashboardController.switchPage(value);
          HapticFeedback.lightImpact();
        },
        items: <BottomNavigationBarItem>[
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Home',
            label: listOfString[0],
            index: 0,
          ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Order-History',
            label: listOfString[1],
            index: 1,
          ),
          buildBottomNavigationBarItem(
            ref,
            context,
            iconPath: 'Profile',
            label: listOfString[2],
            index: 2,
          ),
        ],
      ),
    );
  }
}
