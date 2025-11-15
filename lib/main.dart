import 'package:flutter/material.dart';
import 'app_router.dart';
import 'constants/strings.dart';

void main() {
  runApp(BlocTrainning(router: AppRouter()));
}

class BlocTrainning extends StatelessWidget {
  const BlocTrainning({super.key, required this.router});
  final AppRouter router;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: characterScreen,
      onGenerateRoute: router.generateRoute,
    );
  }
}
