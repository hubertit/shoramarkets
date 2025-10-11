import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/screens/login_screen.dart';
import '../providers/tab_index_provider.dart';
import 'edit_profile_screen.dart';
import 'about_screen.dart';
import 'help_support_screen.dart';
import 'notifications_screen.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../../merchant/presentation/screens/transactions_screen.dart';
import '../../../merchant/presentation/screens/wallets_screen.dart' show WalletCard;
import '../../../../shared/widgets/transaction_item.dart';
import '../../../../shared/models/transaction.dart';
import 'package:d_chart/d_chart.dart';
import '../../../../shared/models/wallet.dart';
import 'request_payment_screen.dart';
import 'pay_screen.dart';
import 'payouts_screen.dart';
import 'search_screen.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../feed/presentation/screens/feed_screen.dart';
import '../../../brokers/presentation/screens/brokers_screen.dart';
import '../../../investments/presentation/screens/advisors_screen.dart';
import '../../../investments/presentation/screens/businesses_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(tabIndexProvider);
    final tabs = [
      const _DashboardTab(),
      const _WalletsTab(),
      const TransactionsScreen(),
      const ProfileTab(),
    ];
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          ref.read(tabIndexProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallets',
          ),
          NavigationDestination(
            icon: Icon(Icons.swap_horiz_outlined),
            selectedIcon: Icon(Icons.swap_horiz),
            label: 'Transactions',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _DashboardTab extends StatefulWidget {
  const _DashboardTab();

  @override
  State<_DashboardTab> createState() => _DashboardTabState();
}

class _DashboardTabState extends State<_DashboardTab> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Align(
          alignment: Alignment.centerLeft,
          child: Image.asset(
            'assets/images/logo-name.png',
            height: 32,
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 16,
                    minHeight: 16,
                  ),
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white.withOpacity(0.7),
          labelStyle: AppTheme.bodySmall.copyWith(fontWeight: FontWeight.w600),
          unselectedLabelStyle: AppTheme.bodySmall.copyWith(fontWeight: FontWeight.w400),
          tabs: const [
            Tab(text: 'Opportunities'),
            Tab(text: 'Brokers'),
            Tab(text: 'Advisors'),
            Tab(text: 'Businesses'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          FeedScreen(),
          BrokersScreen(),
          AdvisorsScreen(),
          BusinessesScreen(),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _QuickActionButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing4),
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.08),
          borderRadius: BorderRadius.circular(AppTheme.borderRadius16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: AppTheme.primaryColor, size: 28),
            const SizedBox(height: AppTheme.spacing8),
            Text(label, style: AppTheme.bodySmall.copyWith(color: AppTheme.primaryColor, fontWeight: FontWeight.w600, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;
  const _PlaceholderScreen({required this.title});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text('This is a placeholder for $title.')),
    );
  }
}

class _TransactionsTab extends StatelessWidget {
  const _TransactionsTab();
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Transactions'));
  }
}
class _WalletsTab extends StatefulWidget {
  const _WalletsTab();

  @override
  State<_WalletsTab> createState() => _WalletsTabState();
}

class _WalletsTabState extends State<_WalletsTab> {
  // State to track balance visibility for each wallet
  final Map<String, bool> _walletBalanceVisibility = {};

  // Method to handle balance visibility changes
  void _onBalanceVisibilityChanged(String walletId, bool showBalance) {
    setState(() {
      _walletBalanceVisibility[walletId] = showBalance;
    });
  }

