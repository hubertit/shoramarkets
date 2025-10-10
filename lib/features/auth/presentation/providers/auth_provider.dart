import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';

import '../../../../core/config/app_config.dart';
import '../../../../shared/models/user.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AsyncValue<User?>>((ref) {
  return AuthNotifier();
});

class AuthNotifier extends StateNotifier<AsyncValue<User?>> {
  AuthNotifier() : super(const AsyncValue.loading()) {
    _init();
    _startTokenVerificationTimer();
  }

  Timer? _tokenVerificationTimer;

  void _startTokenVerificationTimer() {
    _tokenVerificationTimer?.cancel();
    _tokenVerificationTimer = Timer.periodic(const Duration(seconds: 30), (_) async {
      final isValid = await verifyToken();
      if (!isValid) {
        await signOut();
      }
    });
  }

  @override
  void dispose() {
    _tokenVerificationTimer?.cancel();
    super.dispose();
  }

  Future<void> _init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(AppConfig.userFullDataKey);
      final isLoggedIn = prefs.getBool(AppConfig.isLoggedInKey) ?? false;
      
      if (userJson != null && isLoggedIn) {
        final userData = json.decode(userJson);
        final user = User.fromJson(userData);
        
        // Only load the user if they are truly logged in (not a guest)
        if (!user.id.startsWith('guest_')) {
          state = AsyncValue.data(user);
        } else {
          state = const AsyncValue.data(null);
        }
      } else {
        state = const AsyncValue.data(null);
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      state = const AsyncValue.loading();
      final dio = AppConfig.dioInstance();
      
      // Prepare login data for email
      final loginData = {
        'email': email,
        'password': password,
      };
      
      final response = await dio.post(
        AppConfig.loginEndpoint,
        queryParameters: loginData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'X-CSRF-TOKEN': '', // Add CSRF token if needed
          },
          validateStatus: (status) {
            return status != null && status < 500; // Accept all status codes < 500
          },
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        final userData = responseData['user'];
        final token = responseData['token'];
        
        if (userData == null || token == null) {
          throw Exception('Invalid response format');
        }
        
        // Create user object from API response
        final user = User(
          id: userData['id']?.toString() ?? '1',
          name: userData['name'] ?? '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}'.trim(),
          email: userData['email'] ?? email,
          password: '', // Don't store password
          role: userData['registration_type_id']?.toString() ?? 'user',
          createdAt: userData['created_at'] != null 
              ? DateTime.parse(userData['created_at']) 
              : DateTime.now(),
          lastLoginAt: DateTime.now(),
          isActive: userData['admin_approved'] ?? true,
          about: '',
          address: '',
          profilePicture: userData['profile_photo'] ?? '',
          profileImg: userData['profile_photo'] ?? '',
          profileCover: '',
          coverImg: '',
          phoneNumber: userData['phone'] ?? '',
        );
        
        // Store user data and auth token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConfig.userFullDataKey, json.encode(user.toJson()));
        await prefs.setString(AppConfig.authTokenKey, token);
        await prefs.setBool(AppConfig.isLoggedInKey, true);
        
        state = AsyncValue.data(user);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      String errorMsg = 'Login failed';
      
      if (e.response?.data != null) {
        final responseData = e.response!.data;
        // Try to get message from response
        if (responseData['message'] != null) {
          errorMsg = responseData['message'];
        } else if (responseData['errors'] != null) {
          // Handle validation errors
          final errors = responseData['errors'];
          if (errors is Map && errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              errorMsg = firstError.first;
            }
          }
        }
      } else {
        errorMsg = e.message ?? 'Network error occurred';
      }
      
