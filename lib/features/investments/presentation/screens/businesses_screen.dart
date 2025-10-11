import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../businesses/presentation/screens/business_profile_screen.dart';
import '../../../businesses/domain/models/business.dart';

class BusinessesScreen extends ConsumerStatefulWidget {
  const BusinessesScreen({super.key});

  @override
  ConsumerState<BusinessesScreen> createState() => _BusinessesScreenState();
}

class _BusinessesScreenState extends ConsumerState<BusinessesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      // Load more businesses
    }
  }

  void _onSearchChanged(String query) {
    // Search businesses
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh businesses
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Search Bar
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppTheme.spacing16,
                  vertical: AppTheme.spacing12,
                ),
                color: AppTheme.surfaceColor,
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search businesses...',
                    hintStyle: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                    prefixIcon: const Icon(Icons.search, size: 20),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () {
                              _searchController.clear();
                              _onSearchChanged('');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppTheme.backgroundColor,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing12,
                      vertical: AppTheme.spacing10,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                      borderSide: BorderSide(
                        color: AppTheme.thinBorderColor,
                        width: AppTheme.thinBorderWidth,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                      borderSide: BorderSide(
                        color: AppTheme.thinBorderColor,
                        width: AppTheme.thinBorderWidth,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                      borderSide: BorderSide(
                        color: AppTheme.primaryColor,
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Businesses List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                    child: _buildBusinessCard(index),
                  );
                },
                childCount: 5, // Mock count
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBusinessCard(int index) {
    final mockBusinesses = [
      {
        'name': 'TechStart Rwanda',
        'industry': 'Fintech',
        'location': 'Kigali, Rwanda',
        'fundingGoal': '500M RWF',
        'equityOffered': '15%',
        'stage': 'Series A',
        'isVerified': true,
      },
      {
        'name': 'AgriTech Solutions',
        'industry': 'Agritech',
        'location': 'Kigali, Rwanda',
        'fundingGoal': '300M RWF',
        'equityOffered': '20%',
        'stage': 'Seed',
        'isVerified': true,
      },
      {
        'name': 'HealthTech Innovations',
        'industry': 'HealthTech',
        'location': 'Kigali, Rwanda',
        'fundingGoal': '750M RWF',
        'equityOffered': '12%',
        'stage': 'Series A',
        'isVerified': true,
      },
      {
        'name': 'EduTech Africa',
        'industry': 'EdTech',
        'location': 'Kigali, Rwanda',
        'fundingGoal': '200M RWF',
        'equityOffered': '25%',
        'stage': 'Pre-Seed',
        'isVerified': false,
      },
      {
        'name': 'Green Energy Co.',
        'industry': 'Clean Energy',
        'location': 'Kigali, Rwanda',
        'fundingGoal': '1B RWF',
        'equityOffered': '18%',
        'stage': 'Series A',
        'isVerified': true,
      },
    ];

    final business = mockBusinesses[index % mockBusinesses.length];

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _navigateToBusinessProfile(business);
          },
          borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Business Header
                Row(
                  children: [
                    // Logo/Avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
                          child: Text(
                            (business['name'] as String).substring(0, 1).toUpperCase(),
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (business['isVerified'] as bool)
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: AppTheme.surfaceColor, width: 1.5),
                              ),
                              child: const Icon(
                                Icons.verified,
                                size: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: AppTheme.spacing12),
                    // Business Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            business['name'] as String,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            business['industry'] as String,
                            style: AppTheme.bodySmall.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 12,
                                color: AppTheme.textSecondaryColor,
                              ),
                              const SizedBox(width: 3),
                              Expanded(
                                child: Text(
                                business['location'] as String,
                                style: AppTheme.bodySmall.copyWith(
                                  color: AppTheme.textSecondaryColor,
                                    fontSize: 11,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Stage Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing6,
                        vertical: AppTheme.spacing3,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius6),
                      ),
                      child: Text(
                        business['stage'] as String,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                // Funding Details
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing10),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                    border: Border.all(
                      color: AppTheme.primaryColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildFundingDetail(
                              'Funding Goal',
                              business['fundingGoal'] as String,
                              Icons.monetization_on,
                              Colors.green,
                            ),
                          ),
                          Expanded(
                            child: _buildFundingDetail(
                              'Equity Offered',
                              business['equityOffered'] as String,
                              Icons.pie_chart,
                              Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFundingDetail(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(
          icon,
          size: 16,
          color: color,
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: AppTheme.bodySmall.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimaryColor,
            fontSize: 12,
          ),
        ),
        Text(
          label,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textSecondaryColor,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  void _showContactDialog(Map<String, dynamic> business) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Contact ${business['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose how you would like to contact this business:',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: AppTheme.spacing16),
              _buildContactOption(
                icon: Icons.email,
                title: 'Send Email',
                subtitle: 'Contact via email',
                onTap: () {
                  Navigator.of(context).pop();
                  _showEmailDialog(business);
                },
              ),
              const SizedBox(height: AppTheme.spacing8),
              _buildContactOption(
                icon: Icons.phone,
                title: 'Call Business',
                subtitle: 'Direct phone call',
                onTap: () {
                  Navigator.of(context).pop();
                  _showPhoneDialog(business);
                },
              ),
              const SizedBox(height: AppTheme.spacing8),
              _buildContactOption(
                icon: Icons.message,
                title: 'Send Message',
                subtitle: 'In-app messaging',
                onTap: () {
                  Navigator.of(context).pop();
                  _showMessageDialog(business);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
      child: Container(
        padding: const EdgeInsets.all(AppTheme.spacing12),
        decoration: BoxDecoration(
          color: AppTheme.backgroundColor,
          borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
          border: Border.all(
            color: AppTheme.thinBorderColor,
            width: AppTheme.thinBorderWidth,
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: AppTheme.primaryColor,
              size: 20,
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTheme.bodyMedium.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppTheme.textPrimaryColor,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
          ],
        ),
      ),
    );
  }

  void _showEmailDialog(Map<String, dynamic> business) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Email ${business['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Text(
            'Email functionality would be implemented here. This would open the user\'s email client with a pre-filled message to the business.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showPhoneDialog(Map<String, dynamic> business) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Call ${business['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Text(
            'Phone calling functionality would be implemented here. This would initiate a call to the business contact number.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMessageDialog(Map<String, dynamic> business) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Message ${business['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Text(
            'In-app messaging functionality would be implemented here. This would open a chat interface with the business.',
            style: AppTheme.bodyMedium.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'OK',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _navigateToBusinessProfile(Map<String, dynamic> businessData) {
    // Convert the mock data to Business model
    final business = Business(
      id: businessData['name'] as String, // Using name as ID for mock data
      name: businessData['name'] as String,
      industry: businessData['industry'] as String,
      location: businessData['location'] as String,
      description: 'A promising ${businessData['industry']} company looking to revolutionize the market with innovative solutions and strong growth potential.',
      stage: businessData['stage'] as String,
      fundingGoal: businessData['fundingGoal'] as String,
      equityOffered: businessData['equityOffered'] as String,
      website: 'https://${(businessData['name'] as String).toLowerCase().replaceAll(' ', '')}.com',
      email: 'contact@${(businessData['name'] as String).toLowerCase().replaceAll(' ', '')}.com',
      phone: '+250 123 456 789',
      isVerified: businessData['isVerified'] as bool,
      rating: 4.5,
      totalReviews: 25,
      totalInvestors: 15,
      fundingProgress: 65.0,
      expectedReturn: 18.5,
      riskLevel: 3.2,
      totalInvestmentValue: 250000000, // 250M RWF
      tags: ['Innovation', 'Growth', 'Technology'],
      images: [],
      foundedDate: '2020-01-01',
      teamSize: '10-20 employees',
      businessModel: 'B2B SaaS Platform',
      keyMetrics: [
        'Monthly recurring revenue: 15M RWF',
        'Customer acquisition cost: 2M RWF',
        'Customer lifetime value: 25M RWF',
        'Churn rate: 5%',
      ],
      financials: {
        'revenue': 150000000,
        'expenses': 120000000,
        'profit': 30000000,
      },
      achievements: [
        'Winner of Tech Innovation Award 2023',
        'Featured in Top 10 Startups Rwanda',
        'Partnership with major corporations',
      ],
      socialLinks: {
        'linkedin': 'https://linkedin.com/company/${(businessData['name'] as String).toLowerCase().replaceAll(' ', '')}',
        'twitter': 'https://twitter.com/${(businessData['name'] as String).toLowerCase().replaceAll(' ', '')}',
      },
      nextMilestone: 'Expand to 3 new markets by end of 2024',
      useOfFunds: 'Product development (40%), Marketing (30%), Team expansion (20%), Operations (10%)',
      exitStrategy: 'IPO or acquisition by major tech company within 5-7 years',
      competitiveAdvantage: 'Proprietary technology, strong team, first-mover advantage in local market',
      targetMarkets: ['Rwanda', 'East Africa', 'Global'],
      businessPlan: 'Comprehensive 5-year growth strategy with clear milestones',
      pitchDeck: 'Professional presentation available upon request',
      demoVideo: 'Product demonstration video showcasing key features',
      isActive: true,
      createdAt: DateTime(2020, 1, 1),
      updatedAt: DateTime.now(),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BusinessProfileScreen(business: business),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: AppTheme.spacing8),
        ...children,
      ],
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w500,
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
