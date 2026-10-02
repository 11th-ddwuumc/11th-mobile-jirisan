import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      // 1주차에는 버튼 모양만 구현하고 화면 이동 기능은 넣지 않습니다.
      onPressed: () {},
      style: TextButton.styleFrom(
        foregroundColor: AppColors.violet,
        textStyle: AppTextStyles.titleMedium,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        side: const BorderSide(color: AppColors.violet),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.base),
        ),
      ),
      child: const Text('프로필 수정'),
    );
  }
}
