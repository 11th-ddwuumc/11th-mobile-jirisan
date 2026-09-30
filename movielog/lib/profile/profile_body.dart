import 'package:flutter/material.dart';

import '../theme/app_spacing.dart';
import 'edit_profile_button.dart';
import 'favorite_genres.dart';
import 'profile_header.dart';
import 'profile_stats.dart';

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.lg,
        AppSpacing.sm,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProfileHeader(),
          SizedBox(height: AppSpacing.lg),
          ProfileStats(),
          FavoriteGenres(),
          SizedBox(height: AppSpacing.lg),
          Center(child: EditProfileButton()),
        ],
      ),
    );
  }
}
