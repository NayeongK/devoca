import "package:flutter/material.dart";
import "package:devoca/screen/splash_screen.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: Future.delayed(const Duration(seconds: 1), () => 100),
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 700),
            child:
            MaterialApp(
              home: _splashLoadingWidget(snapshot))
          );
        });
  }

  Widget _splashLoadingWidget(AsyncSnapshot<Object> snapshot) {
    if (snapshot.hasError) {
      return const Text("Error");
    } else if (snapshot.hasData) {
      return Container();
    } else {
      return const SplashScreen();
    }
  }
}
