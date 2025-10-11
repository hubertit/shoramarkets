import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../providers/auth_provider.dart';
import '../../../../shared/utils/snackbar_helper.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';
import 'package:dio/dio.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../home/presentation/screens/home_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _isEmailLogin = true; // true for email, false for phone

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _navigateAfterLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      if (_isEmailLogin) {
        await ref.read(authProvider.notifier).signInWithEmailAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );
      } else {
        await ref.read(authProvider.notifier).signInWithPhoneAndPassword(
          _emailController.text.trim(),
          _passwordController.text,
        );
      }
      final user = ref.read(authProvider).value;
      if (mounted && user != null) {
        showIntentionSnackBar(
          context,
          'Login successful! Welcome back.',
          intent: SnackBarIntent.success,
        );
        _navigateAfterLogin();
      }
    } catch (e) {
      if (!mounted) return;
      String errorMessage = 'Login failed. ';
      if (e is DioException) {
        final backendMsg = e.response?.data['message'] ?? e.message;
        errorMessage += backendMsg ?? 'Please check your credentials and try again.';
      } else if (e.toString().contains('Invalid email/phone or password')) {
        errorMessage += 'Please check your ${_isEmailLogin ? 'email' : 'phone number'} and password and try again.';
      } else if (e.toString().contains('No registered user found')) {
        errorMessage += 'No account found with these credentials. Please register first.';
      } else if (e.toString().contains('network')) {
        errorMessage += 'Network error. Please check your internet connection.';
      } else {
        errorMessage += e.toString();
      }
      showIntentionSnackBar(
        context,
        errorMessage,
        intent: SnackBarIntent.error,
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _navigateToRegister() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppTheme.spacing24),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Logo and Title
                  Image.asset(
                    'assets/images/logo.png',
                    height: 120,
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  Text(
                    'Welcome Back',
                    style: Theme.of(context).textTheme.displaySmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Text(
                    'Sign in to continue',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppTheme.textSecondaryColor,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppTheme.spacing32),
                  // Login Method Toggle
                  Container(
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceColor,
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                      border: Border.all(color: AppTheme.thinBorderColor),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEmailLogin = true;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                              decoration: BoxDecoration(
                                color: _isEmailLogin ? AppTheme.primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                              ),
                              child: Text(
                                'Email',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: _isEmailLogin ? Colors.white : AppTheme.textPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isEmailLogin = false;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                              decoration: BoxDecoration(
                                color: !_isEmailLogin ? AppTheme.primaryColor : Colors.transparent,
                                borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                              ),
                              child: Text(
                                'Phone',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: !_isEmailLogin ? Colors.white : AppTheme.textPrimaryColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  // Email/Phone Field
                  TextFormField(
                    controller: _emailController,
                    keyboardType: _isEmailLogin ? TextInputType.emailAddress : TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    textCapitalization: _isEmailLogin ? TextCapitalization.none : TextCapitalization.none,
                    autocorrect: !_isEmailLogin, // Disable autocorrect for email
                    enableSuggestions: !_isEmailLogin, // Disable suggestions for email
                    decoration: InputDecoration(
                      labelText: _isEmailLogin ? 'Email Address' : 'Phone Number',
                      prefixIcon: Icon(_isEmailLogin ? Icons.email_outlined : Icons.phone_outlined),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your ${_isEmailLogin ? 'email' : 'phone number'}';
                      }
                      if (_isEmailLogin) {
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                      } else {
                          if (!RegExp(r'^[0-9+\-\s()]+$').hasMatch(value)) {
                            return 'Please enter a valid phone number';
                          }
                        }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    keyboardType: TextInputType.visiblePassword,
                    textInputAction: TextInputAction.done,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  // Forgot Password
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing24),
                  // Login Button
                  PrimaryButton(
                    label: 'Sign In',
                    isLoading: _isLoading,
                    onPressed: _isLoading ? null : _handleLogin,
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  // Register Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Don\'t have an account?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      TextButton(
                        onPressed: _navigateToRegister,
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
} 