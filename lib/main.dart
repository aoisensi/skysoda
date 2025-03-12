import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widget/app.dart';
import 'pod/preference_pod.dart';

void main() async {
  final sp = await SharedPreferencesWithCache.create(
    cacheOptions: const SharedPreferencesWithCacheOptions(),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesPod.overrideWithValue(sp)],
      child: const App(),
    ),
  );
}
