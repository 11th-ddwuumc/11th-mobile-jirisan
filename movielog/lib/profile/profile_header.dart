import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  static const double _imageSize = AppSpacing.unit * 16; // 128
  static const double _borderWidth = 2;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(_borderWidth),
          decoration: const BoxDecoration(
            color: AppColors.lavender,
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/profile/profile_movielog.jpg',
              width: _imageSize - _borderWidth * 2,
              height: _imageSize - _borderWidth * 2,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Flexible(
              child: Text(
                '무비러버',
                style: AppTextStyles.titleLarge,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            SvgPicture.asset(
              'assets/icons/movie.svg',
              width: AppSpacing.md,
              height: AppSpacing.md,
              semanticsLabel: '영화 아이콘',
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          '좋아하는 영화를 기록하고 있어요',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.darkGray),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
