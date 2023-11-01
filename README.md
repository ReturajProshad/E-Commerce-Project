<!DOCTYPE html>
<html>
<body>
  <h1>E-commerce Crafty Bay App</h1>
  <p>Welcome to the E-commerce Crafty Bay app repository. Crafty Bay is an e-commerce application designed for your shopping needs. This README provides an overview of the project structure and its components.</p>

  <h2>Project Structure</h2>
  <pre>
    <code><b>
CraftyBay
└lib
├── application
│   ├── app.dart
│   └── state_holder_binder.dart
├── data
│   ├── models
│   │   ├── Profile_model.dart
│   │   ├── Review_model.dart
│   │   ├── WishList_model.dart
│   │   ├── brand.dart
│   │   ├── category_data.dart
│   │   ├── network_response.dart
│   │   ├── payment_method.dart
│   │   ├── product.dart
│   │   ├── product_details.dart
│   │   ├── slider_data.dart
│   │   ├── cart_list_model.dart
│   │   ├── category_model.dart
│   │   ├── invoice_create_response_model.dart
│   │   ├── review_model.dart
│   │   ├── product_details_model.dart
│   │   ├── slider_model.dart
│   │   └── product_model.dart
│   ├── services
│   │   ├── create_review_caller.dart
│   │   └── network_caller.dart
│   └── utility
│   │   └── urls.dart
├── Presentation 
│   ├── State_holders //all controllers are here
│   ├── ui
│   │   ├── screens
│   │   │   ├── auth
│   │   │   │   ├── complete_profile_screen.dart      
│   │   │   │   ├── email_verification_screen.dart
│   │   │   │   └── otp_verification_screen.dart
│   │   │   └── //all other screens are here
│   ├── utility
│   │   ├── app_colors.dart
│   │   ├── color_extension.dart
│   │   └── image_assets.dart
│   └── Widgets
│   │   └── Home
│   │   │   ├── home_slider.dart
│   │   │   ├── product_image_slider.dart
│   │   │   └── section_header.dart
│   │   └─ //all other widgets like customstepper , cards , styles are here
    </b> </code>
  </pre>
</body>
</html>