  // Mock wallets for PageView
  List<Wallet> get homeWallets => [
    Wallet(
      id: 'WALLET-1',
      name: 'Main Wallet',
      balance: 250000,
      currency: 'RWF',
      type: 'individual',
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 120)),
      owners: ['You'],
      isDefault: true,
    ),
    Wallet(
      id: 'WALLET-2',
      name: 'Joint Wallet',
      balance: 1200000,
      currency: 'RWF',
      type: 'joint',
      status: 'active',
      createdAt: DateTime.now().subtract(const Duration(days: 60)),
      owners: ['You', 'Alice', 'Eric'],
      isDefault: false,
      description: 'Joint savings for family expenses',
      targetAmount: 2000000,
      targetDate: DateTime.now().add(const Duration(days: 180)),
    ),
    Wallet(
      id: 'WALLET-3',
      name: 'Vacation Fund',
      balance: 350000,
      currency: 'RWF',
      type: 'individual',
      status: 'inactive',
      createdAt: DateTime.now().subtract(const Duration(days: 200)),
      owners: ['You'],
      isDefault: false,
      description: 'Vacation savings',
      targetAmount: 500000,
      targetDate: DateTime.now().add(const Duration(days: 90)),
    ),
  ];

  // Mock metrics
  Map<String, dynamic> get metrics => {
    'Today\'s Revenue': 150000,
    'Total Transactions': 42,
    'Pending Settlements': 3,
  };

  // Mock recent transactions
  List<Transaction> get mockTransactions => [
    Transaction(
      id: 'TXN-1001',
      amount: 25000,
      currency: 'RWF',
      type: 'payment',
      status: 'success',
      date: DateTime.now().subtract(const Duration(hours: 2)),
      description: 'TXN #1234',
      paymentMethod: 'Mobile Money',
      customerName: 'Alice Umutoni',
      customerPhone: '0788123456',
      reference: 'PMT-20240601-001',
    ),
    Transaction(
      id: 'TXN-1002',
      amount: 120000,
      currency: 'RWF',
      type: 'payment',
      status: 'pending',
      date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      description: 'TXN #1235',
      paymentMethod: 'Card',
      customerName: 'Eric Niyonsaba',
      customerPhone: '0722123456',
      reference: 'PMT-20240601-002',
    ),
    Transaction(
      id: 'TXN-1003',
      amount: 50000,
      currency: 'RWF',
      type: 'refund',
      status: 'success',
      date: DateTime.now().subtract(const Duration(days: 2)),
      description: 'Refund for TXN #1232',
      paymentMethod: 'Bank',
      customerName: 'Claudine Mukamana',
      customerPhone: '0733123456',
      reference: 'REF-20240530-001',
    ),
  ];

  // Mock chart data
  Map<String, double> get paymentMethodBreakdown => {
    'Mobile Money': 60,
    'Card': 25,
    'Bank': 10,
    'QR/USSD': 5,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wallets'),
        backgroundColor: AppTheme.surfaceColor,
        iconTheme: const IconThemeData(color: AppTheme.textPrimaryColor),
        titleTextStyle: AppTheme.titleMedium.copyWith(color: AppTheme.textPrimaryColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Default Wallet Card
            SizedBox(
              height: 180, // increased to fix overflow issue
              child: PageView.builder(
                itemCount: homeWallets.length,
                controller: PageController(viewportFraction: 0.92),
                itemBuilder: (context, index) {
                  final isFirst = index == 0;
                  final isLast = index == homeWallets.length - 1;
                  return Padding(
                    padding: EdgeInsets.only(
                      left: isFirst ? 0 : AppTheme.spacing8,
                      right: isLast ? 0 : AppTheme.spacing8,
                    ),
                    child: WalletCard(
                      wallet: homeWallets[index], 
                      showBalance: _walletBalanceVisibility[homeWallets[index].id] ?? true,
                      onShowBalanceChanged: (showBalance) => _onBalanceVisibilityChanged(homeWallets[index].id, showBalance),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: AppTheme.spacing4), // further reduced space between wallet card and quick actions
            // Quick actions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing16, horizontal: AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.06),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.qr_code,
                        label: 'Request',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const RequestPaymentScreen()),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.send,
                        label: 'Pay',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const PayScreen()),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.account_balance_wallet,
                        label: 'Top Up',
                        onTap: () async {
                          final result = await showModalBottomSheet<bool>(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (context) => const _TopUpSheet(),
                          );
                          if (result == true && context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
          AppTheme.successSnackBar(message: 'Top up successful!'),
        );
                          }
                        },
                      ),
                    ),
                    Expanded(
                      child: _QuickActionButton(
                        icon: Icons.history,
                        label: 'Payouts',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const PayoutsScreen()),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            // Chart title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Text(
                'Cash In & Out (This Week)',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            // Area chart section with legends
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppTheme.surfaceColor,
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius16),
                  border: Border.all(color: AppTheme.thinBorderColor, width: AppTheme.thinBorderWidth),
                ),
                child: Container(
                  height: 162,
                  width: double.infinity,
                  child: DChartComboO(
                    groupList: [
                      OrdinalGroup(
                        id: 'Cash In',
                        data: [
                          OrdinalData(domain: 'Mon', measure: 120),
                          OrdinalData(domain: 'Tue', measure: 150),
                          OrdinalData(domain: 'Wed', measure: 100),
                          OrdinalData(domain: 'Thu', measure: 180),
                          OrdinalData(domain: 'Fri', measure: 90),
                          OrdinalData(domain: 'Sat', measure: 200),
                          OrdinalData(domain: 'Sun', measure: 170),
                        ],
                        color: AppTheme.primaryColor.withOpacity(0.85),
                        chartType: ChartType.bar,
                      ),
                      OrdinalGroup(
                        id: 'Cash Out',
                        data: [
                          OrdinalData(domain: 'Mon', measure: 80),
                          OrdinalData(domain: 'Tue', measure: 60),
                          OrdinalData(domain: 'Wed', measure: 120),
                          OrdinalData(domain: 'Thu', measure: 90),
                          OrdinalData(domain: 'Fri', measure: 110),
                          OrdinalData(domain: 'Sat', measure: 70),
                          OrdinalData(domain: 'Sun', measure: 130),
                        ],
                        color: Color(0xFFBDBDBD), // Gray
                        chartType: ChartType.bar,
                      ),
                    ],
                    animate: true,
                    domainAxis: DomainAxis(
                      showLine: true,
                      labelStyle: const LabelStyle(
                        color: AppTheme.textSecondaryColor, // Slightly lighter for reduced visibility
                        fontSize: 12, // Larger font size
                        fontWeight: FontWeight.w600, // Bold weight
                      ),
                    ),
                    measureAxis: MeasureAxis(
                      showLine: true,
                      labelStyle: const LabelStyle(
                        color: AppTheme.textSecondaryColor, // Slightly lighter for reduced visibility
                        fontSize: 12, // Larger font size
                        fontWeight: FontWeight.w600, // Bold weight
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            // Recent transactions
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: Text(
                'Recent Transactions',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textPrimaryColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
              ),
            ),
            ...mockTransactions.map((tx) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
              child: TransactionItem(transaction: tx),
            )),
          ],
        ),
      ),
    );
  }

  Color _getChartColor(String method) {
    switch (method) {
      case 'Mobile Money':
        return const Color(0xFF43A047); // green
      case 'Card':
        return const Color(0xFF1976D2); // blue
      case 'Bank':
        return const Color(0xFFFBC02D); // yellow
      case 'QR/USSD':
        return const Color(0xFF8E24AA); // purple
      default:
        return AppTheme.primaryColor;
    }
  }
}
class ProfileTab extends ConsumerWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    return authState.when(
      data: (user) {
        return Scaffold(
          backgroundColor: AppTheme.backgroundColor,
          appBar: AppBar(
                backgroundColor: AppTheme.primaryColor,
                elevation: 0,
            title: const Text(
              'Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
          body: SingleChildScrollView(
                      child: Column(
                        children: [
                // Profile Header - Simple like WhatsApp
                          Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppTheme.spacing24),
                            decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                  ),
                  child: Column(
                        children: [
                      // Profile Avatar
                      CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              backgroundImage: (user?.profileImg != null && user?.profileImg != ''
                                ? NetworkImage(user!.profileImg)
                                : (user?.profilePicture != null && user?.profilePicture != ''
                                  ? NetworkImage(user!.profilePicture)
                                  : null)) as ImageProvider<Object>?,
                              child: ((user?.profileImg == null || user?.profileImg == '') && (user?.profilePicture == null || user?.profilePicture == ''))
                                  ? Text(
                                      (user?.name != null && user?.name != '' ? user!.name[0].toUpperCase() : 'U'),
                                style: const TextStyle(
                                  fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  : null,
                          ),
                          const SizedBox(height: AppTheme.spacing16),
                          // User Name
                          Text(
                            user?.name ?? 'User',
                        style: const TextStyle(
                          fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      const SizedBox(height: AppTheme.spacing4),
                      // User Email
                      Text(
                        user?.email ?? 'user@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.8),
                              ),
                            ),
                        ],
                      ),
                    ),
                
                // Settings List - Simple like WhatsApp
                Container(
                  color: AppTheme.surfaceColor,
                  child: Column(
                    children: [
                      // Account Settings
                      _buildSettingsSection('Account', [
                        _buildSettingsTile(
                          icon: Icons.person_outline,
                          title: 'Profile Details',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const EditProfileScreen(),
                                ),
                              );
                            },
                          ),
                        _buildSettingsTile(
                            icon: Icons.lock_outline,
                          title: 'Password',
                            onTap: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                AppTheme.infoSnackBar(message: 'Change password feature coming soon'),
                              );
                            },
                          ),
                        _buildSettingsTile(
                          icon: Icons.phone_outlined,
                          title: 'Phone Number',
                          subtitle: user?.phoneNumber ?? 'Not provided',
                          onTap: () {},
                        ),
                      ]),
                      
                      // App Settings
                      _buildSettingsSection('App', [
                        _buildSettingsTile(
                          icon: Icons.notifications_outlined,
                          title: 'Notifications',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => const NotificationsScreen(),
                                ),
                              );
                            },
                          ),
                        _buildSettingsTile(
                          icon: Icons.dark_mode_outlined,
                          title: 'Dark Mode',
                          trailing: Switch(
                            value: false,
                            onChanged: (value) {
                              // TODO: Implement dark mode
                            },
                          ),
                          onTap: () {}, // Empty onTap since we have a Switch
                        ),
                        _buildSettingsTile(
                          icon: Icons.language_outlined,
                          title: 'Language',
                          subtitle: 'English',
                          onTap: () {},
                        ),
                      ]),
                      
                      // Support
                      _buildSettingsSection('Support', [
                        _buildSettingsTile(
                            icon: Icons.help_outline,
                            title: 'Help & Support',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const HelpSupportScreen(),
                                ),
                              );
                            },
                          ),
                        _buildSettingsTile(
                          icon: Icons.info_outline,
                          title: 'About',
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                builder: (context) => const AboutScreen(),
                                ),
                              );
                            },
                          ),
                      ]),
                      
                      // Account Management
                      _buildSettingsSection('Account Management', [
                        _buildSettingsTile(
                            icon: Icons.logout,
                            title: 'Logout',
                          textColor: AppTheme.warningColor,
                            onTap: () async {
                              await ref.read(authProvider.notifier).signOut();
                              if (context.mounted) {
                                Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                  (route) => false,
                                );
                              }
                            },
                          ),
                        _buildSettingsTile(
                            icon: Icons.delete_forever,
                            title: 'Delete Account',
                          textColor: AppTheme.errorColor,
                            onTap: () async {
                              final confirm = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                title: const Text('Delete Account'),
                                content: const Text('Are you sure you want to delete your account? This action cannot be undone.'),
                                  actions: [
                                    TextButton(
                                    onPressed: () => Navigator.of(context).pop(false),
                                    child: const Text('Cancel'),
                                    ),
                                    TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: const Text('Delete'),
                                    ),
                                  ],
                                ),
                              );
                              if (confirm == true) {
                                try {
                                  await ref.read(authProvider.notifier).deleteAccount();
                                  if (context.mounted) {
                                    Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => const LoginScreen(),
                                      ),
                                      (route) => false,
                                    );
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      AppTheme.errorSnackBar(message: 'Error: $e'),
                                    );
                                  }
                                }
                              }
                            },
                          ),
                      ]),
                        ],
                ),
              ),
            ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Text('Error: $error'),
      ),
    );
  }

  Widget _buildSettingsSection(String title, List<Widget> children) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
          child: Text(
                  title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          color: Colors.white,
          child: Column(children: children),
        ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    Color? textColor,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.black87),
        title: Text(
          title,
        style: TextStyle(
          color: textColor ?? Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      subtitle: subtitle != null
          ? Text(
          subtitle,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            )
          : null,
      trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
    );
  }
}

