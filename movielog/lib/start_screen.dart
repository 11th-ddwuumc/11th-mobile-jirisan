import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'theme/app_colors.dart';
import 'theme/app_spacing.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: AppSpacing.xxl),

                      Text(
                        'FLUTTER 0주차',
                        style: textTheme.bodySmall?.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      SvgPicture.asset(
                        'assets/logos/movielog_logo.svg',
                        width: 72,
                        height: 72,
                        semanticsLabel: 'MovieLog 로고',
                      ),
                      const SizedBox(height: AppSpacing.xxl),

                      Text(
                        '영화의 순간을\n기록하세요',
                        style: textTheme.titleLarge?.copyWith(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.sm),

                      Text(
                        '보고 싶은 영화부터 나만의 평점까지\n한곳에서 관리해요',
                        style: textTheme.bodyMedium?.copyWith(
                          fontSize: 15,
                          height: 1.4,
                          color: AppColors.gray,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        height: AppSpacing.unit * 7, // 56
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('시작하기 버튼을 눌렀습니다.');
                          },
                          child: const Text(
                            '시작하기',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
