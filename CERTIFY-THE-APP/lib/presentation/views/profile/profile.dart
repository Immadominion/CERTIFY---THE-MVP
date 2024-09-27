import 'package:certify/presentation/views/shared_widgets/header_pad.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(builder: (context, ref, child) {
      return Stack(
        children: [
          ListView(
            children: [
              CertifyHeader(
                heading: "CERTIFY",
                headerBody: "Be Authentic, Be You",
                icon: Icons.person,
                onTap: () {},
              ),
            ],
          ),
        ],
      );
    }));
  }
}
