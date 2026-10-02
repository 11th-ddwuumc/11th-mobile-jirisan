import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../data/movie.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// 영화 제목, 기본 정보, 평균 평점, 태그
class MovieInfoSection extends StatelessWidget {
  const MovieInfoSection({super.key, required this.movie, this.myRating});

  final Movie movie;

  // 사용자가 이번 화면에서 남긴 평점 (화면 내부 상태)
  final double? myRating;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: AppTextStyles.titleLarge.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${movie.year} • ${movie.genre} • ${movie.runtime}분',
            style: AppTextStyles.bodySmall.copyWith(color: AppColors.darkGray),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              // 평균 평점은 읽기 전용이므로 RatingBarIndicator로 표시합니다.
              RatingBarIndicator(
                rating: movie.rating,
                itemCount: 5,
                itemSize: 22,
                unratedColor: AppColors.outline,
                itemBuilder: (context, index) {
                  return const Icon(Icons.star, color: AppColors.primary);
                },
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(
                movie.rating.toStringAsFixed(1),
                style: AppTextStyles.titleMedium,
              ),
              const SizedBox(width: 4),
              Text(
                '(${_formatCount(movie.reviewCount)})',
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.darkGray,
                ),
              ),
            ],
          ),
          if (myRating != null) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              '내 평점 ${myRating!.toStringAsFixed(1)}점',
              style: AppTextStyles.bodySmall.copyWith(
                color: AppColors.deepViolet,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [for (final tag in movie.tags) _TagChip(label: tag)],
          ),
        ],
      ),
    );
  }

  // 1245 → 1,245
  static String _formatCount(int count) {
    return count.toString().replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => ',',
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: const ShapeDecoration(
        color: AppColors.tagFill,
        shape: StadiumBorder(),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(color: AppColors.darkGray),
      ),
    );
  }
}
