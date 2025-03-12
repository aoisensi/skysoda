import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skysoda/pod/preference_pod.dart';
import 'package:skysoda/widget/page/home_page.dart';
import 'package:skysoda/widget/page/login_page.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Riverpod Counter',
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          ref.watch(preferencesCredentialsPod).isNotEmpty
              ? const HomePage()
              : const LoginPage(),
    );
  }
}
