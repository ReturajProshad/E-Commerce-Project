class Urls {
  static const String _baseUrl = 'https://ecom-api.teamrabbil.com/api';

  static String verifyEmail(String email) => '$_baseUrl/UserLogin/$email';

  static String verifyOtp(String email, String otp) =>
      '$_baseUrl/VerifyLogin/$email/$otp';

  static String getHomeSliders = '$_baseUrl/ListProductSlider';

  static String getCategories = '$_baseUrl/CategoryList';

  static String getProductByCategory(int categoryId) =>
      '$_baseUrl/ListProductByCategory/$categoryId';

  static String getProductsByRemarks(String remarks) =>
      '$_baseUrl/ListProductByRemark/$remarks';

  static String getProductDetails(int productId) =>
      '$_baseUrl/ProductDetailsById/$productId';

  static const String addToCart = '$_baseUrl/CreateCartList';

  static const String getCartList = '$_baseUrl/CartList';

  static String addWishList(int id) => '$_baseUrl/CreateWishList/$id';

  static String RemovefromWishList(int id) => '$_baseUrl/RemoveWishList/$id';

  static const String getWishListofProduct = '$_baseUrl/ProductWishList';

  static String removeFromCart(int id) => '$_baseUrl/DeleteCartList/$id';

  static const String createInvoice = '$_baseUrl/InvoiceCreate';

  static String getReviewsbyid(int id) => '$_baseUrl/ListReviewByProduct/$id';

  static String CreateReview = '$_baseUrl/CreateProductReview';

  static String ReadProfile = '$_baseUrl/ReadProfile';

  static String CreateProfile = '$_baseUrl/CreateProfile';
}
