import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class TermsAgreementCheckbox extends StatelessWidget {
  const TermsAgreementCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.isWide = false,
  });

  final bool value;
  final ValueChanged<bool> onChanged;
  final bool isWide;

  // Checkbox 기본 크기
  static const double _defaultCheckboxSize = 18;

  @override
  Widget build(BuildContext context) {
    // Figma 기준 Checkbox 크기 (휴대폰 24, 넓은 화면 20)
    final checkboxSize = isWide ? 20.0 : 24.0;

    return Row(
      children: [
        SizedBox.square(
          dimension: checkboxSize,
          child: Transform.scale(
            scale: checkboxSize / _defaultCheckboxSize,
            child: Checkbox(
              value: value,
              onChanged: (checked) => onChanged(checked ?? false),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: const VisualDensity(
                horizontal: VisualDensity.minimumDensity,
                vertical: VisualDensity.minimumDensity,
              ),
              activeColor: AppColors.primary,
              checkColor: AppColors.white,
              side: const BorderSide(color: AppColors.outline),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          '필수 약관에 동의합니다',
          style: AppTextStyles.bodyMedium.copyWith(fontSize: isWide ? 14 : 16),
        ),
      ],
    );
  }
}
