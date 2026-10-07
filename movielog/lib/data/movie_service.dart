import 'dart:async';

import 'movie.dart';

// 4주차 학습용으로 Mock Service의 응답 결과를 고르는 값
enum MovieLoadMode { success, empty, failure, timeout }

class MovieLoadException implements Exception {
  const MovieLoadException(this.message);

  final String message;

  @override
  String toString() => 'MovieLoadException: $message';
}

// 실제 API 대신 Future.delayed로 네트워크 지연을 흉내내는 Mock Service
// 화면은 fetchMovies()가 반환하는 Future만 알면 되므로 5주차에 이 경계만 교체합니다.
class FakeMovieService {
  const FakeMovieService({
    this.delay = const Duration(seconds: 1),
    this.timeout = const Duration(seconds: 5),
  });

  final Duration delay;
  final Duration timeout;

  // TODO(5주차 유저별 평점 조회 API): Swagger v5 명세의 실제 API Service로 교체합니다.
  Future<List<Movie>> fetchMovies({
    MovieLoadMode mode = MovieLoadMode.success,
  }) async {
    try {
      return await _request(mode).timeout(timeout);
    } on TimeoutException {
      throw const MovieLoadException('응답 시간이 초과되었습니다.');
    }
  }

  Future<List<Movie>> _request(MovieLoadMode mode) async {
    // timeout 모드는 응답이 제한 시간보다 늦게 도착하는 상황입니다.
    await Future<void>.delayed(
      mode == MovieLoadMode.timeout ? timeout * 2 : delay,
    );

    return switch (mode) {
      MovieLoadMode.success || MovieLoadMode.timeout => movies,
      MovieLoadMode.empty => const <Movie>[],
      MovieLoadMode.failure => throw const MovieLoadException(
        '영화를 불러오지 못했습니다.',
      ),
    };
  }
}
