import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class LoginPrompt extends StatelessWidget {
  const LoginPrompt({super.key, this.isWide = false});

  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final fontSize = isWide ? 14.0 : 16.0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '이미 계정이 있나요?',
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: fontSize,
            color: AppColors.darkGray,
          ),
        ),
        TextButton(
          // 2주차에는 버튼 모양만 구현하고 화면 이동 기능은 넣지 않습니다.
          onPressed: () {},
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            minimumSize: const Size(0, 40),
          ),
          child: Text(
            '로그인',
            style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w700),
          ),
        ),
      ],
    );
  }
}
