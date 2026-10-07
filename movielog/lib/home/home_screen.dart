import 'package:flutter/material.dart';

import '../common_app_bar.dart';
import '../data/movie.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'featured_movie_card.dart';
import 'popular_movie_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: 'MovieLog',
        actions: [
          IconButton(
            // 3주차에는 검색 버튼 모양만 구현합니다.
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: '검색',
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: Text(
                  '오늘은 어떤\n영화를 볼까요?',
                  style: AppTextStyles.titleLarge.copyWith(
                    fontSize: 28,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
                child: FeaturedMovieCard(movie: movies.first),
              ),
              const SizedBox(height: AppSpacing.lg),
              // 추천 신작을 제외한 나머지 영화를 인기 영화로 보여줍니다.
              PopularMovieList(movies: movies.skip(1).toList()),
            ],
          ),
        ),
      ),
    );
  }
}
