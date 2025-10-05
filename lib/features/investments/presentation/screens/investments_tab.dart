import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../feed/presentation/screens/feed_screen.dart';
import '../../../brokers/presentation/screens/brokers_screen.dart';
import 'advisors_screen.dart';
import 'businesses_screen.dart';

class InvestmentsTab extends ConsumerStatefulWidget {
  const InvestmentsTab({super.key});

  @override
  ConsumerState<InvestmentsTab> createState() => _InvestmentsTabState();
}

class _InvestmentsTabState extends ConsumerState<InvestmentsTab>
    with SingleTickerProviderStateMixin {
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
        backgroundColor: AppTheme.surfaceColor,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: Text(
          'Investments',
          style: AppTheme.titleMedium.copyWith(
            color: AppTheme.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              // TODO: Navigate to bookmarks screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {
              // TODO: Navigate to liked posts screen
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Navigate to create post screen
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.primaryColor,
          labelColor: AppTheme.primaryColor,
          unselectedLabelColor: AppTheme.textSecondaryColor,
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
