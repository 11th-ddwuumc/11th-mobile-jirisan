import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/movie.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// 홈 상단의 추천 신작 카드
class FeaturedMovieCard extends StatelessWidget {
  const FeaturedMovieCard({super.key, required this.movie});

  final Movie movie;

  static const double _radius = 24;

  void _openDetail(BuildContext context) {
    context.push(AppRouter.movieDetail(movie.id));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => _openDetail(context),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(_radius),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                movie.posterAsset,
                fit: BoxFit.cover,
                semanticLabel: '${movie.title} 포스터',
              ),
              // 아래쪽 글자가 잘 보이도록 어둡게 덮는 그라데이션
              const DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, AppColors.scrim],
                    stops: [0.45, 1],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _BadgeLabel(label: '추천 신작'),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      movie.title,
                      style: AppTextStyles.titleLarge.copyWith(
                        fontSize: 28,
                        color: AppColors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${movie.genre} · ${movie.runtime}분',
                      style: AppTextStyles.bodyMedium.copyWith(
                        color: AppColors.white.withValues(alpha: 0.8),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () => _openDetail(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.deepViolet,
                          shape: const StadiumBorder(),
                          textStyle: AppTextStyles.titleMedium,
                        ),
                        icon: const Icon(Icons.info, size: 24),
                        label: const Text('상세보기'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BadgeLabel extends StatelessWidget {
  const _BadgeLabel({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 4,
      ),
      decoration: ShapeDecoration(
        color: AppColors.deepViolet,
        shape: StadiumBorder(
          side: BorderSide(color: AppColors.lavender.withValues(alpha: 0.6)),
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.bodySmall.copyWith(
          color: AppColors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
