class Urls{
  Urls._();
  static const String _baseUrl = 'https://ecom-api.teamrabbil.com/api';
  static String emailVerification (String email) => '$_baseUrl/UserLogin/$email';
  static String otpVerification (String email,String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static String getHomeSliders = '$_baseUrl/ListProductSlider';
  static String getCategory = '$_baseUrl/CategoryList';
  static String getProductByRemarks (String remarks) => '$_baseUrl/ListProductByRemark/$remarks';
  static String getProductListByCategory (int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';
  static String getProductDetailsById (int productId) => '$_baseUrl/ProductDetailsById/$productId';
  static String addToCart = '$_baseUrl/CreateCartList';
  static String getCartList = '$_baseUrl/CartList';
  static String getDeleteCartList (int productId) => '$_baseUrl/DeleteCartList/$productId';
  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';
  static String createProductReview = '$_baseUrl/CreateProductReview';
  static String getListReviewByProduct (int productId) => '$_baseUrl/ListReviewByProduct/$productId';
  static String createInvoice = '$_baseUrl/InvoiceCreate';
  static String createWishList(int productId) => '$_baseUrl/CreateWishList/$productId';
  static String getProductWishList = '$_baseUrl/ProductWishList';
  static String removeProductWishList(int productId) => '$_baseUrl/RemoveWishList/$productId';
}