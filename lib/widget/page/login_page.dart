import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../../pod/atproto/atproto_session_pod.dart';
import '../../pod/preference_pod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final handle = useState('');
    final password = useState('');
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'handle',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => handle.value = value,
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(
                labelText: 'app password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) => password.value = value,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await ref.read(
                  atprotoSessionPod((handle.value, password.value, '')).future,
                );
                ref
                    .read(preferencesCredentialsPod.notifier)
                    .add('${handle.value}\$${password.value}');
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
