import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common_app_bar.dart';
import '../data/movie.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'detail_action_bar.dart';
import 'movie_info_section.dart';
import 'rating_dialog.dart';
import 'synopsis_section.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen({super.key, required this.movieId});

  // Path Parameter(:movieId)에서 읽은 영화 ID
  final int? movieId;

  @override
  State<MovieDetailScreen> createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  // 즐겨찾기와 내 평점은 서버 없이 화면 내부 상태로만 관리합니다.
  bool _isFavorite = false;
  double? _myRating;

  // 탭 화면(MainScreen)의 Scaffold가 아니라 상세 화면 Scaffold에 Snackbar를 띄워
  // 하단 즐겨찾기·평점 버튼을 가리지 않도록 별도의 ScaffoldMessenger를 둡니다.
  final _messengerKey = GlobalKey<ScaffoldMessengerState>();

  void _showSnackBar(String message) {
    _messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    _showSnackBar(_isFavorite ? '즐겨찾기에 추가했습니다.' : '즐겨찾기에서 삭제했습니다.');
  }

  Future<void> _openRatingDialog() async {
    final rating = await showDialog<double>(
      context: context,
      builder: (context) {
        return RatingDialog(initialRating: _myRating ?? 0);
      },
    );

    // 닫기를 눌렀거나 바깥 영역을 눌러 닫았다면 아무것도 바꾸지 않습니다.
    if (rating == null || !mounted) return;
    setState(() {
      _myRating = rating;
    });
    _showSnackBar('${rating.toStringAsFixed(1)}점으로 평점을 남겼습니다.');
  }

  @override
  Widget build(BuildContext context) {
    final movie = findMovieById(widget.movieId);

    return ScaffoldMessenger(
      key: _messengerKey,
      child: Scaffold(
        appBar: CommonAppBar(
          title: 'Cinema Archive',
          centerTitle: true,
          // push()로 쌓인 상세 화면을 pop()으로 제거해 이전 화면으로 돌아갑니다.
          onBack: () => context.pop(),
          actions: [
            IconButton(
              // 3주차에는 공유 버튼 모양만 구현합니다.
              onPressed: () {},
              icon: const Icon(Icons.share_outlined),
              tooltip: '공유',
            ),
          ],
        ),
        body: movie == null
            ? const _MovieNotFound()
            : ListView(
                children: [
                  AspectRatio(
                    aspectRatio: 2 / 3,
                    child: Image.asset(
                      movie.posterAsset,
                      fit: BoxFit.cover,
                      semanticLabel: '${movie.title} 포스터',
                    ),
                  ),
                  MovieInfoSection(movie: movie, myRating: _myRating),
                  const Divider(height: 1, color: AppColors.divider),
                  SynopsisSection(synopsis: movie.synopsis),
                ],
              ),
        bottomNavigationBar: movie == null
            ? null
            : DetailActionBar(
                isFavorite: _isFavorite,
                onFavoritePressed: _toggleFavorite,
                onRatePressed: _openRatingDialog,
              ),
      ),
    );
  }
}

class _MovieNotFound extends StatelessWidget {
  const _MovieNotFound();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Text(
          '영화 정보를 찾을 수 없습니다.',
          style: AppTextStyles.bodyMedium.copyWith(color: AppColors.gray),
        ),
      ),
    );
  }
}
