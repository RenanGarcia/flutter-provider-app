import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providertest/src/services/client_http.dart';

import 'controllers/auth_controller.dart';
import 'screens/splash_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => ClientHttp()),
        ChangeNotifierProvider(
          create: (context) => AuthController(context.read<ClientHttp>()),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const SplashScreen(),
          '/auth': (_) => const AuthScreen(),
          '/home': (_) => const HomeScreen(),
        },
      ),
    );
  }
}
