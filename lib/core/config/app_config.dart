import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AppConfig {
  static const String appName = 'Shora Markets';
  static const String appVersion = '1.0.0';
  static const String apiBaseUrl = '';

  // API Endpoints
  static const String authEndpoint = '/auth';
  static const String productsEndpoint = '/products';
  static const String categoriesEndpoint = '/categories';
  static const String ordersEndpoint = '/orders';
  static const String merchantsEndpoint = '/merchants';
  static const String merchantsListEndpoint = 'merchants/list';
  static const String mapEndpoint = '/map';
  static const String notificationsEndpoint = '/notifications';
  static const String profileUpdateEndpoint = 'profile/update';
  static const String cartEndpoint = '/cart';
  static const String wishlistEndpoint = '/wishlist';
  static const String reviewsEndpoint = '/reviews';

  // Cache Keys
  static const String authTokenKey = 'auth_token';
  static const String userDataKey = 'user_data';
  static const String userRoleKey = 'user_role';
  static const String userFullDataKey = 'user_full_data';
  static const String userCredentialsKey = 'user_credentials';
  static const String isLoggedInKey = 'is_logged_in';
  static const String lastSyncKey = 'last_sync';

  // Timeouts
  static const int connectionTimeout = 30000; // 30 seconds
  static const int receiveTimeout = 30000; // 30 seconds

  // Pagination
  static const int defaultPageSize = 20;

  // Map Configuration
  static const double defaultMapZoom = 15.0;
  static const double defaultMapLatitude = -1.9403; // Kigali coordinates
  static const double defaultMapLongitude = 30.0644;

  // File Upload
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['image/jpeg', 'image/png', 'image/webp'];

  // Notifications
  static const int maxNotificationAge = 7 * 24 * 60 * 60; // 7 days in seconds

  // QR Code
  static const int qrCodeSize = 200;
  static const int qrCodeErrorCorrectionLevel = 3;

  // Animation Durations
  static const int splashDuration = 3000; // 3 seconds
  static const int pageTransitionDuration = 300; // 300 milliseconds

  // Error Messages
  static const String networkErrorMessage = 'Please check your internet connection and try again.';
  static const String serverErrorMessage = 'Something went wrong. Please try again later.';
  static const String authErrorMessage = 'Authentication failed. Please try again.';
  static const String validationErrorMessage = 'Please check your input and try again.';

  // Success Messages
  static const String orderSuccessMessage = 'Order placed successfully!';
  static const String productAddedToCartMessage = 'Product added to cart!';
  static const String productAddedToWishlistMessage = 'Product added to wishlist!';
  static const String profileUpdateSuccessMessage = 'Profile updated successfully!';

  // Feature Flags
  static const bool enablePushNotifications = true;
  static const bool enableLocationServices = true;
  static const bool enableOfflineMode = true;
  static const bool enableAnalytics = true;

  // Payment Configuration
  static const String paymentGateway = 'IremboPay';
  static const String currency = 'RWF';
  static const String currencySymbol = 'Frw';
  
  // Marketplace Configuration
  static const int maxCartItems = 50;
  static const int maxWishlistItems = 100;
  static const int maxProductImages = 10;
  static const int maxReviewLength = 500;

  // Social Media
  static const String facebookUrl = '';
  static const String twitterUrl = '';
  static const String instagramUrl = '';
  static const String linkedinUrl = '';

  // Support
  static const String supportEmail = '';
  static const String supportPhone = '';
  static const String supportWhatsapp = '';

  static Dio dioInstance() {
    final dio = Dio(
      BaseOptions(
        baseUrl: apiBaseUrl,
        connectTimeout: const Duration(milliseconds: connectionTimeout),
        receiveTimeout: const Duration(milliseconds: receiveTimeout),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        logPrint: (obj) => debugPrint(obj.toString()),
      ),
    );
    return dio;
  }
} 