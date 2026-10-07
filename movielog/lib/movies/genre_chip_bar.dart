import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

// Figma W3-02 영화 목록 상단의 장르 Chip 목록
class GenreChipBar extends StatelessWidget {
  const GenreChipBar({
    super.key,
    required this.genres,
    required this.selectedGenre,
    required this.onSelected,
  });

  final List<String> genres;
  final String selectedGenre;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
        itemCount: genres.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final genre = genres[index];
          final selected = genre == selectedGenre;

          return Center(
            child: ChoiceChip(
              label: Text(genre),
              selected: selected,
              onSelected: (_) => onSelected(genre),
              showCheckmark: false,
              shape: const StadiumBorder(),
              side: BorderSide.none,
              backgroundColor: AppColors.chipFill,
              selectedColor: AppColors.primary,
              labelStyle: AppTextStyles.bodySmall.copyWith(
                color: selected ? AppColors.white : AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }
}
