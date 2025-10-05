import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';

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
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(AppTheme.spacing16),
            color: AppTheme.surfaceColor,
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search advisors by name, specialization, or location...',
                hintStyle: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _onSearchChanged('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppTheme.backgroundColor,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
                  borderSide: BorderSide(
                    color: AppTheme.thinBorderColor,
                    width: AppTheme.thinBorderWidth,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
                  borderSide: BorderSide(
                    color: AppTheme.thinBorderColor,
                    width: AppTheme.thinBorderWidth,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
                  borderSide: BorderSide(
                    color: AppTheme.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
          // Advisors List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                // Refresh advisors
              },
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.all(AppTheme.spacing16),
                itemCount: 5, // Mock count
                itemBuilder: (context, index) {
                  return _buildAdvisorCard(index);
                },
              ),
            ),
          ),
        ],
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
            // Navigate to advisor profile
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
                          radius: 25,
                          backgroundColor: AppTheme.primaryColor,
                          child: Text(
                            (advisor['name'] as String).substring(0, 1).toUpperCase(),
                            style: AppTheme.titleMedium.copyWith(
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
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppTheme.surfaceColor, width: 2),
                              ),
                              child: const Icon(
                                Icons.verified,
                                size: 12,
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
                            style: AppTheme.titleMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            advisor['specialization'] as String,
                            style: AppTheme.bodyMedium.copyWith(
                              color: AppTheme.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 14,
                                color: AppTheme.textSecondaryColor,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                advisor['location'] as String,
                                style: AppTheme.bodySmall.copyWith(
                                  color: AppTheme.textSecondaryColor,
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
                          style: AppTheme.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.successColor,
                          ),
                        ),
                        Text(
                          'Success Rate',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppTheme.spacing16),
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
                        'Clients Helped',
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
                          _showAdvisorProfile(advisor);
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
      padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
      child: Column(
        children: [
          Icon(
            icon,
            size: 18,
            color: color,
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w700,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          Text(
            label,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondaryColor,
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

  void _showAdvisorProfile(Map<String, dynamic> advisor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: AppTheme.surfaceColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxHeight: 600),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(AppTheme.borderRadius16),
                      topRight: Radius.circular(AppTheme.borderRadius16),
                    ),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: AppTheme.primaryColor,
                        child: Text(
                          (advisor['name'] as String).substring(0, 1).toUpperCase(),
                          style: AppTheme.titleMedium.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              advisor['name'] as String,
                              style: AppTheme.titleMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                            Text(
                              advisor['specialization'] as String,
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: const Icon(Icons.close),
                        color: AppTheme.textSecondaryColor,
                      ),
                    ],
                  ),
                ),
                // Content
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppTheme.spacing16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailSection(
                          'Advisor Information',
                          [
                            _buildDetailRow('Specialization', advisor['specialization'] as String),
                            _buildDetailRow('Location', advisor['location'] as String),
                            _buildDetailRow('Experience', advisor['experience'] as String),
                            _buildDetailRow('Clients Helped', advisor['clientsHelped'] as String),
                            _buildDetailRow('Verification', advisor['isVerified'] ? 'Verified' : 'Not Verified'),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing16),
                        _buildDetailSection(
                          'Performance Stats',
                          [
                            _buildDetailRow('Success Rate', advisor['successRate'] as String),
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing16),
                        _buildDetailSection(
                          'Certifications',
                          [
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
                          ],
                        ),
                        const SizedBox(height: AppTheme.spacing16),
                        _buildDetailSection(
                          'About',
                          [
                            Text(
                              '${advisor['name']} is a highly experienced investment advisor specializing in ${advisor['specialization']}. With ${advisor['experience']} of experience, they have helped ${advisor['clientsHelped']} clients achieve their financial goals.',
                              style: AppTheme.bodyMedium.copyWith(
                                color: AppTheme.textPrimaryColor,
                                height: 1.4,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Footer
                Container(
                  padding: const EdgeInsets.all(AppTheme.spacing16),
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundColor,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(AppTheme.borderRadius16),
                      bottomRight: Radius.circular(AppTheme.borderRadius16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _showContactDialog(advisor);
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: AppTheme.thinBorderColor,
                              width: AppTheme.thinBorderWidth,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                            ),
                          ),
                          child: Text(
                            'Contact',
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacing12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                            ),
                          ),
                          child: Text(
                            'Close',
                            style: AppTheme.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
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
}
