import 'package:flutter/material.dart';
import 'package:flutter_news_app/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_news_app/services/aservice.dart';
import 'package:flutter_news_app/theme/constants.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AService>(
          create: (_) => AService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) => context.read<AService>().aServiceChanges),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: kBackgroundLight,
          appBarTheme: AppBarTheme(
            centerTitle: true,
            color: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: kIcons),
          ),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
