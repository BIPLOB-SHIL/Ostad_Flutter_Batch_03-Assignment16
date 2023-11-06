import 'dart:async';
import 'dart:developer';
import 'package:assignment16/application/state_holder_binder.dart';
import 'package:assignment16/ui/%20utility/color_palettes.dart';
import 'package:assignment16/ui/%20utility/image_assets.dart';
import 'package:assignment16/ui/screens/splash_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../presentation/state_holders/theme_manager_controller.dart';

class CraftyBay extends StatefulWidget {
  static GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

  const CraftyBay({super.key});

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {

 late StreamSubscription _streamSubscription;
 bool isDeviceConnected = false;

 ThemeMode _themeMode = ThemeMode.system;


 @override
  void initState() {
   initialConnectivity();
   checkConnectivityStatus();
   ThemeManager.getThemeMode().then((themeMode) {
     if (themeMode == ThemeMode.system) {
       ThemeManager.setThemeMode(ThemeMode.light);
     }
     _themeMode = themeMode;
   });

    super.initState();
    }

  void initialConnectivity() async{
    final result = await Connectivity().checkConnectivity();
    connectivityHandler(result);
  }


  void checkConnectivityStatus(){
    _streamSubscription = Connectivity().onConnectivityChanged.listen((status) {
          connectivityHandler(status);
    });

  }

  void connectivityHandler(ConnectivityResult status){
      if(status != ConnectivityResult.mobile && status != ConnectivityResult.wifi){
        Get.dialog(
          barrierDismissible: false,
          useSafeArea: true,
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Material(
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Image(image: AssetImage(ImageAssets.noInternetPNG,),
                        width: 50),
                        Text(
                          "No Internet",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Please check your connection status and try again.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
        log("Not Connected");
      }else{
        Get.back(closeOverlays: true);
        log("Connected");
      }
  }


 @override
 dispose() {
   _streamSubscription.cancel();
   super.dispose();
 }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: CraftyBay.globalKey,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      initialBinding: StateHolderBinder(),
      themeMode: _themeMode,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.light,
          )
        ),
        primarySwatch:
            MaterialColor(AppColors.primaryColor.value, AppColors().color),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 12),
                textStyle: const TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.w600),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)))),
        inputDecorationTheme: const InputDecorationTheme(
          contentPadding: EdgeInsets.symmetric(horizontal: 16),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
      darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch:
          MaterialColor(AppColors.primaryColor.value, AppColors().color),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 12),
              textStyle: const TextStyle(
                  fontSize: 16,
                  letterSpacing: 0.5,
                  fontWeight: FontWeight.w600),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          )),
    );
  }


}



