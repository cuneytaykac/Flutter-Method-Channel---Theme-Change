import 'package:flutter/material.dart';
import 'package:method_channel_example/manager/theme_manager.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeManager.instance.getThemeData(),
      home: ThemeListenerWidget(),
    );
  }
}

class ThemeListenerWidget extends StatefulWidget {
  const ThemeListenerWidget({super.key});

  @override
  _ThemeListenerWidgetState createState() => _ThemeListenerWidgetState();
}

class _ThemeListenerWidgetState extends State<ThemeListenerWidget> {
  // ThemeManager'ın mevcut tema durumunu takip et
  ThemeMode _currentTheme = ThemeManager.instance.currentThemeMode;

  @override
  void initState() {
    super.initState();
    // ThemeManager'ın tema değişikliklerini dinle
    _listenToThemeChanges();
  }

  void _listenToThemeChanges() {
    // Tema değişikliği olduğunda state'i güncelle
    ThemeManager.instance.addListener(() {
      setState(() {
        _currentTheme = ThemeManager.instance.currentThemeMode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tema Dinleyicisi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Anlık tema bilgisini göster
            Text(
              'Şu anki tema: ${_currentTheme.name}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            // Tema değiştirme butonu
            ElevatedButton(
              onPressed: () {
                ThemeManager.instance.toggleTheme();
              },
              child: Text('Temayı Değiştir'),
            ),
            SizedBox(height: 20),
            // Tema durumuna göre farklı widget gösterimi
            AnimatedContainer(
              duration: Duration(milliseconds: 300),
              color: _currentTheme == ThemeMode.light
                  ? Colors.blue.shade100
                  : Colors.grey.shade900,
              padding: EdgeInsets.all(20),
              child: Text(
                'Dinamik Tema Örneği',
                style: TextStyle(
                  color: _currentTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
