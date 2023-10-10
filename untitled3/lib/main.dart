import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'firebase_options.dart';

Future<void> signInSilently() async {
  /* Google OAuth と通信 */

  // あらかじめ登録しておいたクライアントID

  // アプリが知りたい情報
  const scopes = [
    'openid',
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  // Googleでサインイン の画面へ飛ばす
  final request = GoogleSignIn(scopes: scopes);
  final GoogleSignInAccount? response = await request.signIn();

  // 受け取ったデータの中からアクセストークンを取り出す
  final authn = await response!.authentication;
  final accessToken = authn.accessToken;
  final idToken = authn.idToken;
  debugPrint("ddd");
  debugPrint(accessToken.toString());
  debugPrint(idToken.toString());

  // アクセストークンが null だったら中止
  if (accessToken == null) {
    return;
  }

  /* Firebase と通信 */

  // Firebaseへアクセストークンを送る
  final oAuthCredential = GoogleAuthProvider.credential(
    accessToken: accessToken,
  );
  debugPrint(oAuthCredential.toString());
  await FirebaseAuth.instance.signInWithCredential(
    oAuthCredential,
  );
  final user = FirebaseAuth.instance.currentUser!;
  debugPrint(user.toString());
}

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SignInButton(
              Buttons.google,
              onPressed: () async {
                await signInSilently();
              },
            ),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
