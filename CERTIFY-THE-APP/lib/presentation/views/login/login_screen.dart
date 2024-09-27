import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:certify/core/constants/constants.dart';
import 'package:certify/data/controllers/certify_login_controller.dart';
import 'package:certify/data/local/local.dart';
import 'package:certify/presentation/general_components/auth_component_1.dart';
import 'package:certify/presentation/general_components/auth_component_2.dart';
import 'package:certify/presentation/general_components/certify_behaviour.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_dashboard.dart';
import 'package:certify/presentation/views/signup/signup.dart';
import 'package:certify/utils/locator.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends ConsumerState<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    emailController = TextEditingController();
    passwordController = TextEditingController();

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: ScrollConfiguration(
        behavior: CertifyBehavior(),
        child: Consumer(
          builder: (context, ref, child) {
            final logIn = ref.read(certifyLoginController);
            final LoadingState loadingState = logIn.loadingState;
            final bool isLoading = loadingState == LoadingState.loading;
            return SingleChildScrollView(
              child: Stack(
                children: [
                  SizedBox(
                    height: size.height,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Theme.of(context).colorScheme.surface,
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Opacity(
                        opacity: _opacity.value,
                        child: Transform.scale(
                          scale: _transform.value,
                          child: Container(
                            width: size.width * .9,
                            height: size.width * 1.1,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.surface,
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(.1),
                                  blurRadius: 90,
                                ),
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(),
                                Text(
                                  'Sign In',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.7),
                                    fontFamily: "Montesserat",
                                  ),
                                ),
                                const SizedBox(),
                                // component1(Icons.account_circle_outlined,
                                //     'User name...', false, false),
                                component1(
                                  Icons.email_outlined,
                                  'Email...',
                                  false,
                                  true,
                                  context,
                                  emailController,
                                ),
                                component1(
                                  Icons.lock_outline,
                                  'Password...',
                                  true,
                                  false,
                                  context,
                                  passwordController,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    component2(
                                      'LOGIN',
                                      2.6,
                                      () {
                                        setState(() {});
                                        HapticFeedback.lightImpact();
                                        logIn
                                            .signIn(
                                          emailController.text,
                                          passwordController.text,
                                        )
                                            .then((value) {
                                          if (value) {
                                            locator<ToastService>()
                                                .showSuccessToast(
                                              'You\'re Logged In Successfuly! 😁',
                                            );
                                            Navigator.of(context)
                                                .pushReplacement(
                                              MaterialPageRoute(
                                                builder: ((context) {
                                                  return const ManufacturerHome();
                                                }),
                                              ),
                                            );
                                          } else {
                                            setState(() {});
                                          }
                                        });
                                      },
                                      context,
                                    ),
                                    SizedBox(width: size.width / 25),
                                    Container(
                                      width: size.width / 2.6,
                                      alignment: Alignment.center,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Forgotten password?',
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            fontFamily: 'Montesserat',
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              ToastService().showSuccessToast(
                                                'We are working on this feature',
                                              );
                                              // Fluttertoast.showToast(
                                              //   msg:
                                              //       'Forgotten password! button pressed',
                                              // );
                                            },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                const SizedBox(),
                                RichText(
                                  text: TextSpan(
                                    text: 'New here? Get Certified!',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 13.sp,
                                      fontFamily: 'Montesserat',
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Fluttertoast.showToast(
                                        //   msg: 'Create a new Account button pressed',
                                        // );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const SignupScreen();
                                            },
                                          ),
                                        );
                                      },
                                  ),
                                ),
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (isLoading) const TransparentLoadingScreen(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
