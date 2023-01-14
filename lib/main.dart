import 'package:flutter/material.dart';
import 'package:notifications/screens/home_screen.dart';
import 'package:notifications/screens/message_screen.dart';
import 'package:notifications/services/push_notifications_service.dart';

void main()async{

  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

    runApp( const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  final GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();

    // Context!
    PushNotificationService.messageStream.listen((message) {
      
      navigatorKey.currentState?.pushNamed('message', arguments: message);

      final snackBar = SnackBar(content: Text(message),);
      messengerKey.currentState?.showSnackBar(snackBar);

     });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'home',
      navigatorKey: navigatorKey,    // Navegar 
      scaffoldMessengerKey: messengerKey, //Snacks
      routes: {
        'home' : (_) => const HomeScreen(),
        'message' : (_) => const MessageScreen()
      },
    );
  }
}