# Shora Markets

Your Growth, Our Marketplace

A comprehensive marketplace mobile application built with Flutter, designed to connect buyers and sellers in Rwanda.

## Features

- **User Authentication**: Secure login and registration system
- **Product Catalog**: Browse and search products across categories
- **Shopping Cart**: Add products to cart and manage quantities
- **Wishlist**: Save favorite products for later
- **Order Management**: Track orders and order history
- **Merchant Profiles**: Connect with local merchants and businesses
- **Reviews & Ratings**: Rate and review products and merchants
- **Location Services**: Find nearby merchants and products
- **Push Notifications**: Stay updated with order status and promotions

## Tech Stack

- **Framework**: Flutter 3.4.3+
- **State Management**: Riverpod
- **HTTP Client**: Dio
- **Architecture**: Clean Architecture with Feature-based structure

## Getting Started

### Prerequisites

- Flutter SDK 3.4.3 or higher
- Dart SDK
- Android Studio / VS Code
- iOS development tools (for iOS builds)

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
├── core/           # Core functionality (config, theme, routing)
├── features/       # Feature-based modules
│   ├── auth/       # Authentication
│   ├── home/       # Home screen
│   ├── products/   # Product catalog
│   ├── cart/       # Shopping cart
│   └── profile/    # User profile
├── shared/         # Shared components and utilities
└── main.dart       # App entry point
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the MIT License.
