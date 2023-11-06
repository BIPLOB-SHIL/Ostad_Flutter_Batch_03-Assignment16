import 'package:assignment16/data/models/create_profile_data.dart';
import 'package:assignment16/presentation/state_holders/auth_controller.dart';
import 'package:assignment16/presentation/state_holders/create_profile_controller.dart';
import 'package:assignment16/ui/screens/main_bottom_nav_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../ utility/image_assets.dart';
import '../../ utility/show_snackbar.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  CreateProfileData? createProfileData = AuthController.userProfile.data;

  final _customerNameController = TextEditingController();
  final _customerAddressController = TextEditingController();
  final _customerCityController = TextEditingController();
  final _countryController = TextEditingController();
  final _customerPostCodeController = TextEditingController();
  final _customerMobileController = TextEditingController();
  final _shippingAddressController = TextEditingController();

  final _completeProfileFormKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _completeProfileFormKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
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
                  "Complete Profile",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Get started with us with your details",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _customerNameController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: "Name"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _customerAddressController,
                    keyboardType: TextInputType.name,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: "Address",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _customerCityController,
                    keyboardType: TextInputType.name,
                    decoration: const InputDecoration(hintText: "City"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _customerPostCodeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "PostCode"),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _countryController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        hintText: "Country",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _customerMobileController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        hintText: "Mobile Number",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                    controller: _shippingAddressController,
                    keyboardType: TextInputType.streetAddress,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        hintText: "Shipping Address",
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required field is empty';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<CreateProfileController>(
                      builder: (createProfileController) {
                    if (createProfileController.createProfileInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        if (_completeProfileFormKey.currentState!
                            .validate()) {
                          createProfileController
                              .createProfile(
                                  _customerNameController.text.trim(),
                                  _customerAddressController.text.trim(),
                                  _customerCityController.text.trim(),
                                  _customerPostCodeController.text.trim(),
                                  _countryController.text.trim(),
                                  _customerMobileController.text.trim(),
                                  _shippingAddressController.text.trim())
                              .then((value) {
                            if (value == true) {
                              if (mounted) {
                                AuthController.updateUserInfo(CreateProfileData(
                                    cusName: _customerNameController.text,
                                    cusAdd: _customerAddressController.text,
                                    cusCity: _customerCityController.text,
                                    cusState: _customerCityController.text,
                                    cusPostcode:
                                        _customerPostCodeController.text,
                                    cusCountry: _countryController.text,
                                    cusPhone: _customerMobileController.text,
                                    cusFax: _customerMobileController.text,
                                    shipName: _customerNameController.text,
                                    shipAdd: _customerAddressController.text,
                                    shipCity: _customerCityController.text,
                                    shipState: _customerCityController.text,
                                    shipPostcode:
                                        _customerPostCodeController.text,
                                    shipCountry: _customerMobileController.text,
                                    shipPhone: _customerMobileController.text));
                                Get.offAll(() => const MainBottomNavScreen());
                                showSnackBar("Creating profile successful",
                                    context, Colors.green[500], true);
                              }
                            } else {
                              if (mounted) {
                                showSnackBar("Creating of profile failed",
                                    context, Colors.red[500], false);
                              }
                            }
                          });
                        }
                      },
                      child: const Text("Complete",
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
