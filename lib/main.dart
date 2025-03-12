import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skysoda/widget/app.dart';
import 'package:skysoda/pod/preference_pod.dart';

void main() async {
  final sp = await SharedPreferencesWithCache.create(
    cacheOptions: SharedPreferencesWithCacheOptions(),
  );

  runApp(
    ProviderScope(
      overrides: [sharedPreferencesPod.overrideWithValue(sp)],
      child: App(),
    ),
  );
}
