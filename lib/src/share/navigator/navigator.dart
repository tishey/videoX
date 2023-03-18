
 import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

  void dismissKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

class VxNavigator {
  VxNavigator._();

 static VxNavigator instance = VxNavigator._();
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();


 

  static navigateToRoute(dynamic routeClass) {
    Navigator.push(navigatorKey!.currentContext!,
        CupertinoPageRoute(builder: (context) => routeClass));
  }

  static void navigateAndRemoveUntilRoute(dynamic routeClass) {
    Navigator.pushAndRemoveUntil(navigatorKey!.currentContext!,
        CupertinoPageRoute(builder: (context) => routeClass), (route) => false);
  }



   static  displayBottomSheet(context, Widget bottomSheet) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0))),
        builder: (context) => Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Wrap(
              children: [
                Center(
                  child: dividerModelSheet(),
                ),
                GestureDetector(onTap: dismissKeyboard, child: bottomSheet),
              ],
            )));
  }

  static Widget dividerModelSheet() {
    return Container(
      width: 47,
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.grey.withOpacity(0.4)),
    );
  }
}