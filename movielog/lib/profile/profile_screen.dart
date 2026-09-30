import 'package:flutter/material.dart';

import '../common_app_bar.dart';
import 'profile_body.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(title: '내 프로필'),
      body: SafeArea(child: ProfileBody()),
    );
  }
}
