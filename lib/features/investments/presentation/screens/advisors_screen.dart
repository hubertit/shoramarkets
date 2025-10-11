import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../advisors/presentation/screens/advisor_profile_screen.dart';
import '../../../advisors/domain/models/advisor.dart';

class AdvisorsScreen extends ConsumerStatefulWidget {
  const AdvisorsScreen({super.key});

  @override
  ConsumerState<AdvisorsScreen> createState() => _AdvisorsScreenState();
}

class _AdvisorsScreenState extends ConsumerState<AdvisorsScreen> {
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
      // Load more advisors
    }
  }

  void _onSearchChanged(String query) {
    // Search advisors
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () async {
          // Refresh advisors
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
                    hintText: 'Search advisors...',
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
            // Advisors List
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
                    child: _buildAdvisorCard(index),
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

  Widget _buildAdvisorCard(int index) {
    final mockAdvisors = [
      {
        'name': 'Dr. Jean Paul Nkurunziza',
        'location': 'Kigali, Rwanda',
        'specialization': 'Investment Strategy & Risk Management',
        'experience': '15+ years',
        'clientsHelped': '200+',
        'successRate': '94%',
        'isVerified': true,
        'certifications': ['CFA', 'FRM', 'MBA'],
      },
      {
        'name': 'Marie Claire Uwimana',
        'location': 'Kigali, Rwanda',
        'specialization': 'Startup Advisory & Growth Strategy',
        'experience': '12+ years',
        'clientsHelped': '150+',
        'successRate': '91%',
        'isVerified': true,
        'certifications': ['CPA', 'CISA', 'MBA'],
      },
      {
        'name': 'Patrick Nsengimana',
        'location': 'Kigali, Rwanda',
        'specialization': 'Financial Planning & Portfolio Management',
        'experience': '18+ years',
        'clientsHelped': '300+',
        'successRate': '96%',
        'isVerified': true,
        'certifications': ['CFP', 'CFA', 'PhD Finance'],
      },
      {
        'name': 'Grace Mukamana',
        'location': 'Kigali, Rwanda',
        'specialization': 'Market Analysis & Investment Research',
        'experience': '10+ years',
        'clientsHelped': '120+',
        'successRate': '89%',
        'isVerified': false,
        'certifications': ['CFA', 'FRM'],
      },
      {
        'name': 'David Nkurunziza',
        'location': 'Kigali, Rwanda',
        'specialization': 'Alternative Investments & Private Equity',
        'experience': '20+ years',
        'clientsHelped': '250+',
        'successRate': '97%',
        'isVerified': true,
        'certifications': ['CAIA', 'CFA', 'MBA'],
      },
    ];

    final advisor = mockAdvisors[index % mockAdvisors.length];

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
            _navigateToAdvisorProfile(advisor);
          },
          borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
          child: Padding(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Advisor Header
                Row(
                  children: [
                    // Avatar
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: AppTheme.primaryColor,
                          child: Text(
                            (advisor['name'] as String).substring(0, 1).toUpperCase(),
                            style: AppTheme.bodyMedium.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (advisor['isVerified'] as bool)
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
                    // Advisor Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            advisor['name'] as String,
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            advisor['specialization'] as String,
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
                                  advisor['location'] as String,
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
                    // Success Rate
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          advisor['successRate'] as String,
                          style: AppTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.successColor,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          'Success',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondaryColor,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                // Advisor Stats
                Row(
                  children: [
                    Expanded(
                      child: _buildStatItem(
                        'Experience',
                        advisor['experience'] as String,
                        Icons.work,
                        Colors.blue,
                      ),
                    ),
                    Expanded(
                      child: _buildStatItem(
                        'Clients',
                        advisor['clientsHelped'] as String,
                        Icons.people,
                        Colors.green,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing12),
                // Certifications
                Wrap(
                  spacing: AppTheme.spacing8,
                  runSpacing: AppTheme.spacing4,
                  children: (advisor['certifications'] as List<String>).map((cert) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppTheme.spacing8,
                        vertical: AppTheme.spacing4,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        cert,
                        style: AppTheme.bodySmall.copyWith(
                          color: AppTheme.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppTheme.spacing12),
                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          _showContactDialog(advisor);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(
                            color: AppTheme.thinBorderColor,
                            width: AppTheme.thinBorderWidth,
                          ),
                          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                          ),
                        ),
                        child: Text(
                          'Contact',
                          style: AppTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textPrimaryColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppTheme.spacing8),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the contact dialog
                          _navigateToAdvisorProfile(advisor);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                          ),
                        ),
                        child: Text(
                          'View Profile',
                          style: AppTheme.bodySmall.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing6),
      child: Column(
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
      ),
    );
  }

  void _showContactDialog(Map<String, dynamic> advisor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Contact ${advisor['name']}',
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
                'Choose how you would like to contact this advisor:',
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
                  _showEmailDialog(advisor);
                },
              ),
              const SizedBox(height: AppTheme.spacing8),
              _buildContactOption(
                icon: Icons.phone,
                title: 'Call Advisor',
                subtitle: 'Direct phone call',
                onTap: () {
                  Navigator.of(context).pop();
                  _showPhoneDialog(advisor);
                },
              ),
              const SizedBox(height: AppTheme.spacing8),
              _buildContactOption(
                icon: Icons.message,
                title: 'Send Message',
                subtitle: 'In-app messaging',
                onTap: () {
                  Navigator.of(context).pop();
                  _showMessageDialog(advisor);
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

  void _showEmailDialog(Map<String, dynamic> advisor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Email ${advisor['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Text(
            'Email functionality would be implemented here. This would open the user\'s email client with a pre-filled message to the advisor.',
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

  void _showPhoneDialog(Map<String, dynamic> advisor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Call ${advisor['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Text(
            'Phone calling functionality would be implemented here. This would initiate a call to the advisor\'s contact number.',
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

  void _showMessageDialog(Map<String, dynamic> advisor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppTheme.surfaceColor,
          title: Text(
            'Message ${advisor['name']}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          content: Text(
            'In-app messaging functionality would be implemented here. This would open a chat interface with the advisor.',
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

  void _navigateToAdvisorProfile(Map<String, dynamic> advisorData) {
    // Convert the mock data to Advisor model
    final advisor = Advisor(
      id: advisorData['name'] as String, // Using name as ID for mock data
      name: advisorData['name'] as String,
      specialization: advisorData['specialization'] as String,
      location: advisorData['location'] as String,
      experience: advisorData['experience'] as String,
      clientsHelped: advisorData['clientsHelped'] as String,
      successRate: advisorData['successRate'] as String,
      isVerified: advisorData['isVerified'] as bool,
      certifications: List<String>.from(advisorData['certifications'] as List<String>),
      // Add default values for required fields
      email: 'advisor@example.com',
      phone: '+250 123 456 789',
      bio: 'Experienced financial advisor with expertise in investment strategy and risk management.',
      rating: 4.8,
      totalReviews: 150,
      followers: 1200,
      following: 300,
      profileImage: null,
      coverImage: null,
      isOnline: true,
      lastActive: DateTime.now(),
      languages: ['English', 'Kinyarwanda'],
      education: ['MBA Finance', 'CFA Certification'],
      workExperience: [
        'Senior Investment Advisor at ABC Capital (2018-2023)',
        'Financial Analyst at XYZ Bank (2015-2018)',
      ],
      achievements: [
        'Top Performer 2022',
        'Client Satisfaction Award 2021',
      ],
      socialLinks: {
        'linkedin': 'https://linkedin.com/in/advisor',
        'twitter': 'https://twitter.com/advisor',
      },
      availability: {
        'monday': {'start': '09:00', 'end': '17:00'},
        'tuesday': {'start': '09:00', 'end': '17:00'},
        'wednesday': {'start': '09:00', 'end': '17:00'},
        'thursday': {'start': '09:00', 'end': '17:00'},
        'friday': {'start': '09:00', 'end': '17:00'},
      },
      consultationFee: 50000, // 50,000 RWF
      currency: 'RWF',
      isAvailable: true,
      responseTime: '2 hours',
      joinedDate: DateTime(2020, 1, 1),
    );

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AdvisorProfileScreen(advisor: advisor),
      ),
    );
  }
}
