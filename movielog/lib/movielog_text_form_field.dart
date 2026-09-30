import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'theme/app_colors.dart';
import 'theme/app_spacing.dart';
import 'theme/app_text_styles.dart';

// 라벨 + 입력창 + 상태 아이콘(오류/완료)을 묶은 공통 입력 Widget
class MovieLogTextFormField extends StatelessWidget {
  const MovieLogTextFormField({
    super.key,
    required this.label,
    required this.hintText,
    required this.controller,
    required this.validator,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.trailing,
    this.compact = false,
  });

  final String label;
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;

  // 상태 아이콘 오른쪽에 추가로 표시할 Widget (예: 비밀번호 표시·숨김 버튼)
  final Widget? trailing;

  // true면 라벨·입력 글자를 작게 표시합니다. (넓은 화면 Figma 기준)
  final bool compact;

  // Figma 기준 입력창 높이
  static const double _fieldHeight = 42;
  static const double _iconSize = 24;

  static final _radius = BorderRadius.circular(AppRadius.base);

  static OutlineInputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: _radius,
      borderSide: BorderSide(color: color, width: width),
    );
  }

  Widget? _buildStatusIcon() {
    if (controller.text.isEmpty) return null;

    final hasError = validator(controller.text) != null;
    return SvgPicture.asset(
      hasError ? 'assets/icons/error.svg' : 'assets/icons/check_circle.svg',
      width: _iconSize,
      height: _iconSize,
      colorFilter: ColorFilter.mode(
        hasError ? AppColors.error : AppColors.primary,
        BlendMode.srcIn,
      ),
      semanticsLabel: hasError ? '입력 오류' : '입력 완료',
    );
  }

  Widget? _buildSuffix() {
    final statusIcon = _buildStatusIcon();
    if (statusIcon == null && trailing == null) return null;

    return Padding(
      padding: EdgeInsets.only(
        right: trailing == null ? AppSpacing.sm : AppSpacing.xs,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [?statusIcon, ?trailing],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final inputStyle = AppTextStyles.bodyMedium.copyWith(
      fontSize: compact ? 15 : 16,
    );
    final lineHeight = inputStyle.fontSize! * inputStyle.height!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            fontSize: compact ? 13 : 16,
            fontWeight: FontWeight.w700,
            height: 1.25,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          obscureText: obscureText,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: validator,
          onChanged: onChanged,
          onFieldSubmitted: onFieldSubmitted,
          style: inputStyle,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: inputStyle.copyWith(
              color: compact ? AppColors.gray : AppColors.darkGray,
            ),
            isDense: true,
            filled: true,
            // 오류 상태일 때만 배경색을 붉게 변경
            fillColor: WidgetStateColor.resolveWith(
              (states) => states.contains(WidgetState.error)
                  ? AppColors.errorContainer
                  : AppColors.inputFill,
            ),
            // 오류 메시지를 입력창 왼쪽 끝에 맞추기 위해 왼쪽 padding은 0으로 두고
            // 입력 글자 앞 여백은 prefixIcon으로 만듭니다.
            contentPadding: EdgeInsets.fromLTRB(
              0,
              (_fieldHeight - lineHeight) / 2,
              AppSpacing.sm,
              (_fieldHeight - lineHeight) / 2,
            ),
            prefixIcon: const SizedBox(width: AppSpacing.sm),
            prefixIconConstraints: const BoxConstraints(
              minWidth: AppSpacing.sm,
            ),
            suffixIcon: _buildSuffix(),
            suffixIconConstraints: const BoxConstraints(
              minWidth: _iconSize,
              minHeight: _iconSize,
            ),
            errorStyle: AppTextStyles.bodySmall.copyWith(
              fontSize: compact ? 13 : 14,
              color: AppColors.error,
            ),
            enabledBorder: _border(AppColors.outline),
            focusedBorder: _border(AppColors.primary, width: 2),
            errorBorder: _border(AppColors.error),
            focusedErrorBorder: _border(AppColors.error, width: 2),
          ),
        ),
      ],
    );
  }
}
