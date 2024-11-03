import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home_provider.dart';
import '../../localization/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.translate('home_screen_title')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(appLocalizations.translate('counter_text')),
            Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                return Text(
                  '${homeProvider.counter}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<HomeProvider>().incrementCounter();
        },
        tooltip: appLocalizations.translate('increment_button'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
