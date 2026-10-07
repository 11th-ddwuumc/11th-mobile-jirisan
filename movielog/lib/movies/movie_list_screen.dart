import 'package:flutter/material.dart';

import '../common_app_bar.dart';
import '../data/genre_preference.dart';
import '../data/movie.dart';
import '../data/movie_service.dart';
import '../theme/app_spacing.dart';
import 'genre_chip_bar.dart';
import 'movie_grid.dart';
import 'states/movie_list_empty.dart';
import 'states/movie_list_error.dart';
import 'states/movie_list_loading.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({
    super.key,
    this.movieService = const FakeMovieService(),
    this.genrePreference,
  });

  final FakeMovieService movieService;
  final GenrePreference? genrePreference;

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  static final _genreChips = [GenrePreference.allGenres, ...genres];

  late final GenrePreference _genrePreference =
      widget.genrePreference ?? GenrePreference();

  // build가 다시 실행돼도 요청이 반복되지 않도록 Future를 필드에 보관합니다.
  late Future<List<Movie>> _moviesFuture;
  String _selectedGenre = GenrePreference.allGenres;

  // 당겨서 새로고침 중에는 Loading 화면 대신 기존 목록을 유지합니다.
  bool _isRefreshing = false;

  @override
  void initState() {
    super.initState();
    _moviesFuture = widget.movieService.fetchMovies();
    _restoreSelectedGenre();
  }

  Future<void> _restoreSelectedGenre() async {
    final genre = await _genrePreference.read();

    // await 사이에 화면이 사라졌다면 setState를 호출하지 않습니다.
    if (!mounted) return;
    setState(() => _selectedGenre = genre);
  }

  Future<void> _selectGenre(String genre) async {
    if (genre == _selectedGenre) return;
    setState(() => _selectedGenre = genre);
    await _genrePreference.save(genre);
  }

  // 재시도나 상태 전환처럼 작업을 다시 시작해야 할 때만 새로운 Future를 만듭니다.
  void _load([MovieLoadMode mode = MovieLoadMode.success]) {
    setState(() {
      _isRefreshing = false;
      _moviesFuture = widget.movieService.fetchMovies(mode: mode);
    });
  }

  Future<void> _refresh() async {
    final future = widget.movieService.fetchMovies();
    setState(() {
      _isRefreshing = true;
      _moviesFuture = future;
    });

    try {
      await future;
    } on MovieLoadException {
      // 오류 화면은 FutureBuilder가 표시하므로 여기서는 Indicator만 닫습니다.
    }
  }

  List<Movie> _filter(List<Movie> movies) {
    if (_selectedGenre == GenrePreference.allGenres) return movies;
    return movies.where((movie) => movie.genre == _selectedGenre).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppBar(
        title: '영화',
        actions: [
          IconButton(
            // 검색은 아직 버튼 모양만 구현합니다.
            onPressed: () {},
            icon: const Icon(Icons.search),
            tooltip: '검색',
          ),
          // 4주차 스터디 인증용: Mock Service의 응답 결과를 바꿔 각 상태를 확인합니다.
          PopupMenuButton<MovieLoadMode>(
            icon: const Icon(Icons.science_outlined),
            tooltip: '상태 테스트',
            onSelected: _load,
            itemBuilder: (context) => const [
              PopupMenuItem(value: MovieLoadMode.success, child: Text('성공')),
              PopupMenuItem(value: MovieLoadMode.empty, child: Text('빈 목록')),
              PopupMenuItem(value: MovieLoadMode.failure, child: Text('실패')),
              PopupMenuItem(value: MovieLoadMode.timeout, child: Text('시간 초과')),
            ],
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            GenreChipBar(
              genres: _genreChips,
              selectedGenre: _selectedGenre,
              onSelected: _selectGenre,
            ),
            Expanded(
              child: FutureBuilder<List<Movie>>(
                future: _moviesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !(_isRefreshing && snapshot.hasData)) {
                    return const MovieListLoading();
                  }

                  // 오류를 빈 목록보다 먼저 확인해야 Error가 Empty로 보이지 않습니다.
                  if (snapshot.hasError) {
                    return MovieListError(onRetry: _load);
                  }

                  final movies = _filter(snapshot.data ?? const <Movie>[]);

                  return RefreshIndicator(
                    onRefresh: _refresh,
                    child: movies.isEmpty
                        ? const CustomScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            slivers: [
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: MovieListEmpty(),
                              ),
                            ],
                          )
                        : MovieGrid(movies: movies),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
