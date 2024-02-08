import 'package:app_chat_proxy/dev/logger.dart';
import 'package:app_chat_proxy/utils/l10n_ext.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di.dart';

// DropdownMenuEntry labels and values for the first dropdown menu.
enum LanguageLabel {
  vi('🇻🇳', Locale('vi', 'VN'), 'VietNam'),
  en('🇬🇧', Locale('en', 'EN'), 'England');

  final String label;
  final Locale locale;
  final String countryName;
  const LanguageLabel(this.label, this.locale, this.countryName);
}

@RoutePage()
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final TextEditingController localeNameController = TextEditingController();
  LanguageLabel? languageLabel;
  @override
  Widget build(BuildContext context) {
    final userReferences = ref.watch(userReferencesNotifierProvider);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(context.appLocalizations(ref).switchThemeMode),
          ),
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              return Switch(
                value: userReferences.isDarkMode ?? false,
                onChanged: (value) async {
                  ref
                      .read(userReferencesNotifierProvider.notifier)
                      .setUserReferMode(value);
                },
              );
            },
          ),
          const SizedBox(
            height: 8,
          ),
          DropdownMenu<LanguageLabel>(
            initialSelection: LanguageLabel.en,
            controller: localeNameController,
            trailingIcon: Text(context.appLocalizations(ref).localeName),
            requestFocusOnTap: false,
            label: Text(context.appLocalizations(ref).defaultLanguage),
            onSelected: (LanguageLabel? label) async {
              logger.w(label);
              setState(() {
                languageLabel = label;
                if (languageLabel != null) {
                  ref
                      .read(userReferencesNotifierProvider.notifier)
                      .setLocale(languageLabel!.locale);
                }
              });
            },
            dropdownMenuEntries: LanguageLabel.values
                .map<DropdownMenuEntry<LanguageLabel>>(
                    (LanguageLabel languageLabel) {
              return DropdownMenuEntry<LanguageLabel>(
                  value: languageLabel,
                  label: languageLabel.label,
                  enabled: languageLabel.label != '',
                  trailingIcon: Text(languageLabel.countryName));
            }).toList(),
          ),
        ],
      ),
    );
  }
}
