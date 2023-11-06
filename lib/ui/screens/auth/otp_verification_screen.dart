import 'dart:async';
import 'package:assignment16/presentation/state_holders/auth_controller.dart';
import 'package:assignment16/presentation/state_holders/email_verification_controller.dart';
import 'package:assignment16/presentation/state_holders/otp_verification_controller.dart';
import 'package:assignment16/presentation/state_holders/read_profile_controller.dart';
import 'package:assignment16/ui/%20utility/color_palettes.dart';
import 'package:assignment16/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../ utility/image_assets.dart';
import '../../ utility/show_snackbar.dart';
import 'complete_profile_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;

  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpController = TextEditingController();
  final _otpVerificationFormKey = GlobalKey<FormState>();

  int _secondsRemaining = 120;
  late Timer _timer;
  bool _isElevatedButtonEnable = true;
  bool _isTextButtonEnable = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _isElevatedButtonEnable = true;
    _isTextButtonEnable = false;
    setState(() {});
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_secondsRemaining == 0) {
          _timer.cancel();
          _isElevatedButtonEnable = false;
          _isTextButtonEnable = true;
          setState(() {});
          // Perform any necessary action when timer completes
        } else {
          setState(() {
            _secondsRemaining--;
          });
        }
      },
    );
  }

  Future<void> resendOTP() async {
    _secondsRemaining = 120;
    _startTimer();
    setState(() {});
    // Enter hare your API Code to resend the OTP on your Mobile number.
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _otpVerificationFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 150,
                ),
                Center(
                  child: SvgPicture.asset(
                    ImageAssets.craftyBayLogoSVG,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "Enter OTP Code",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                RichText(text: TextSpan(
                  children: [
                    const TextSpan(
                        text: "Enter verification code sent to ",
                        style: TextStyle(color: Colors.grey,
                        )),
                    TextSpan(
                        text: widget.email,
                        style: const TextStyle(
                            color: Colors.grey,
                         fontWeight: FontWeight.bold))
                  ]
                )),
                const SizedBox(
                  height: 16,
                ),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty || value.length < 4){
                      return 'Required field is empty';
                    }
                    return null;
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    activeColor: AppColors.primaryColor,
                    inactiveColor: AppColors.primaryColor,
                    selectedColor: Colors.green,
                  ),
                  controller: _otpController,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onCompleted: (v) {},
                  onChanged: (value) {
                  },
                  beforeTextPaste: (text) {
                    return true;
                  },
                  appContext: context,
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<OtpVerificationController>(
                      builder: (controller) {
                    if (controller.otpVerificationInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: _isElevatedButtonEnable
                        ? () async {
                              if (_otpVerificationFormKey.currentState!.validate()) {
                                final response = await controller.verifyOtp(
                                    widget.email, _otpController.text.trim());
                                if (response) {
                                  Get.find<ReadProfileController>().readProfile().then((value){
                                    if (value == true) {
                                      AuthController.saveUserInfo(AuthController.userProfile);
                                      if (mounted) {
                                        showSnackBar(
                                            "OTP verification successful",
                                            context, Colors.green[500], true);
                                        Get.offAll(() => const MainBottomNavScreen());
                                      }
                                    }else{
                                      Get.offAll(() => const CompleteProfileScreen());
                                    }
                                  });

                                } else {
                                  if (mounted) {
                                    showSnackBar("OTP verification failed",
                                        context, Colors.red[500], false);
                                  }
                                }
                              }
                            }
                        : null,
                      child: const Text("Next",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    );
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                RichText(
                  text: TextSpan(children: [
                    const TextSpan(
                        text: "This code will expire in ",
                        style: TextStyle(color: Colors.grey)),
                    TextSpan(
                        text: "${_secondsRemaining}s",
                        style: const TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold))
                  ]),
                ),
                GetBuilder<EmailVerificationController>(builder: (controller) {
                  return TextButton(
                    onPressed: _isTextButtonEnable
                        ? () async {
                            final response = await controller.verifyEmail(widget.email);
                            if (response) {
                              _otpController.clear();
                              if (mounted) {
                                showSnackBar("OTP resend successfully", context, Colors.green[500], true);
                                resendOTP();
                              } else {
                                if (mounted) {
                                  showSnackBar("OTP resend failed", context, Colors.red[500], false);
                                }
                              }
                            }
                          }
                        : null,
                    child: const Text(
                      "Resend Code",
                      style: TextStyle(color: Colors.grey,
                      fontWeight: FontWeight.w700,
                      fontSize: 16),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      )),
    );
  }
}
