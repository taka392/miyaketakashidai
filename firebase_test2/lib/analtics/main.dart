// Firebase アナリティクスを使うコード 1
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_test2/firebase_options.dart';
// Firebase を使う時に必要なコード 1
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebaseが初期化されていない場合のみ初期化を行う
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  for (var e in Firebase.apps) {
    debugPrint(e.options.projectId);
  }

  const app = MyApp();
  runApp(app);
}

/// アプリ本体
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

/// ホーム画面
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 画面
    return Scaffold(
      body: Center(
        // ボタン
        child: ElevatedButton(
          // 押されたとき
          onPressed: () {
            // Firebase アナリティクスを使うコード 2
            FirebaseAnalytics.instance.logEvent(
              name: 'ボタンが押されました',
            );
          },
          child: const Text('ボタン'),
        ),
      ),
    );
  }
}
