import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common_app_bar.dart';
import '../data/movie.dart';
import '../router/app_router.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'genre_filter_sheet.dart';
import 'movie_card.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key, required this.selectedGenres});

  // URL의 Query Parameter(genre)에서 읽은 장르. 비어 있으면 전체 영화를 보여줍니다.
  final Set<String> selectedGenres;

  List<Movie> get _filteredMovies {
    if (selectedGenres.isEmpty) return movies;
    return movies
        .where((movie) => selectedGenres.contains(movie.genre))
        .toList();
  }

  Future<void> _openGenreFilter(BuildContext context) async {
    final result = await showModalBottomSheet<Set<String>>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      // NavigationBar까지 덮도록 최상위 Navigator에 띄웁니다.
      useRootNavigator: true,
      builder: (sheetContext) {
        return GenreFilterSheet(initialGenres: selectedGenres);
      },
    );

    // 확인 버튼을 누르지 않고 닫았다면 기존 필터를 유지합니다.
    if (result == null || !context.mounted) return;
    context.go(AppRouter.movieListWithGenres(result));
  }

  @override
  Widget build(BuildContext context) {
    final filteredMovies = _filteredMovies;

    return Scaffold(
      appBar: CommonAppBar(
        title: '영화',
        actions: [
          IconButton(
            // 3주차에는 검색 버튼 모양만 구현합니다.
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: '검색',
          ),
          IconButton(
            onPressed: () => _openGenreFilter(context),
            icon: Badge(
              isLabelVisible: selectedGenres.isNotEmpty,
              label: Text('${selectedGenres.length}'),
              backgroundColor: AppColors.primary,
              child: const Icon(Icons.filter),
            ),
            tooltip: '장르 필터',
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SafeArea(
        child: filteredMovies.isEmpty
            ? const _EmptyMovies()
            : GridView.builder(
                padding: const EdgeInsets.all(AppSpacing.sm),
                itemCount: filteredMovies.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: AppSpacing.md,
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, index) {
                  return MovieCard(movie: filteredMovies[index]);
                },
              ),
      ),
    );
  }
}

class _EmptyMovies extends StatelessWidget {
  const _EmptyMovies();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        '선택한 장르의 영화가 없습니다.',
        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.gray),
      ),
    );
  }
}
