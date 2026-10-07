import 'package:flutter/material.dart';

import '../data/movie.dart';
import '../theme/app_spacing.dart';
import 'movie_card.dart';

class MovieGrid extends StatelessWidget {
  const MovieGrid({super.key, required this.movies});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      // 목록이 짧아도 RefreshIndicator로 당길 수 있도록 항상 스크롤을 허용합니다.
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(AppSpacing.sm),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: AppSpacing.md,
        childAspectRatio: 0.55,
      ),
      itemBuilder: (context, index) => MovieCard(movie: movies[index]),
    );
  }
}
