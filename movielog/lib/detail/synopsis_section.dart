import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// 상세 화면의 시놉시스 영역
class SynopsisSection extends StatelessWidget {
  const SynopsisSection({super.key, required this.synopsis});

  final String synopsis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.lg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '시놉시스',
            style: AppTextStyles.titleLarge.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            synopsis,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.darkGray,
              height: 1.7,
            ),
          ),
        ],
      ),
    );
  }
}
