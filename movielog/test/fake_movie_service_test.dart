import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/data/movie.dart';
import 'package:movielog/data/movie_service.dart';

void main() {
  const service = FakeMovieService(
    delay: Duration(milliseconds: 10),
    timeout: Duration(milliseconds: 50),
  );

  test('success 모드는 Mock 영화 목록을 반환한다', () async {
    expect(await service.fetchMovies(), movies);
  });

  test('empty 모드는 빈 목록을 반환한다', () async {
    expect(await service.fetchMovies(mode: MovieLoadMode.empty), isEmpty);
  });

  test('failure 모드는 MovieLoadException으로 완료된다', () {
    expect(
      service.fetchMovies(mode: MovieLoadMode.failure),
      throwsA(isA<MovieLoadException>()),
    );
  });

  test('timeout 모드는 제한 시간이 지나면 MovieLoadException으로 완료된다', () {
    expect(
      service.fetchMovies(mode: MovieLoadMode.timeout),
      throwsA(isA<MovieLoadException>()),
    );
  });
}
