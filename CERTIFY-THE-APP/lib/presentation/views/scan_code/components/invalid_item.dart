import 'package:certify/data/controllers/all_certify_projects_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> invalidItem(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "I N V A L I D   I T E M   ",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Icon(
                  Icons.error_outline,
                  color: Colors.red[300],
                )
              ],
            ),
            content: Icon(
              Icons.error_outline,
              color: Colors.red[300],
            ));
      });
}

Future<dynamic> validItem(BuildContext context, WidgetRef ref) {
  return showDialog(
    context: context,
    builder: (context) {
      final data = ref.read(allCertifiedProjectsController).qrDataModel.nft;
      return AlertDialog.adaptive(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "C E R T I F I E D   ",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Icon(
              Icons.done,
              color: Colors.green[300],
            )
          ],
        ),
        content: SizedBox(
          height: 80.h,
          child: Column(
            children: [
              Text(
                "Name - ${data?.name}\nSymbol - ${data?.symbol}\nStatus - ${data?.status}\nMint Address - ${data?.mintAddress}",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    },
  );
}
