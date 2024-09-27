import 'package:certify/core/theme/text_theme_manager.dart';
import 'package:certify/data/controllers/certify_dashboard_controller.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/splash.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_dashboard.dart';
import 'package:certify/presentation/views/shared_auth/auth_navigation.dart';
import 'package:certify/utils/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(
    ProviderScope(
      child: OKToast(
        child: MaterialApp(
          title: 'Certify',
          themeMode: ThemeMode.system,
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          home: const CertifySplash(),
        ),
      ),
    ),
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  late Future<String> getEmailFuture;
  late final DashBoardController screenController =
      ref.read(dashBoardControllerProvider);

  // This widget is the root of your application.
  @override
  void initState() {
    getEmailFuture = screenController.getEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: "Certify",
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.system,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromRGBO(103, 58, 183, 1)),
            useMaterial3: true,
            textTheme: certifyTheme,
          ),
          home: Stack(
            children: [
              FutureBuilder<String?>(
                future: screenController.getEmail(),
                builder: ((context, snapshot) {
                  String? email = snapshot.data;
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (email == null || email == "") {
                      return const CertifyAuthNavigator();
                    } else {
                      return const ManufacturerHome();
                    }
                  } else {
                    return const TransparentLoadingScreen();
                  }
                }),
              )
            ],
          ),
        );
      },
    );
  }
}
