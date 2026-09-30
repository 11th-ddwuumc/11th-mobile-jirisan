import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class ProfileStats extends StatelessWidget {
  const ProfileStats({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: StatItem(label: '본 영화', value: '24'),
        ),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: StatItem(label: '평점', value: '18'),
        ),
        SizedBox(width: AppSpacing.xs),
        Expanded(
          child: StatItem(label: '즐겨찾기', value: '7'),
        ),
      ],
    );
  }
}

class StatItem extends StatelessWidget {
  const StatItem({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(AppRadius.base),
      ),
      child: Column(
        children: [
          Text(value, style: AppTextStyles.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(label),
        ],
      ),
    );
  }
}
