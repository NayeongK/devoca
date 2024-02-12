import "package:devoca/screen/main_screen.dart";
import "package:flutter/material.dart";
import "package:devoca/screen/splash_screen.dart";
import "package:devoca/provider/model_vocabulary_provider.dart";
import "package:devoca/provider/answer_status_provider.dart";
import "package:firebase_core/firebase_core.dart";
import "package:provider/provider.dart";
import "firebase_options.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VocabularyListProvider()..getSnapshot()),
        ChangeNotifierProvider(create: (_) => AnswerStatusProvider()),
      ],
      child: MaterialApp(
        home: FutureBuilder<Object>(
          future: Future.delayed(const Duration(seconds: 1), () => 100),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            } else if (snapshot.hasData) {
              return const MainScreen();
            } else {
              return const SplashScreen();
            }
          },
        ),
      ),
    );
  }
}
