# CraftyBay

## Description
Cafty Bay an ecommerce app, allows users to shop online, browse product categories, create wish lists, add items to a cart, and complete purchases. It also provides payment processing, shipping, and order management capabilities.

## Application Download Link
● 

## Demonstration Link
● 

## Features of Crafty Bay
● Checking internet connection 
● Light/dark mode 
● Payment gateway 
● Calling customer support via direct caller
● Check whether the user is registered or not before placing an order

## User Interface

![image](https://github.com/BIPLOB-SHIL/Ostad_Flutter_Batch_03-Assignment16/assets/112534902/cc071286-74a4-46c0-98a3-036daa38c349)



## Used Packages

● get: ^4.6.6: State management
● flutter_svg: ^2.0.7: Easily display and manipulate SVG files
● pin_code_fields: ^8.0.1: Implement PIN or OTP input fields
● carousel_slider: ^4.2.1: Creating interactive and dynamic image galleries
● cart_stepper: ^4.1.2: Widget to get count
● http: ^1.1.0: Fetching data from APIs and working with web services
● shared_preferences: ^2.2.1: Storing app settings and small amounts of data.
● smart_snackbars: ^1.0.0: Create highly customized snackbars and toasts 
● connectivity_plus: ^5.0.1: Monitoring network connectivity
● webview_flutter: ^4.4.2: Allow HTML content to be displayed through a browser inside an application 
● flutter_phone_direct_caller: ^2.1.1: To call a number directly, without going to phone dialer

## MVP Structure

craftybay/
├── assets/
│   └── images/
│       ├── internet_connection.png
│       ├── logo.svg
│       └── logo_nav.svg
└── lib/
    ├── application/
    │   ├── app.dart
    │   └── state_holder_binder.dart
    ├── data/
    │   ├── models/
    │   │   ├── cart_list_model.dart
    │   │   ├── category_model.dart
    │   │   ├── create_profile_model.dart
    │   │   ├── invoice_create_response_model.dart
    │   │   ├── network_response.dart
    │   │   ├── product_details_model.dart
    │   │   ├── product_model.dart
    │   │   ├── product_review_list_model.dart
    │   │   ├── porduct_wish_list_model.dart
    │   │   ├── read_profile_model.dart
    │   │   └── slider_model.dart
    │   │ 
    │   ├── services/
    │   │   └── network_caller.dart
    │   └── utility/
    │       └── urls.dart
    ├── presentation/
    │   └──state_holders/
    │       ├── add_to_cart_controller.dart
    │       ├── auth_controller.dart
    │       ├── cart_list_controller.dart
    │       ├── category_controller.dart
    │       ├── create_invoice_controller.dart
    │       ├── create_product_review_controller.dart
    │       ├── create_profile_controller.dart
    │       ├── create_wish_list_controller.dart
    │       ├── email_verification_controller.dart
    │       ├── home_slider_controller.dart
    │       ├── main_bottom_nav_controller.dart
    │       ├── new_product_controller.dart
    │       ├── otp_verification_controller.dart
    │       ├── popular_product_controller.dart
    │       ├── product_details_controller.dart
    │       ├── product_list_controller.dart
    │       ├── product_review_list_controller.dart
    │       ├── product_wish_list_controller.dart
    │       ├── read_profile_controller.dart
    │       ├── special_product_controller.dart
    │       └── theme_manager_controller.dart
    │      
    ├── ui/
    │    ├── utility/
    │    │   ├── color_palettes.dart
    │    │   ├── image_assets.dart
    │    │   └── show_snackbar.dart 
    │    ├── screens/
    │    │   ├── auth/
    │    │   │   ├── complete_profile_screen.dart
    │    │   │   ├── email_verification_screen.dart
    │    │   │   └── otp_verification_screen.dart
    │    │   ├── cart_screen.dart
    │    │   ├── category_list_screen.dart
    │    │   ├── checkout_screen.dart
    │    │   ├── create_review_screen.dart
    │    │   ├── home_screen.dart
    │    │   ├── main_bottom_nav_screen.dart
    │    │   ├── product_details_screen.dart
    │    │   ├── product_list_screen.dart
    │    │   ├── read_profile_screen.dart
    │    │   ├── reviews_screen.dart
    │    │   ├── splash_screen.dart
    │    │   ├── webview_screen.dart
    │    │   └── wish_list_screen.dart
    │    └── widgets/
    │         ├── home/
    │         │   ├── home_slider.dart
    │         │   └── section_header.dart
    │         ├── cart_product_card.dart
    │         ├── category_card.dart
    │         ├── circular_icon_button.dart
    │         ├── product_card.dart
    │         ├── product_image_slider.dart
    │         ├── product_wish_list_card.dart
    │         └── reviews_card.dart
    └── main.dart




## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
