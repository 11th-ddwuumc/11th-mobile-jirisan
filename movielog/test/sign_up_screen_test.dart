import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:movielog/sign_up/sign_up_screen.dart';
import 'package:movielog/theme/app_theme.dart';

void main() {
  Future<void> pumpSignUp(
    WidgetTester tester, {
    Size size = const Size(390, 844),
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(theme: AppTheme.light, home: const SignUpScreen()),
    );
  }

  ElevatedButton signUpButton(WidgetTester tester) => tester
      .widget<ElevatedButton>(find.widgetWithText(ElevatedButton, '가입하기'));

  testWidgets('입력 전에는 가입 버튼이 비활성화된다', (tester) async {
    await pumpSignUp(tester);

    expect(find.text('회원가입'), findsOneWidget);
    expect(signUpButton(tester).onPressed, isNull);
  });

  testWidgets('잘못된 입력이면 한국어 오류 메시지를 표시한다', (tester) async {
    await pumpSignUp(tester);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), 'a');
    await tester.enterText(fields.at(1), 'test@');
    await tester.enterText(fields.at(2), '123');
    await tester.pump();

    expect(find.text('닉네임은 2자 이상이어야 합니다.'), findsOneWidget);
    expect(find.text('올바른 이메일 형식이 아닙니다.'), findsOneWidget);
    expect(find.text('비밀번호는 8자 이상이어야 합니다.'), findsOneWidget);
    expect(signUpButton(tester).onPressed, isNull);
  });

  testWidgets('모든 입력이 유효하고 약관에 동의하면 버튼이 활성화된다', (tester) async {
    await pumpSignUp(tester);

    final fields = find.byType(TextFormField);
    await tester.enterText(fields.at(0), '무비러버');
    await tester.enterText(fields.at(1), 'movie@example.com');
    await tester.enterText(fields.at(2), 'password1234');
    await tester.pump();
    expect(signUpButton(tester).onPressed, isNull);

    await tester.tap(find.byType(Checkbox));
    await tester.pump();
    expect(signUpButton(tester).onPressed, isNotNull);

    await tester.tap(find.text('가입하기'));
    await tester.pump();
    expect(tester.takeException(), isNull);
  });

  testWidgets('키보드가 열려도 Overflow가 발생하지 않는다', (tester) async {
    await pumpSignUp(tester);
    tester.view.viewInsets = const FakeViewPadding(bottom: 336);
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  testWidgets('넓은 화면에서는 Form 최대 너비가 560이다', (tester) async {
    await pumpSignUp(tester, size: const Size(1280, 1194));

    final formWidth = tester.getSize(find.byType(Form)).width;
    expect(formWidth, lessThanOrEqualTo(560));
    expect(tester.takeException(), isNull);
  });
}
