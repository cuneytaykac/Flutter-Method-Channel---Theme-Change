import 'package:flutter/material.dart';
import 'package:method_channel_example/manager/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.instance.getThemeData(),
      home: const ThemeChangePage(),
    );
  }
}

class ThemeChangePage extends StatefulWidget {
  const ThemeChangePage({super.key});

  @override
  State<ThemeChangePage> createState() => _ThemeChangePageState();
}

class _ThemeChangePageState extends State<ThemeChangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tema Değişikliği'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Şu anki tema: ${ThemeManager.instance.currentThemeMode == ThemeMode.dark ? 'Dark' : 'Light'}',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tema değişikliği
                ThemeManager.instance.toggleTheme();

                // Widget'ı yeniden inşa et
                setState(() {});

                // Tüm uygulamada tema değişikliğini yeniden inşa et
                (context.findAncestorStateOfType<_MyAppState>() as _MyAppState)
                    .setState(() {});
              },
              child: const Text('Temayı Değiştir'),
            ),
          ],
        ),
      ),
    );
  }
}
