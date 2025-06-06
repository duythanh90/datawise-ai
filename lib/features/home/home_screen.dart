import 'package:datawiseai/features/home/tabs/create/create_tab.dart';
import 'package:datawiseai/features/home/tabs/explore/explore_tab.dart';
import 'package:datawiseai/features/home/tabs/insights/insights_tab.dart';
import 'package:datawiseai/features/home/tabs/profile/profile_tab.dart';
import 'package:datawiseai/features/home/components/custom_bottom_nav.dart';
import 'package:flutter/material.dart';
import '../../localization/app_localizations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    ExploreTab(),
    CreateTab(),
    InsightsTab(),
    ProfileTab(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;

    final tabItems = [
      {
        'icon': Icons.explore,
        'label': appLocalizations.translate('tab_explore'),
      },
      {
        'icon': Icons.create,
        'label': appLocalizations.translate('tab_create'),
      },
      {
        'icon': Icons.insights,
        'label': appLocalizations.translate('tab_insights'),
      },
      {
        'icon': Icons.person,
        'label': appLocalizations.translate('tab_profile'),
      },
    ];

    return Scaffold(
      // 🔥 Remove white background to let dark/tab content show behind
      backgroundColor: Colors.transparent,
      body: SafeArea(
        top: true,
        bottom: false, // Prevents double padding with floating nav
        child: Container(
          color: const Color(0xFF121212), // Matches bottom nav vibe
          child: Column(
            children: [
              Expanded(
                child: _pages[_selectedIndex],
              ),
              CustomBottomNav(
                selectedIndex: _selectedIndex,
                tabItems: tabItems,
                onTabSelected: _onItemTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
