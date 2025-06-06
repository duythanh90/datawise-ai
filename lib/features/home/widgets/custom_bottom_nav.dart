import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datawiseai/widgets/gradient_text.dart';
import 'package:provider/provider.dart';
import 'package:datawiseai/features/home/notifications/notifications_provider.dart';

typedef OnTabSelected = void Function(int index);

class CustomBottomNav extends StatefulWidget {
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
  State<CustomBottomNav> createState() => _CustomBottomNavState();
}

class _CustomBottomNavState extends State<CustomBottomNav>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0, 2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasUnread =
        context.watch<NotificationsProvider?>()?.hasUnread ?? false;

    return SafeArea(
      top: false,
      bottom: true,
      child: SlideTransition(
        position: _offsetAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 16, right: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(widget.tabItems.length, (index) {
                    final isSelected = widget.selectedIndex == index;
                    final icon = widget.tabItems[index]['icon'] as IconData;
                    final label = widget.tabItems[index]['label'] as String;
                    final isNotificationTab =
                        label.toLowerCase().contains('notification');

                    return GestureDetector(
                      onTap: () {
                        if (!isSelected) {
                          HapticFeedback.lightImpact();
                          widget.onTabSelected(index);
                        }
                      },
                      child: AnimatedScale(
                        scale: isSelected ? 1.1 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutBack,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeInOut,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 6),
                          constraints: BoxConstraints(
                            minWidth: MediaQuery.of(context).size.width * 0.18,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Colors.white.withOpacity(0.08)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                children: [
                                  Icon(
                                    icon,
                                    color:
                                        isSelected ? Colors.white : Colors.grey,
                                  ),
                                  if (isNotificationTab && hasUnread)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: TweenAnimationBuilder<double>(
                                        tween: Tween(begin: 1.0, end: 1.4),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                        curve: Curves.easeInOut,
                                        builder: (context, scale, child) {
                                          return Transform.scale(
                                            scale: scale,
                                            child: Container(
                                              width: 8,
                                              height: 8,
                                              decoration: BoxDecoration(
                                                color:
                                                    Colors.red.withOpacity(0.9),
                                                shape: BoxShape.circle,
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.red
                                                        .withOpacity(0.6),
                                                    blurRadius: 6,
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
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
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
