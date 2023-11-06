import 'package:assignment16/data/models/read_profile_model.dart';
import 'package:assignment16/presentation/state_holders/auth_controller.dart';
import 'package:assignment16/ui/%20utility/image_assets.dart';
import 'package:assignment16/ui/screens/auth/complete_profile_screen.dart';
import 'package:assignment16/ui/screens/auth/email_verification_screen.dart';
import 'package:assignment16/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    goToNextScreen();
    super.initState();
  }


  Future<void> goToNextScreen() async {
    await AuthController.getAccessToken();
    final bool isProfileCompleted = await AuthController.checkIfUserLoggedIn();

    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (isProfileCompleted){
        Get.off(()=> const MainBottomNavScreen());
      }else {
        Get.offAll(() =>
        AuthController.isLoggedIn ?
        const CompleteProfileScreen() :
        const EmailVerificationScreen());
      }
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          Center(child: SvgPicture.asset(ImageAssets.craftyBayLogoSVG,width: 100,),),
          const Spacer(),
          const CircularProgressIndicator(),
          const SizedBox(height: 16,),
          const Text("Version 1.0.0"),
          const SizedBox(height: 16,),
        ],
      ),
    );
  }
}
