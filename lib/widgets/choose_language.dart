import 'package:datawiseai/localization/app_localizations.dart';
import 'package:datawiseai/utils/app_constants.dart';
import 'package:flutter/material.dart';

class ChooseLanguage extends StatelessWidget {
  final Function(Locale) onLanguageSelected;

  const ChooseLanguage({
    super.key,
    required this.onLanguageSelected,
  });

  @override
  Widget build(BuildContext context) {
    var appLocalizations = AppLocalizations.of(context)!;

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: SizedBox(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLocalizations.translate('choose_language'),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        itemCount: AppConstants.supportedLanguages.length,
                        itemBuilder: (context, index) {
                          final language =
                              AppConstants.supportedLanguages[index];
                          final locale = AppConstants.supportedLocales[index];
                          return ListTile(
                            title: Text(language),
                            onTap: () {
                              onLanguageSelected(locale);
                              Navigator.pop(context);
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.transparent),
        ),
        child: Row(
          children: [
            const Icon(Icons.language, color: Colors.black),
            const SizedBox(width: 8),
            Text(
              AppLocalizations.getCurrentLocaleName(context),
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