class _TopUpSheet extends StatefulWidget {
  const _TopUpSheet();

  @override
  State<_TopUpSheet> createState() => _TopUpSheetState();
}

class _TopUpSheetState extends State<_TopUpSheet> {
  final TextEditingController _amountController = TextEditingController();
  String _selectedMethod = 'Mobile Money';
  final List<String> _paymentMethods = [
    'Mobile Money',
    'Bank Transfer',
    'Card',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: AppTheme.spacing16,
        right: AppTheme.spacing16,
        top: AppTheme.spacing16,
        bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacing16,
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          // Handle
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            ),
            const SizedBox(height: AppTheme.spacing16),
          
          // Title
          Text(
            'Top Up Wallet',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacing24),
          
          // Amount Input
          Text(
            'Amount (RWF)',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
            const SizedBox(height: AppTheme.spacing8),
          TextField(
              controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                hintText: 'Enter amount',
              prefixText: 'RWF ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
              ),
            ),
            ),
            const SizedBox(height: AppTheme.spacing16),
          
          // Payment Method
          Text(
            'Payment Method',
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
            const SizedBox(height: AppTheme.spacing8),
            DropdownButtonFormField<String>(
              value: _selectedMethod,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
              ),
            ),
            items: _paymentMethods.map((String method) {
              return DropdownMenuItem<String>(
                value: method,
                child: Text(method),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedMethod = newValue;
                });
              }
            },
          ),
          const SizedBox(height: AppTheme.spacing24),
          
          // Top Up Button
            PrimaryButton(
            label: 'Top Up',
            onPressed: () {
              final amount = _amountController.text;
              if (amount.isNotEmpty) {
                Navigator.of(context).pop(true);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  AppTheme.errorSnackBar(message: 'Please enter an amount'),
                );
              }
            },
          ),
          const SizedBox(height: AppTheme.spacing16),
        ],
      ),
    );
  }
} 
