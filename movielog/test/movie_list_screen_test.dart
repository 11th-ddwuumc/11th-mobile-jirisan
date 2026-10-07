import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/data/genre_preference.dart';
import 'package:movielog/movies/movie_card.dart';
import 'package:movielog/movies/movie_list_screen.dart';
import 'package:movielog/movies/states/movie_list_empty.dart';
import 'package:movielog/movies/states/movie_list_error.dart';
import 'package:movielog/movies/states/movie_list_loading.dart';
import 'package:movielog/theme/app_theme.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

void main() {
  setUp(() {
    SharedPreferencesAsyncPlatform.instance =
        InMemorySharedPreferencesAsync.empty();
  });

  Future<void> pumpScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const MovieListScreen()),
    );
  }

  Future<void> selectMode(WidgetTester tester, String label) async {
    await tester.tap(find.byTooltip('상태 테스트'));
    await tester.pumpAndSettle();
    await tester.tap(find.text(label));
    await tester.pump();
  }

  testWidgets('Loading을 먼저 보여주고 1초 뒤 영화 목록을 보여준다', (tester) async {
    await pumpScreen(tester);
    expect(find.byType(MovieListLoading), findsOneWidget);
    expect(find.byType(MovieCard), findsNothing);

    // 최소 800ms 동안은 Loading이 유지됩니다.
    await tester.pump(const Duration(milliseconds: 800));
    expect(find.byType(MovieListLoading), findsOneWidget);

    await tester.pumpAndSettle();
    expect(find.byType(MovieListLoading), findsNothing);
    expect(find.byType(MovieCard), findsNWidgets(6));
  });

  testWidgets('빈 목록이면 Empty 화면을 보여준다', (tester) async {
    await pumpScreen(tester);
    await tester.pumpAndSettle();

    await selectMode(tester, '빈 목록');
    expect(find.byType(MovieListLoading), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(MovieListEmpty), findsOneWidget);
    expect(find.text('조건에 맞는 영화가 없습니다.'), findsOneWidget);
  });

  testWidgets('실패하면 Error 화면을 보여주고 다시 시도하면 성공한다', (tester) async {
    await pumpScreen(tester);
    await tester.pumpAndSettle();

    await selectMode(tester, '실패');
    await tester.pumpAndSettle();
    expect(find.byType(MovieListError), findsOneWidget);
    expect(find.byType(MovieListEmpty), findsNothing);
    // 내부 Exception 내용은 화면에 노출하지 않습니다.
    expect(find.textContaining('MovieLoadException'), findsNothing);

    await tester.tap(find.text('다시 시도'));
    await tester.pump();
    expect(find.byType(MovieListLoading), findsOneWidget);
    await tester.pumpAndSettle();
    expect(find.byType(MovieCard), findsNWidgets(6));
  });

  testWidgets('응답이 늦으면 시간 초과 후 Error 화면을 보여준다', (tester) async {
    await pumpScreen(tester);
    await tester.pumpAndSettle();

    await selectMode(tester, '시간 초과');
    await tester.pump(const Duration(seconds: 4));
    expect(find.byType(MovieListLoading), findsOneWidget);
    await tester.pump(const Duration(seconds: 2));
    expect(find.byType(MovieListError), findsOneWidget);

    // 제한 시간 뒤에 도착한 응답의 Timer까지 끝냅니다.
    await tester.pumpAndSettle(const Duration(seconds: 5));
  });

  testWidgets('선택한 장르를 저장하고 화면을 다시 만들면 복원한다', (tester) async {
    await pumpScreen(tester);
    await tester.pumpAndSettle();

    await tester.tap(find.widgetWithText(ChoiceChip, '스릴러'));
    await tester.pumpAndSettle();
    expect(find.byType(MovieCard), findsOneWidget);
    expect(await GenrePreference().read(), '스릴러');

    // 앱 재실행처럼 화면을 완전히 제거한 뒤 다시 만듭니다.
    await tester.pumpWidget(const SizedBox());
    await pumpScreen(tester);
    await tester.pumpAndSettle();

    final chip = tester.widget<ChoiceChip>(
      find.widgetWithText(ChoiceChip, '스릴러'),
    );
    expect(chip.selected, isTrue);
    expect(find.byType(MovieCard), findsOneWidget);
    expect(find.text('밤의 그림자'), findsOneWidget);
  });
}
