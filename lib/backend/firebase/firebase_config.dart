import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyC9lduemygUWHmGX2Dr9qC2LoveDM_xxX8",
            authDomain: "nourrishare.firebaseapp.com",
            projectId: "nourrishare",
            storageBucket: "nourrishare.appspot.com",
            messagingSenderId: "416436349316",
            appId: "1:416436349316:web:23c2b629c5af0a5c0195d1",
            measurementId: "G-5M8MZRFKRV"));
  } else {
    await Firebase.initializeApp();
  }
}
