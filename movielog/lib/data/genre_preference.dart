import 'package:shared_preferences/shared_preferences.dart';

import 'movie.dart';

// 마지막으로 선택한 장르처럼 단순하고 중요하지 않은 설정값만 저장합니다.
// JWT, 비밀번호 같은 민감한 값은 flutter_secure_storage를 사용해야 합니다.
class GenrePreference {
  GenrePreference({SharedPreferencesAsync? preferences})
    : _preferences = preferences ?? SharedPreferencesAsync();

  static const allGenres = '전체';
  static const _selectedGenreKey = 'selected_genre';

  final SharedPreferencesAsync _preferences;

  Future<String> read() async {
    final genre = await _preferences.getString(_selectedGenreKey);
    // 저장된 장르가 더 이상 목록에 없다면 전체 보기로 되돌립니다.
    if (genre == null || !genres.contains(genre)) return allGenres;
    return genre;
  }

  Future<void> save(String genre) async {
    await _preferences.setString(_selectedGenreKey, genre);
  }

  Future<void> clear() async {
    await _preferences.remove(_selectedGenreKey);
  }
}
