

// SHA1: B0:09:A9:0C:CE:C4:EE:6F:78:7F:12:43:A2:98:D4:2E:97:02:69:2B

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static  StreamController<String> _messageStream = StreamController.broadcast();
  static Stream<String> get messageStream => _messageStream.stream;


  static Future _backgroundHandler(RemoteMessage message) async{

    // print('onBackground Handler ${message.messageId}');
     print(message.data);
    _messageStream.sink.add(message.data['product'] ?? 'No data');

  }
  
  static Future _onMessageHandler(RemoteMessage message) async{

    // print('onMessage Handler ${message.messageId}');
    print(message.data);
    _messageStream.sink.add(message.data['product'] ?? 'No data');


  }
  
  static Future _onMessageOpenApp(RemoteMessage message) async{

    // print('onMesssageOpenApp Handler ${message.messageId}');
     print(message.data);
    _messageStream.sink.add(message.data['product'] ?? 'No data');


  }


  static Future initializeApp()async{

    // Push notifications
    await Firebase.initializeApp();
    token = await FirebaseMessaging.instance.getToken();
    print('Token: $token');

    //Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);


    // Local notifications 
  }

  static closeStream() {
    _messageStream.close();
  }

}