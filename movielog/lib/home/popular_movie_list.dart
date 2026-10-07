import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/movie.dart';
import '../movies/movie_card.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// 홈의 "인기 영화" 제목과 가로 영화 목록
class PopularMovieList extends StatelessWidget {
  const PopularMovieList({super.key, required this.movies});

  final List<Movie> movies;

  static const double _cardWidth = 140;
  static const double _listHeight = 264;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: AppSpacing.sm),
          child: Row(
            children: [
              const Expanded(
                child: Text('인기 영화', style: AppTextStyles.titleLarge),
              ),
              TextButton(
                // 탭 전환이므로 위치 자체를 바꾸는 go()를 사용합니다.
                onPressed: () => context.go(AppRouter.movieList),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.violet,
                  textStyle: AppTextStyles.bodyMedium,
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('전체보기'),
                    SizedBox(width: 4),
                    Icon(Icons.chevron_right, size: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        SizedBox(
          height: _listHeight,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            itemCount: movies.length,
            separatorBuilder: (context, index) {
              return const SizedBox(width: 12);
            },
            itemBuilder: (context, index) {
              return SizedBox(
                width: _cardWidth,
                child: MovieCard(movie: movies[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
