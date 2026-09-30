import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key, this.isWide = false});

  // 넓은 화면에는 AppBar가 없으므로 제목을 본문에 함께 표시합니다.
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    if (!isWide) {
      return Text(
        '환영합니다!\n간단한 정보만 입력하고 시작해보세요.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkGray),
        textAlign: TextAlign.center,
      );
    }

    return Column(
      children: [
        Text(
          '회원가입',
          style: AppTextStyles.titleLarge.copyWith(
            fontSize: 30,
            color: AppColors.violet,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'MovieLog에 오신 것을 환영합니다!',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkGray),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
