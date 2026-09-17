import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF8F5),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 60),

                      const Text(
                        'FLUTTER 0주차',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.5,
                          color: Color(0xFF4A4A4A),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 60),

                      const Icon(
                        Icons.movie_outlined,
                        size: 72,
                        color: Colors.deepPurple,
                        semanticLabel: '영화 아이콘',
                      ),
                      const SizedBox(height: 70),

                      const Text(
                        '영화의 순간을\n기록하세요',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          color: Color(0xFF1A1A1A),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 12),

                      const Text(
                        '보고 싶은 영화부터 나만의 평점까지\n한곳에서 관리해요',
                        style: TextStyle(
                          fontSize: 15,
                          height: 1.4,
                          color: Color(0xFF555555),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const Spacer(),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            debugPrint('시작하기 버튼을 눌렀습니다.');
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F3689),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          child: const Text(
                            '시작하기',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
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
