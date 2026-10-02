import 'package:flutter/material.dart';

import '../data/movie.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// 영화 목록의 장르 필터 BottomSheet
// Checkbox를 바꾸는 동안에는 Sheet 내부 상태만 바뀌고,
// 확인 버튼을 눌렀을 때 선택한 장르를 반환합니다.
class GenreFilterSheet extends StatefulWidget {
  const GenreFilterSheet({super.key, required this.initialGenres});

  final Set<String> initialGenres;

  @override
  State<GenreFilterSheet> createState() => _GenreFilterSheetState();
}

class _GenreFilterSheetState extends State<GenreFilterSheet> {
  late final Set<String> _selectedGenres = {...widget.initialGenres};

  void _toggle(String genre, bool selected) {
    setState(() {
      if (selected) {
        _selectedGenres.add(genre);
      } else {
        _selectedGenres.remove(genre);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                children: [
                  const Expanded(
                    child: Text('장르 선택', style: AppTextStyles.titleLarge),
                  ),
                  TextButton(
                    onPressed: _selectedGenres.isEmpty
                        ? null
                        : () => setState(_selectedGenres.clear),
                    child: const Text('선택 해제'),
                  ),
                ],
              ),
            ),
            // 목록 영역만 스크롤되도록 Expanded 안에 ListView를 둡니다.
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: genres.length,
                itemBuilder: (context, index) {
                  final genre = genres[index];
                  return CheckboxListTile(
                    value: _selectedGenres.contains(genre),
                    onChanged: (checked) => _toggle(genre, checked ?? false),
                    title: Text(genre, style: AppTextStyles.bodyMedium),
                    controlAffinity: ListTileControlAffinity.leading,
                    activeColor: AppColors.primary,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                  );
                },
              ),
            ),
            // 확인 버튼은 스크롤 영역 밖에 두어 항상 하단에 고정합니다.
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: SizedBox(
                height: AppSpacing.unit * 7, // 56
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context, _selectedGenres),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  child: Text(
                    _selectedGenres.isEmpty
                        ? '확인 (전체 보기)'
                        : '확인 (${_selectedGenres.length}개 장르)',
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
