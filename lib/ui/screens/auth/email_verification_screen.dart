import 'package:assignment16/presentation/state_holders/email_verification_controller.dart';
import 'package:assignment16/ui/screens/auth/otp_verification_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

import '../../ utility/image_assets.dart';
import '../../ utility/show_snackbar.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailAddressController = TextEditingController();
  final _emailVerificationFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _emailVerificationFormKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 160,
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
                  "Welcome Back",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Please enter your email address",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _emailAddressController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(hintText: "Email"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      if (!GetUtils.isEmail(value)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<EmailVerificationController>(
                    builder: (controller) {
                      if(controller.emailVerificationInProgress){
                        return const Center(
                          child: CircularProgressIndicator(
                          ),
                        );
                      }
                      return ElevatedButton(
                        onPressed: () async {
                          if (_emailVerificationFormKey.currentState!.validate()) {
                            final response = await controller
                                .verifyEmail(_emailAddressController.text.trim());
                            if (response) {
                              if(mounted) {
                                showSnackBar("Email sending successful", context,Colors.green[500], true);
                                Get.to(() =>  OtpVerificationScreen(email: _emailAddressController.text.trim(),));
                              }
                            } else {
                              if (mounted) {
                                showSnackBar("Email sending failed", context,
                                    Colors.red[500], false);
                              }
                            }
                          }
                        },
                        child: const Text("Next",
                            style: TextStyle(fontWeight: FontWeight.w500)),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
