import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';

// 상세 화면 하단의 즐겨찾기 / 평점 남기기 버튼
class DetailActionBar extends StatelessWidget {
  const DetailActionBar({
    super.key,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.onRatePressed,
  });

  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final VoidCallback onRatePressed;

  static const double _buttonHeight = 48;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 15, fontWeight: FontWeight.w700);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.sm),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: _buttonHeight,
                  child: OutlinedButton.icon(
                    onPressed: onFavoritePressed,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.deepViolet,
                      side: const BorderSide(color: AppColors.deepViolet),
                      shape: const StadiumBorder(),
                      textStyle: textStyle,
                    ),
                    icon: Icon(
                      isFavorite ? Icons.bookmark : Icons.bookmark_border,
                    ),
                    label: Text(isFavorite ? '즐겨찾기 해제' : '즐겨찾기'),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: _buttonHeight,
                  child: ElevatedButton.icon(
                    onPressed: onRatePressed,
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      textStyle: textStyle,
                    ),
                    icon: const Icon(Icons.rate_review_outlined),
                    label: const Text('평점 남기기'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
