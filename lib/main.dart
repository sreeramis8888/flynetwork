import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flynetwork/src/data/services/navigation_service.dart';
import 'package:flynetwork/src/data/services/snackbar_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flynetwork/src/data/router/router.dart' as router;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); 

  runApp( ProviderScope(child: MyApp()));
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: SnackbarService.scaffoldMessengerKey,
      onGenerateRoute: router.generateRoute,
      initialRoute: 'Splash',
      title: 'FlyNetwork',
      theme: ThemeData(textTheme: GoogleFonts.poppinsTextTheme(),
   
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
    );
  }
}


// FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// // Initialize in your main function
// void initializeNotifications() {
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/ic_launcher');
// const iosInitializationSetting = DarwinInitializationSettings();
// const initSettings = InitializationSettings(android: initializationSettingsAndroid, iOS: iosInitializationSetting);

//   flutterLocalNotificationsPlugin.initialize(initSettings);
// }
