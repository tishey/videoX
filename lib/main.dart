import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:video_x/firebase_options.dart';
import 'package:video_x/provider_locator.dart';
import 'package:video_x/src/features/auth/phone_auth.dart';
import 'package:video_x/src/share/navigator/navigator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
     SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ScreenUtilInit(builder: (context, child){
      return MultiProvider(providers: allProviders,
      builder: (context, child){
        return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      navigatorKey: VxNavigator.navigatorKey,
      scaffoldMessengerKey: VxNavigator.scaffoldMessengerKey,
      theme: ThemeData(fontFamily: 'Geometria'),
      home: const SplashView(),
    );
      },
      );
    });
  }
}

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}
class _SplashViewState extends State<SplashView> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
      Timer(
    Duration(seconds: 5), (){
      VxNavigator.navigateAndRemoveUntilRoute(
        AuthView()
      );
    }
  );
  }
  @override
  Widget build(BuildContext context) {
     final String image = 'assets/images/videoX.png';
    return Scaffold(
      body: Center(
        child: Image.asset(image, width: 130.sp,)
      ),
       );
  }
}
