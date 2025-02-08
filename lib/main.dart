import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
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
  String _mode = "light";
  static const platform = MethodChannel('com.method_channel_example/theme');

  Future<void> _changeTheme() async {
    // Eğer şu anki mod "light" ise "dark", "dark" ise "light" olarak değişecek
    String newThemeMode = _mode == "light" ? "dark" : "light";

    // Debug için geçerli mod bilgisini logla
    log('Mevcut mod: $_mode');
    log('Yeni mod: $newThemeMode');

    try {
      // Method channel üzerinden tema değişikliği isteği gönder
      final result = await platform.invokeMethod('changeTheme', newThemeMode);

      // Gelen sonucu logla
      log('Native taraftan gelen sonuç: $result');

      // State'i güncelle
      setState(() {
        _mode = result;
      });
    } on PlatformException catch (e) {
      // Herhangi bir hata durumunda konsola hata mesajını yazdır
      print('Tema değişikliği hatası: ${e.message}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Tema moduna göre tema ayarla
      theme: _mode == 'light'
          ? ThemeData.light().copyWith(
              scaffoldBackgroundColor: Colors.blue,
              appBarTheme: const AppBarTheme(color: Colors.blue),
            )
          : ThemeData.dark().copyWith(
              scaffoldBackgroundColor: Colors.red,
              appBarTheme: const AppBarTheme(color: Colors.red),
            ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Theme Change Example'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Şu anki tema: ${_mode == 'dark' ? 'Dark Mode' : 'Light Mode'}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _changeTheme,
                child: const Text('Temayı Değiştir'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
