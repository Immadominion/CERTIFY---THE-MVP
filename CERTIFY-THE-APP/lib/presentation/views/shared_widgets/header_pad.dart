import 'dart:ui';

import 'package:certify/core/extensions/widget_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CertifyHeader extends StatelessWidget {
  final String heading;
  final String headerBody;
  final IconData icon;
  final void Function() onTap;
  const CertifyHeader({
    super.key,
    required this.heading,
    required this.headerBody,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.sp, horizontal: 10.sp),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                heading,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontFamily: "Montesserat",
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                headerBody,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontFamily: "Montesserat",
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              onTap();
              HapticFeedback.lightImpact();
            },
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(25.r)),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                child: Container(
                  height: 50.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 25.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(.8),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ).afmPadding(EdgeInsets.only(left: 15.sp, right: 10.sp)),
    );
  }
}
