import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.onPressed});

  // null이면 버튼이 비활성화됩니다.
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSpacing.unit * 7, // 56
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          disabledBackgroundColor: AppColors.disabledButton,
          disabledForegroundColor: AppColors.white,
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
        ),
        child: const Text('가입하기'),
      ),
    );
  }
}
