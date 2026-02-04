import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/app.dart';
import 'core/env.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (AppEnv.isConfigured) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: AppEnv.firebaseApiKey,
        appId: AppEnv.firebaseAppId,
        messagingSenderId: AppEnv.firebaseMessagingSenderId,
        projectId: AppEnv.firebaseProjectId,
        authDomain: AppEnv.firebaseAuthDomain.isEmpty ? null : AppEnv.firebaseAuthDomain,
        storageBucket:
            AppEnv.firebaseStorageBucket.isEmpty ? null : AppEnv.firebaseStorageBucket,
      ),
    );
  }
  runApp(const ProviderScope(child: ResumeApp()));
}
