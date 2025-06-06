import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datawiseai/widgets/gradient_text.dart';

typedef OnTabSelected = void Function(int index);

class CustomBottomNav extends StatelessWidget {
  final int selectedIndex;
  final List<Map<String, dynamic>> tabItems;
  final OnTabSelected onTabSelected;

  const CustomBottomNav({
    super.key,
    required this.selectedIndex,
    required this.tabItems,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabItems.length, (index) {
          final isSelected = selectedIndex == index;
          final icon = tabItems[index]['icon'] as IconData;
          final label = tabItems[index]['label'] as String;

          return GestureDetector(
            onTap: () {
              if (selectedIndex != index) {
                HapticFeedback.lightImpact();
                onTabSelected(index);
              }
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withOpacity(0.05)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: isSelected ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      icon,
                      color: isSelected ? Colors.white : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: isSelected
                        ? GradientText(
                            label,
                            key: ValueKey(label),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            label,
                            key: ValueKey('$label-unselected'),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
