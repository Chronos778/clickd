import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    return const FirebaseOptions(
      apiKey: "PLACEHOLDER_API_KEY",
      appId: "PLACEHOLDER_APP_ID",
      messagingSenderId: "PLACEHOLDER_SENDER_ID",
      projectId: "PLACEHOLDER_PROJECT_ID",
      storageBucket: "PLACEHOLDER_PROJECT_ID.appspot.com",
    );
  }
}
