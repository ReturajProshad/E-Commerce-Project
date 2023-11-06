<!DOCTYPE html>
<html>
<body>
  <h1>E-commerce Crafty Bay App</h1>
  <p>Welcome to the E-commerce Crafty Bay app repository. Crafty Bay is an e-commerce application designed for your shopping needs. This README provides an overview of the project structure and its components.</p>

  <h2>Project Structure</h2>
  <pre>
    <code><b>
CraftyBay/lib
├── application/
│   ├── app.dart
│   └── state_holder_binder.dart
├── data/
│   ├── models/
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
│   ├── services/
│   │   ├── create_review_caller.dart
│   │   └── network_caller.dart
│   └── utility/
│       └── urls.dart
├── Presentation /
│   ├── State_holders/ </b>     #all state holders and controllers are here<b>
│   ├── ui/
│   │   └── screens/
│   │       ├── auth/
│   │       │   ├── complete_profile_screen.dart      
│   │       │   ├── email_verification_screen.dart
│   │       │   └── otp_verification_screen.dart
│   │       └── </b> #all other screens are here<b>
│   ├── utility/
│   │   ├── app_colors.dart
│   │   ├── color_extension.dart
│   │   └── image_assets.dart
│   └── Widgets/
│       ├── Home/
│       │   ├── home_slider.dart
│       │   ├── product_image_slider.dart
│       │   └── section_header.dart
│       └─</b> #all other widgets like customstepper , cards , styles are here <b>
└── main.dart</b>
     </code>
  </pre>

  <h2>Key Features</h2>
  <p>Here are some of the key features of the Crafty Bay app:</p>
  <ul>
    <li>User Authentication: Crafty Bay offers user registration and login functionality.</li>
    <li>Product Listings: Browse and search for a wide range of products.</li>
    <li>Wishlist Management: Save your favorite products for later.</li>
    <li>Reviews and Ratings: Read and leave reviews for products.</li>
    <li>Secure Payments: Multiple payment methods for a secure checkout process.</li>
    <li>Dark Theme: Enjoy the app in a sleek dark theme for a comfortable browsing experience.</li>
  </ul>
   <h2>Video Screen Recordings</h2>
  <p>View the following screen recordings to get a visual preview of the app's functionality:</p>


<h3>Otp verification Screen</h3>


https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/42c4100e-dcb9-4f67-9561-2f9950c21b18


<h3>Complete Your Profile</h3>

 https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/787cecd2-5790-4458-aa45-6e72edc08d46

 https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/d6bd5078-8ab2-483e-bc70-58aa91af915f

 https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/0ece0df2-4dd0-4827-a117-5bfff7f5fcd6


<h3>Wish List Check</h3>


https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/679ca6e5-478d-4e1e-b6cf-7fa291bfe15b


https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/1e4c9695-f07a-4703-b562-4e6fd5cfedd6

<h3>Review Screen</h3>


https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/c8ce9b9b-dfbc-47ce-bf04-b14b627d2c5e



https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/0c270ada-f827-4592-84b2-e7d2dcdbd99c



<h3>Search bar</h3>

https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/2383a7d4-1b74-488e-ab6b-927351ec1ae6

<h2>App Overview</h2>
  <p>Here's a sneak peek at what the app looks like:</p>
<h4>1.Overview</h4>

![Untitled-1](https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/7124c1ee-aa8e-44ee-b654-6de30b9b0d7c)

<h4>2.Overview</h4>

![2](https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/4ff5ce2b-e38f-49ab-b13e-fee7d37caaaa)

<h4>3.dark theme</h4>

![3](https://github.com/ReturajProshad/E-Commerce-Project/assets/130851471/321884b0-ebaf-41e3-8c17-9fabd04f8938)



<h2>Application Workflow</h2>

### Application Launch

- [ ] **Splash Screen #AppLaunch**: The app starts with a visually engaging splash screen to provide a smooth and appealing launch experience.

- [ ] **User Authentication #AppLaunch**: The user is prompted for authentication.
  - [ ] **Login #AppLaunch**: If the user is already registered, they are directed to the login page.
    - [ ] **If successful, move to Home Screen #Login**: Upon successful login, the user gains access to the Home Screen, where they can browse and shop.
    - [ ] **Else, verify email #Login**: In case the login is unsuccessful, the user is redirected to email verification for additional security.

- [ ] **Main Bottom Navigation Bar #AppLaunch**: The app features a bottom navigation bar for easy access to key sections.
  - [ ] **Home #NavBar**: The "Home" section is the main hub for users, allowing them to explore the latest products.
  - [ ] **Categories #NavBar**: The "Categories" section provides a categorized view of products, making it easier for users to find what they're looking for.
  - [ ] **Chart #NavBar**: Users can view and manage their shopping cart in the "Chart" section.
  - [ ] **Wishlist #NavBar**: The "Wishlist" section displays items the user has marked as favorites.

### Home Screen

- [ ] **Home Screen Layout #HomeScreen**: The Home Screen is designed for a user-friendly shopping experience.
  - [ ] **Search bar #HomeScreenLayout**: A search bar allows users to find specific products quickly.
  - [ ] **App bar #HomeScreenLayout**: The app bar provides several key features.
    - [ ] **Theme change button #AppBar**: Users can switch between light and dark themes for their preferred viewing experience.
    - [ ] **Read profile button #AppBar**: Access the user's profile for personalized settings and information.
    - [ ] **Call button #AppBar**: Users can contact support or sellers directly via the app.
    - [ ] **Notification button #AppBar**: Notifications are accessible for updates on orders and special offers.

- [ ] **Home Screen Sections #HomeScreen**: The Home Screen also contains several sections for a more refined shopping experience.
  - [ ] **Categories #HomeScreen**: This section provides an organized view of product categories, making it easy for users to browse by category.
  - [ ] **Popular #HomeScreen**: The "Popular" section showcases the most popular products, helping users discover trending items.
  - [ ] **Special #HomeScreen**: In the "Special" section, users can explore special offers and deals on selected products.
  - [ ] **New #HomeScreen**: The "New" section introduces the latest additions to the product catalog, keeping users informed about new arrivals.


### Categories Screen

- [ ] **Display list of categories #Categories**: The "Categories" section presents a list of available product categories.
  - [ ] **Each category leads to respective items #Categories**: Users can click on a category to explore products within that specific category. GetX controllers or state management utilized to manage category data and navigation.

### Chart Screen

- [ ] **Display current cart #Chart**: In the "Chart" section, users can view the contents of their shopping cart.
  - [ ] **Option to modify cart #Chart**: Users can add, remove, or modify items in their cart. GetX controllers or state management are used to track and update cart items.
  - [ ] **Checkout Button #Chart**: When ready to make a purchase, users can proceed to checkout directly from the cart screen, streamlining the purchasing process.

### Wishlist Screen

- [ ] **Display current wishlist #Wishlist**: The "Wishlist" section shows items that the user has saved for future purchase.
</body>
</html>
