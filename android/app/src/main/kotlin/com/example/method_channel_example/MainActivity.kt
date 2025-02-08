package com.example.method_channel_example

// Android için gerekli import'lar
import android.util.Log
import androidx.annotation.NonNull

// Flutter için gerekli import'lar
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    // Kanal adının tam olarak aynı olduğundan emin olun
    private val CHANNEL = "com.method_channel_example/theme"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { 
            call, result ->
            when (call.method) {
                "changeTheme" -> {
                    // Gelen argümanı kontrol et
                    val mod = call.arguments as? String ?: "light"
                    
                    // Debug için log ekle
                    Log.d("ThemeChannel", "Tema değişikliği isteği: $mod")
                    
                    // Tema değişikliği
                    when (mod) {
                        "dark" -> {
                            // Anlık olarak dark mode'a geç
                            result.success("dark")
                        }
                        "light" -> {
                            // Anlık olarak light mode'a geç
                            result.success("light")
                        }
                        else -> {
                            result.error("INVALID_MODE", "Geçersiz mod: $mod", null)
                        }
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
}