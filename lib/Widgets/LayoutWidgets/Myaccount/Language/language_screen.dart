import 'package:flutter/material.dart';
import 'package:cinemax/generated/l10n.dart';

class TestLocalizationScreen extends StatelessWidget {
  const TestLocalizationScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).appTitle)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).welcomeMessage),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
               // localeProvider.setLocale(const Locale('en')); // Switch to English
              },
              child: const Text("Switch to English"),
            ),
            ElevatedButton(
              onPressed: () {
                //localeProvider.setLocale(const Locale('ar')); // Switch to Arabic
              },
              child: const Text("التبديل إلى العربية"),
            ),
          ],
        ),
      ),
    );
  }
}
