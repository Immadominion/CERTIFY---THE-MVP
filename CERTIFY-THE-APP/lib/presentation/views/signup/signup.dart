import 'package:certify/core/constants/enum.dart';
import 'package:certify/data/controllers/certify_sign_up_controller.dart';
import 'package:certify/data/local/local.dart';
import 'package:certify/presentation/general_components/auth_component_1.dart';
import 'package:certify/presentation/general_components/auth_component_2.dart';
import 'package:certify/presentation/general_components/certify_behaviour.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/login/login_screen.dart';
import 'package:certify/presentation/views/manufacturer_home/manufacturer_dashboard.dart';
import 'package:certify/utils/locator.dart';
import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  SignupScreenState createState() => SignupScreenState();
}

class SignupScreenState extends ConsumerState<SignupScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    nameController = TextEditingController();
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
            final signUp = ref.read(certifySignUpController);
            final LoadingState loadingState = signUp.loadingState;
            final bool isLoading = loadingState == LoadingState.loading;
            return Stack(
              children: [
                SingleChildScrollView(
                  child: SizedBox(
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
                                  'Sign Up',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontFamily: "Montesserat",
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                ),
                                const SizedBox(),
                                component1(
                                  Icons.account_circle_outlined,
                                  'User name...',
                                  false,
                                  false,
                                  context,
                                  nameController,
                                ),
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
                                      'SIGN UP',
                                      2.6,
                                      () {
                                        setState(() {});
                                        HapticFeedback.lightImpact();
                                        signUp
                                            .signUp(
                                          nameController.text,
                                          emailController.text,
                                          passwordController.text,
                                        )
                                            .then((value) {
                                          setState(() {});
                                          if (value) {
                                            locator<ToastService>()
                                                .showSuccessToast(
                                              'You\'re Certified! 😁',
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
                                    // Container(
                                    //   width: size.width / 2.6,
                                    //   alignment: Alignment.center,
                                    //   child: RichText(
                                    //     text: TextSpan(
                                    //       text: 'Forgotten password?',
                                    //       style: TextStyle(
                                    //         fontSize: 13.sp,
                                    //         color: Theme.of(context)
                                    //             .colorScheme
                                    //             .primary,
                                    //         fontFamily: "Montesserat",
                                    //       ),
                                    //       recognizer: TapGestureRecognizer()
                                    //         ..onTap = () {
                                    //           ToastService().showSuccessToast(
                                    //             'We are working on this feature',
                                    //           );
                                    //           // Fluttertoast.showToast(
                                    //           //   msg:
                                    //           //       'Forgotten password! button pressed',
                                    //           // );
                                    //         },
                                    //     ),
                                    //   ),
                                    // )
                                  ],
                                ),
                                const SizedBox(),
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text:
                                        'Already have an account?\nLogin instead!',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      fontSize: 13,
                                      fontFamily: "Montesserat",
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // Fluttertoast.showToast(
                                        //   msg: 'Create a new Account button pressed',
                                        // );
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const LoginScreen();
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
                ),
                if (isLoading) const TransparentLoadingScreen(),
              ],
            );
          },
        ),
      ),
    );
  }
}
