import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:certify/core/constants/enum.dart';
import 'package:certify/core/extensions/widget_extension.dart';
import 'package:certify/data/controllers/all_manufacturer_projects_controller.dart';
import 'package:certify/data/controllers/create_project_controller.dart';
import 'package:certify/presentation/general_components/auth_component_1.dart';
import 'package:certify/presentation/general_components/cta_button.dart';
import 'package:certify/presentation/general_components/shared_loading.dart';
import 'package:certify/presentation/views/manufacturer_home/components/build_grid_view.dart';
import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:certify/presentation/views/shared_widgets/status_bar_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../data/model_data/all_manufacturer_projects_model.dart';

class CreateSingleNft extends ConsumerStatefulWidget {
  const CreateSingleNft({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateSingleNftState();
}

class _CreateSingleNftState extends ConsumerState<CreateSingleNft> {
  late final TextEditingController nameController;
  late final TextEditingController symbolController;

  @override
  void initState() {
    super.initState();
    resetStatusBarColor();
    nameController = TextEditingController();
    symbolController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    symbolController.dispose();
    super.dispose();
  }

  Future<void> disposeData() async {
    // final listProjects = ref.read(certifyProjectsController);
    ref.read(createProjectController).dispose;
    // Update the dataList here based on the fetched data
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Consumer(builder: (context, ref, child) {
        final LoadingState loadingState =
            ref.read(createProjectController).loadingState;
        final bool isLoading = loadingState == LoadingState.loading;
        return Stack(
          children: [
            ListView(
              children: [
                CertifyHeader(
                  heading: 'CERTIFY',
                  headerBody: "Create A NFT",
                  icon: Icons.qr_code_scanner_rounded,
                  onTap: () {},
                ),
                Stack(
                  children: [
                    Column(
                      children: [
                        InkWell(
                          highlightColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          onTap: () {
                            ref.read(createProjectController).pickImage();
                          },
                          child: Center(
                            child: Container(
                              height: 310.h,
                              width: 310.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withOpacity(.2),
                                border: Border.all(
                                  color: Theme.of(context)
                                      .primaryColor, // Change the border color as needed
                                  width:
                                      1.sp, // Adjust the border width as needed
                                ),
                                borderRadius: BorderRadius.circular(15.r),
                                shape: BoxShape.rectangle,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.r),
                                child: Image.file(
                                  File(
                                    ref
                                        .watch(createProjectController)
                                        .imagePath,
                                  ),
                                  fit: BoxFit.fitHeight,
                                  width: 300.w,
                                  height: 300.h,
                                  frameBuilder: (
                                    BuildContext context,
                                    Widget child,
                                    int? frame,
                                    bool wasSynchronouslyLoaded,
                                  ) {
                                    if (wasSynchronouslyLoaded ||
                                        frame != null) {
                                      // Image is fully loaded
                                      return child;
                                    } else {
                                      // Show a loading indicator or placeholder while the image is loading
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                  },
                                  errorBuilder: (BuildContext context,
                                      Object error, StackTrace? stackTrace) {
                                    // Show a fallback widget when the image fails to load
                                    return Center(
                                      child: Icon(
                                        Icons.add_a_photo_rounded,
                                        size: 40.sp,
                                      ),
                                    );
                                  },
                                ).afmBorderRadius(
                                  BorderRadius.only(
                                    topRight: Radius.circular(
                                      20.r,
                                    ),
                                    topLeft: Radius.circular(
                                      20.r,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        component1(
                          Icons.person,
                          'Name',
                          false,
                          true,
                          context,
                          nameController,
                        ).afmPadding(
                          EdgeInsets.only(top: 10.h),
                        ),
                        component1(
                          Icons.abc,
                          'Model',
                          false,
                          true,
                          context,
                          symbolController,
                        ).afmPadding(
                          EdgeInsets.symmetric(vertical: 10.h),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Large Project? \nCreate multiple nfts",
                              textAlign: TextAlign.left,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            SizedBox(
                              height: 35.h,
                              width: 150.w,
                              child: CustomButton(
                                buttonOnPressed: () {
                                  // ref
                                  //     .read(createProjectController)
                                  //     .toCreateSingleNft(
                                  //       nameController.text,
                                  //       symbolController.text,
                                  //       ref
                                  //           .read(certifyProjectsController)
                                  //           .projectId,
                                  //     )
                                  projects?.add(
                                    ProjectModel(
                                      id: 3,
                                      status: "pending",
                                      mintAddress:
                                          "0x123knk12jvkhl1235123b5blk,mnb,1235 n ",
                                      semifungible: false,
                                      sellerFeeBasisPoints: 750,
                                      name: "iPod",
                                      symbol: "IPD",
                                      description:
                                          "Listen to music, anywhere, anytime!",
                                      image: "assets/images/ipod.jpeg",
                                      nfts: NftsModel(
                                        results: [
                                          "qwoehjnwsdf",
                                          "asfjn2kl3ss",
                                          "asdfn2kl3nr",
                                          "asdnknasdkg"
                                        ],
                                        page: 2,
                                        limit: 4,
                                        totalPages: 2,
                                        totalResults: 8,
                                      ),
                                    ),
                                  );

                                  Future.delayed(const Duration(seconds: (2)))
                                      .then((value) {
                                    // if (value == true) {
                                    setState(() {});
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.success,
                                      title: 'Successful',
                                      desc:
                                          'You have successfully created a project',
                                      btnOkOnPress: () {
                                        Navigator.pop(context);
                                      },
                                    ).show();
                                    Future.delayed(
                                      Duration.zero,
                                      () {
                                        disposeData();
                                      },
                                    );
                                    // } else {
                                    //   setState(() {});
                                    //   AwesomeDialog(
                                    //     context: context,
                                    //     animType: AnimType.scale,
                                    //     dialogType: DialogType.error,
                                    //     title: 'Failed',
                                    //     desc:
                                    //         'Your project could not be created!',
                                    //     btnOkOnPress: () {
                                    //       Navigator.pop(context);
                                    //     },
                                    //   ).show();
                                    //   Future.delayed(
                                    //     Duration.zero,
                                    //     () {
                                    //       disposeData();
                                    //     },
                                    //   );
                                    // }
                                  });
                                },
                                pageCTA: 'Create Single Nft',
                              ).afmBorderRadius(BorderRadius.circular(20.r)),
                            ),
                          ],
                        ).afmPadding(EdgeInsets.symmetric(horizontal: 30.sp)),
                      ],
                    ),
                    if (isLoading) const TransparentLoadingScreen(),
                  ],
                ),
              ],
            ),
          ],
        );
      }),
    );
  }
}
