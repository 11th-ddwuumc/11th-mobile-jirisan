import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/detail/movie_detail_screen.dart';
import 'package:movielog/detail/rating_dialog.dart';
import 'package:movielog/home/home_screen.dart';
import 'package:movielog/movie_log_app.dart';
import 'package:movielog/movies/movie_card.dart';
import 'package:movielog/movies/movie_list_screen.dart';
import 'package:movielog/router/app_router.dart';
import 'package:movielog/sign_up/sign_up_screen.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester, String location) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    // AppRouter.router는 static이므로 테스트마다 시작 위치를 다시 지정합니다.
    AppRouter.router.go(location);
    await tester.pumpWidget(const MovieLogApp());
    await tester.pumpAndSettle();
  }

  String currentPath() => AppRouter.router.state.uri.toString();

  ElevatedButton saveButton(WidgetTester tester) =>
      tester.widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '저장'));

  testWidgets('시작 → 회원가입 → 홈으로 이동하고 뒤로 갈 수 없다', (tester) async {
    await pumpApp(tester, AppRouter.start);

    await tester.tap(find.text('시작하기'));
    await tester.pumpAndSettle();
    expect(find.byType(SignUpScreen), findsOneWidget);
    expect(find.byIcon(Icons.arrow_back), findsNothing);
    expect(AppRouter.router.canPop(), isFalse);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '무비러버');
    await tester.enterText(fields.at(1), 'movie@example.com');
    await tester.enterText(fields.at(2), 'password1234');
    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    await tester.tap(find.text('가입하기'));
    await tester.pumpAndSettle();

    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(AppRouter.router.canPop(), isFalse);
  });

  testWidgets('홈의 상세보기를 누르면 상세로 이동하고 뒤로 돌아온다', (tester) async {
    await pumpApp(tester, AppRouter.home);

    await tester.tap(find.text('상세보기'));
    await tester.pumpAndSettle();
    expect(currentPath(), '/movies/1');
    expect(find.byType(MovieDetailScreen), findsOneWidget);
    expect(find.text('Cinema Archive'), findsOneWidget);
    expect(find.text('별빛 아래 우리'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(currentPath(), AppRouter.home);
    expect(find.byType(MovieDetailScreen), findsNothing);
  });

  testWidgets('영화 탭에서 연 상세 화면은 탭을 바꿨다 와도 유지된다', (tester) async {
    await pumpApp(tester, AppRouter.home);

    await tester.tap(find.text('영화'));
    await tester.pumpAndSettle();
    expect(find.byType(MovieListScreen), findsOneWidget);
    expect(find.byType(GridView), findsOneWidget);

    await tester.tap(find.byType(MovieCard).at(1));
    await tester.pumpAndSettle();
    expect(currentPath(), '/movies/2');
    expect(find.text('우주의 끝에서'), findsOneWidget);

    await tester.tap(find.text('홈'));
    await tester.pumpAndSettle();
    expect(currentPath(), AppRouter.home);

    await tester.tap(find.text('영화'));
    await tester.pumpAndSettle();
    expect(currentPath(), '/movies/2');

    await tester.tap(find.byIcon(Icons.arrow_back));
    await tester.pumpAndSettle();
    expect(currentPath(), AppRouter.movieList);
  });

  testWidgets('BottomSheet에서 확인을 눌러야 장르 필터가 적용된다', (tester) async {
    await pumpApp(tester, AppRouter.movieList);
    final gridCards = find.descendant(
      of: find.byType(GridView),
      matching: find.byType(MovieCard),
    );
    expect(gridCards, findsNWidgets(6));

    await tester.tap(find.byTooltip('장르 필터'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(CheckboxListTile, 'SF'));
    await tester.tap(find.widgetWithText(CheckboxListTile, '스릴러'));
    await tester.pump();
    // 확인 전에는 URL(필터 조건)이 바뀌지 않습니다.
    expect(currentPath(), AppRouter.movieList);

    await tester.tap(find.text('확인 (2개 장르)'));
    await tester.pumpAndSettle();
    expect(currentPath(), '/movies?genre=SF&genre=%EC%8A%A4%EB%A6%B4%EB%9F%AC');
    expect(gridCards, findsNWidgets(2));
    expect(find.text('우주의 끝에서'), findsOneWidget);
    expect(find.text('밤의 그림자'), findsOneWidget);

    // 아무 장르도 선택하지 않고 확인하면 전체 목록으로 돌아갑니다.
    await tester.tap(find.byTooltip('장르 필터'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('선택 해제'));
    await tester.pump();
    await tester.tap(find.text('확인 (전체 보기)'));
    await tester.pumpAndSettle();
    expect(currentPath(), AppRouter.movieList);
    expect(gridCards, findsNWidgets(6));
  });

  testWidgets('즐겨찾기 Snackbar와 평점 Dialog가 동작한다', (tester) async {
    await pumpApp(tester, AppRouter.movieList);
    await tester.tap(find.byType(MovieCard).first);
    await tester.pumpAndSettle();

    await tester.tap(find.text('즐겨찾기'));
    await tester.pump();
    expect(find.text('즐겨찾기에 추가했습니다.'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark), findsOneWidget);

    await tester.tap(find.text('즐겨찾기 해제'));
    await tester.pump();
    expect(find.text('즐겨찾기에서 삭제했습니다.'), findsOneWidget);
    expect(find.byIcon(Icons.bookmark_border), findsOneWidget);
    // Snackbar가 하단 버튼을 가리지 않아 바로 평점 버튼을 누를 수 있습니다.

    await tester.tap(find.text('평점 남기기'));
    await tester.pumpAndSettle();
    expect(find.byType(RatingDialog), findsOneWidget);
    expect(saveButton(tester).onPressed, isNull);

    // 네 번째 별의 오른쪽 끝을 눌러 4.0점을 선택합니다.
    final ratingBar = find.byType(RatingBar);
    final rect = tester.getRect(ratingBar);
    await tester.tapAt(Offset(rect.left + rect.width * 0.79, rect.center.dy));
    await tester.pump();
    expect(find.text('4.0점'), findsOneWidget);
    expect(saveButton(tester).onPressed, isNotNull);

    await tester.tap(find.text('다시 선택'));
    await tester.pump();
    expect(find.text('별을 눌러 평점을 선택해주세요'), findsOneWidget);
    expect(saveButton(tester).onPressed, isNull);

    await tester.tapAt(Offset(rect.left + rect.width * 0.79, rect.center.dy));
    await tester.pump();
    await tester.tap(find.text('저장'));
    await tester.pumpAndSettle();
    expect(find.byType(RatingDialog), findsNothing);
    expect(find.text('4.0점으로 평점을 남겼습니다.'), findsOneWidget);
    expect(find.text('내 평점 4.0점'), findsOneWidget);
  });

  testWidgets('NavigationBar 선택 상태와 화면이 일치한다', (tester) async {
    await pumpApp(tester, AppRouter.home);

    int selectedIndex() =>
        tester.widget<NavigationBar>(find.byType(NavigationBar)).selectedIndex;

    expect(selectedIndex(), 0);
    await tester.tap(find.text('마이'));
    await tester.pumpAndSettle();
    expect(selectedIndex(), 2);
    expect(find.text('내 프로필'), findsOneWidget);
    expect(currentPath(), AppRouter.myPage);

    // 홈의 전체보기는 영화 탭으로 전환합니다.
    await tester.tap(find.text('홈'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('전체보기'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('전체보기'));
    await tester.pumpAndSettle();
    expect(selectedIndex(), 1);
    expect(tester.takeException(), isNull);
  });
}
