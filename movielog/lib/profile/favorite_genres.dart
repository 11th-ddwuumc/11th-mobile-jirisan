import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class FavoriteGenres extends StatelessWidget {
  const FavoriteGenres({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: AppSpacing.lg),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('선호하는 장르', style: AppTextStyles.titleMedium),
          SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              _GenreChip(label: '드라마'),
              _GenreChip(label: 'SF'),
              _GenreChip(label: '애니메이션'),
            ],
          ),
        ],
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  const _GenreChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.deepViolet,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: AppColors.lightViolet,
      side: BorderSide.none,
      shape: const StadiumBorder(),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