      state = AsyncValue.error(errorMsg, StackTrace.current);
      rethrow;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> signInWithPhoneAndPassword(String phone, String password) async {
    try {
      state = const AsyncValue.loading();
      final dio = AppConfig.dioInstance();
      
      // Prepare login data for phone
      final loginData = {
        'phone': phone,
        'password': password,
      };
      
      final response = await dio.post(
        AppConfig.loginEndpoint,
        queryParameters: loginData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'X-CSRF-TOKEN': '', // Add CSRF token if needed
          },
          validateStatus: (status) {
            return status != null && status < 500; // Accept all status codes < 500
          },
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data;
        final userData = responseData['user'];
        final token = responseData['token'];
        
        if (userData == null || token == null) {
          throw Exception('Invalid response format');
        }
        
        // Create user object from API response
        final user = User(
          id: userData['id']?.toString() ?? '1',
          name: userData['name'] ?? '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}'.trim(),
          email: userData['email'] ?? '',
          password: '', // Don't store password
          role: userData['registration_type_id']?.toString() ?? 'user',
          createdAt: userData['created_at'] != null 
              ? DateTime.parse(userData['created_at']) 
              : DateTime.now(),
      lastLoginAt: DateTime.now(),
          isActive: userData['admin_approved'] ?? true,
      about: '',
      address: '',
          profilePicture: userData['profile_photo'] ?? '',
          profileImg: userData['profile_photo'] ?? '',
      profileCover: '',
      coverImg: '',
          phoneNumber: userData['phone'] ?? phone,
        );
        
        // Store user data and auth token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(AppConfig.userFullDataKey, json.encode(user.toJson()));
        await prefs.setString(AppConfig.authTokenKey, token);
        await prefs.setBool(AppConfig.isLoggedInKey, true);
        
        state = AsyncValue.data(user);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      String errorMsg = 'Login failed';
      
      if (e.response?.data != null) {
        final responseData = e.response!.data;
        // Try to get message from response
        if (responseData['message'] != null) {
          errorMsg = responseData['message'];
        } else if (responseData['errors'] != null) {
          // Handle validation errors
          final errors = responseData['errors'];
          if (errors is Map && errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              errorMsg = firstError.first;
            }
          }
        }
      } else {
        errorMsg = e.message ?? 'Network error occurred';
      }
      
      state = AsyncValue.error(errorMsg, StackTrace.current);
      rethrow;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> signUpWithEmailAndPassword(
    String firstName,
    String lastName,
    String email,
    String phoneNumber,
    String password,
    String role,
  ) async {
    try {
      state = const AsyncValue.loading();
      final dio = AppConfig.dioInstance();
      
      // Prepare registration data as query parameters
      final registrationData = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phoneNumber,
        'password': password,
        'password_confirmation': password, // Add password confirmation
      };

      // Try with JSON body first, then fallback to query parameters
      Response response;
      try {
        response = await dio.post(
          AppConfig.registerEndpoint,
          data: registrationData,
          options: Options(
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'X-CSRF-TOKEN': '', // Add CSRF token if needed
            },
            validateStatus: (status) {
              return status != null && status < 500; // Accept all status codes < 500
            },
          ),
        );
      } catch (e) {
        // Fallback to query parameters if JSON body fails
        response = await dio.post(
          AppConfig.registerEndpoint,
          queryParameters: registrationData,
          options: Options(
            headers: {
              'Accept': 'application/json',
              'X-CSRF-TOKEN': '', // Add CSRF token if needed
            },
            validateStatus: (status) {
              return status != null && status < 500; // Accept all status codes < 500
            },
          ),
        );
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Registration successful, do not log in automatically
      state = const AsyncValue.data(null);
      } else {
        throw Exception(response.data['message'] ?? 'Registration failed');
      }
    } on DioException catch (e) {
      String errorMsg = 'Registration failed';
      
      if (e.response?.data != null) {
        final responseData = e.response!.data;
        // Try to get message from response
        if (responseData['message'] != null) {
          errorMsg = responseData['message'];
        } else if (responseData['errors'] != null) {
          // Handle validation errors
          final errors = responseData['errors'];
          if (errors is Map && errors.isNotEmpty) {
            final firstError = errors.values.first;
            if (firstError is List && firstError.isNotEmpty) {
              errorMsg = firstError.first;
            }
          }
        }
      } else {
        errorMsg = e.message ?? 'Network error occurred';
      }
      
      state = AsyncValue.error(errorMsg, StackTrace.current);
      rethrow;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(AppConfig.isLoggedInKey, false);
      // Don't remove user data, just mark as logged out
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> resetPassword(String email) async {
    // No-op for demo
  }

  Future<String?> getUserRole() async {
    final user = state.value;
    return user?.role;
  }

  Future<void> sendResetCode(String email) async {
    // Simulate sending a code
    await Future.delayed(const Duration(seconds: 1));
  }

  Future<void> requestPasswordReset(String email) async {
    try {
      final dio = AppConfig.dioInstance();
      final response = await dio.post(
        '${AppConfig.authEndpoint}/request_reset',
        data: {'email': email},
      );
      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Failed to request password reset');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['message'] ?? e.message ?? 'Failed to request password reset';
      throw Exception(errorMsg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> resetPasswordWithCode(String email, String code, String newPassword) async {
    try {
      final dio = AppConfig.dioInstance();
      final response = await dio.post(
        '${AppConfig.authEndpoint}/reset_password',
        data: {
          'email': email,
          'reset_code': code,
          'new_password': newPassword,
        },
      );
      if (response.statusCode != 200) {
        throw Exception(response.data['message'] ?? 'Failed to reset password');
      }
    } on DioException catch (e) {
      final errorMsg = e.response?.data['message'] ?? e.message ?? 'Failed to reset password';
      throw Exception(errorMsg);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? password,
    String? about,
    String? profilePicture,
    String? profileCover,
    String? phoneNumber,
    String? address,
    String? profileImg,
    String? coverImg,
  }) async {
    try {
      final currentUser = state.value;
      if (currentUser == null) throw Exception('No user logged in');
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConfig.authTokenKey);
      if (token == null || token.isEmpty) throw Exception('No auth token');

      final dio = AppConfig.dioInstance();
      final formData = FormData();
      formData.fields.add(MapEntry('token', token));
      if (name != null && name.isNotEmpty) formData.fields.add(MapEntry('name', name));
      if (about != null && about.isNotEmpty) formData.fields.add(MapEntry('about', about));
      if (address != null && address.isNotEmpty) formData.fields.add(MapEntry('address', address));
      if (phoneNumber != null && phoneNumber.isNotEmpty) formData.fields.add(MapEntry('phone', phoneNumber));
      // Attach profile image file if it's a local file path
      if (profileImg != null && profileImg.isNotEmpty && !profileImg.startsWith('http')) {
        formData.files.add(MapEntry('profile_img', await MultipartFile.fromFile(profileImg, filename: profileImg.split('/').last)));
      }
      // Attach cover image file if it's a local file path
      if (coverImg != null && coverImg.isNotEmpty && !coverImg.startsWith('http')) {
        formData.files.add(MapEntry('cover_img', await MultipartFile.fromFile(coverImg, filename: coverImg.split('/').last)));
      }

      final response = await dio.post(AppConfig.profileUpdateEndpoint, data: formData);
      if (response.statusCode == 200 && response.data['status'] == 'success') {
        // Update local user data
        final updatedUser = currentUser.copyWith(
          name: name ?? currentUser.name,
          about: about ?? currentUser.about,
          address: address ?? currentUser.address,
          phoneNumber: phoneNumber ?? currentUser.phoneNumber,
          profileImg: profileImg ?? currentUser.profileImg,
          coverImg: coverImg ?? currentUser.coverImg,
        );
        await prefs.setString(AppConfig.userFullDataKey, json.encode(updatedUser.toJson()));
        state = AsyncValue.data(updatedUser);
      } else {
        throw Exception(response.data['message'] ?? 'Profile update failed');
      }
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      rethrow;
    }
  }

  Future<void> deleteAccount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(AppConfig.userFullDataKey);
      await prefs.setBool(AppConfig.isLoggedInKey, false);
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> clearAllData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      state = const AsyncValue.data(null);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(AppConfig.isLoggedInKey) ?? false;
      return isLoggedIn;
    } catch (e) {
      return false;
    }
  }

  bool isGuestUser(User? user) {
    return user == null || user.id.startsWith('guest_');
  }

  Future<void> checkAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isLoggedIn = prefs.getBool(AppConfig.isLoggedInKey) ?? false;
      
      if (isLoggedIn) {
        // Verify token and refresh user data
        final isValid = await verifyToken();
        if (!isValid) {
          await signOut();
        }
      }
    } catch (e) {
      // If there's an error, sign out to be safe
      await signOut();
    }
  }
  
  Future<void> refreshUserData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConfig.authTokenKey);
      if (token == null || token.isEmpty) return;
      
      final dio = AppConfig.dioInstance();
      final response = await dio.get(
        AppConfig.userEndpoint,
        options: Options(
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        final userData = response.data;
        if (userData is Map && userData.containsKey('id')) {
          final user = User(
            id: userData['id']?.toString() ?? '1',
            name: userData['name'] ?? '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}'.trim(),
            email: userData['email'] ?? '',
            password: '',
            role: userData['registration_type_id']?.toString() ?? 'user',
            createdAt: userData['created_at'] != null 
                ? DateTime.parse(userData['created_at']) 
                : DateTime.now(),
            lastLoginAt: DateTime.now(),
            isActive: userData['admin_approved'] ?? true,
            about: '',
            address: '',
            profilePicture: userData['profile_photo'] ?? '',
            profileImg: userData['profile_photo'] ?? '',
            profileCover: '',
            coverImg: '',
            phoneNumber: userData['phone'] ?? '',
          );
          
          await prefs.setString(AppConfig.userFullDataKey, json.encode(user.toJson()));
          state = AsyncValue.data(user);
        }
      }
    } catch (e) {
      // Handle error silently or show a message
      debugPrint('Failed to refresh user data: $e');
    }
  }

  Future<bool> verifyToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConfig.authTokenKey);
      if (token == null || token.isEmpty) return false;
      
      final dio = AppConfig.dioInstance();
      final response = await dio.get(
        AppConfig.userEndpoint,
        options: Options(
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );
      
      if (response.statusCode == 200 && response.data != null) {
        // Update user data if needed
        final userData = response.data;
        if (userData is Map && userData.containsKey('id')) {
          // Update stored user data
          final user = User(
            id: userData['id']?.toString() ?? '1',
            name: userData['name'] ?? '${userData['first_name'] ?? ''} ${userData['last_name'] ?? ''}'.trim(),
            email: userData['email'] ?? '',
            password: '',
            role: userData['registration_type_id']?.toString() ?? 'user',
            createdAt: userData['created_at'] != null 
                ? DateTime.parse(userData['created_at']) 
                : DateTime.now(),
            lastLoginAt: DateTime.now(),
            isActive: userData['admin_approved'] ?? true,
            about: '',
            address: '',
            profilePicture: userData['profile_photo'] ?? '',
            profileImg: userData['profile_photo'] ?? '',
            profileCover: '',
            coverImg: '',
            phoneNumber: userData['phone'] ?? '',
          );
          
          await prefs.setString(AppConfig.userFullDataKey, json.encode(user.toJson()));
          state = AsyncValue.data(user);
        }
        return true;
      } else {
        return false;
      }
    } on DioException catch (_) {
      return false;
    } catch (_) {
      return false;
    }
  }
} 