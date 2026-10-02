import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'movie_rating_input.dart';

// 별점을 선택하는 커스텀 Dialog
// 저장하면 선택한 별점을, 닫기를 누르면 null을 반환합니다.
class RatingDialog extends StatefulWidget {
  const RatingDialog({super.key, this.initialRating = 0});

  // 이전에 남긴 평점이 있으면 그 값으로 시작합니다.
  final double initialRating;

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  late double _rating = widget.initialRating;

  // RatingBar는 initialRating을 처음 한 번만 읽기 때문에
  // 초기화할 때 Key를 바꿔 새 RatingBar로 다시 그립니다.
  int _resetCount = 0;

  bool get _hasRating => _rating > 0;

  void _reset() {
    setState(() {
      _rating = 0;
      _resetCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('영화는 어떠셨나요?', style: AppTextStyles.titleLarge),
            const SizedBox(height: AppSpacing.md),
            MovieRatingInput(
              key: ValueKey(_resetCount),
              rating: _rating,
              onChanged: (value) {
                setState(() {
                  _rating = value;
                });
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              _hasRating
                  ? '${_rating.toStringAsFixed(1)}점'
                  : '별을 눌러 평점을 선택해주세요',
              style: _hasRating
                  ? AppTextStyles.titleMedium.copyWith(
                      color: AppColors.deepViolet,
                    )
                  : AppTextStyles.bodyMedium.copyWith(color: AppColors.gray),
            ),
            TextButton.icon(
              onPressed: _hasRating ? _reset : null,
              icon: const Icon(Icons.refresh),
              label: const Text('다시 선택'),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('닫기'),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                // 별점을 선택해야 저장 버튼이 활성화됩니다.
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hasRating
                        ? () => Navigator.pop(context, _rating)
                        : null,
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: AppColors.disabledButton,
                      disabledForegroundColor: AppColors.white,
                    ),
                    child: const Text('저장'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
