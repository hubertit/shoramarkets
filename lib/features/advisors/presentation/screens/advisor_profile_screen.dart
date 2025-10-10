import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/models/advisor.dart';

class AdvisorProfileScreen extends ConsumerStatefulWidget {
  final Advisor advisor;

  const AdvisorProfileScreen({
    super.key,
    required this.advisor,
  });

  @override
  ConsumerState<AdvisorProfileScreen> createState() => _AdvisorProfileScreenState();
}

class _AdvisorProfileScreenState extends ConsumerState<AdvisorProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFollowing = false;
  String _chartPeriod = 'Month'; // 'Month', 'Quarter', 'Year'

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          widget.advisor.name,
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          // Profile Header
          SliverToBoxAdapter(
            child: _buildProfileHeader(),
          ),
          // Stats and Follow Button
          SliverToBoxAdapter(
            child: _buildStatsAndActions(),
          ),
          // Bio Section
          SliverToBoxAdapter(
            child: _buildBioSection(),
          ),
          // Tab Bar
          SliverToBoxAdapter(
            child: Container(
              color: AppTheme.surfaceColor,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppTheme.primaryColor,
                labelColor: AppTheme.primaryColor,
                unselectedLabelColor: AppTheme.textSecondaryColor,
                labelStyle: AppTheme.bodySmall.copyWith(fontWeight: FontWeight.w600),
                tabs: const [
                  Tab(text: 'Performance'),
                  Tab(text: 'Cases'),
                  Tab(text: 'About'),
                ],
              ),
            ),
          ),
          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildPerformanceTab(),
                _buildCasesTab(),
                _buildAboutTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Row(
        children: [
          // Profile Picture
          Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: AppTheme.primaryColor,
                child: Text(
                  widget.advisor.name.substring(0, 1).toUpperCase(),
                  style: AppTheme.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (widget.advisor.isVerified)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppTheme.surfaceColor, width: 2),
                    ),
                    child: const Icon(
                      Icons.verified,
                      size: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: AppTheme.spacing16),
          // Profile Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.advisor.name,
                  style: AppTheme.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.advisor.specialization,
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
                      size: 16,
                      color: AppTheme.textSecondaryColor,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.advisor.location,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Rating
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      size: 16,
                      color: Colors.amber,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      widget.advisor.rating.toString(),
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${widget.advisor.totalReviews} reviews)',
                      style: AppTheme.bodySmall.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsAndActions() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing16),
      child: Column(
        children: [
          // Stats Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem('Clients', widget.advisor.totalClients.toString()),
              _buildStatItem('Success Rate', '${widget.advisor.successRate.toStringAsFixed(1)}%'),
              _buildStatItem('Experience', widget.advisor.experience),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isFollowing = !_isFollowing;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isFollowing ? AppTheme.surfaceColor : AppTheme.primaryColor,
                    foregroundColor: _isFollowing ? AppTheme.textPrimaryColor : Colors.white,
                    side: BorderSide(
                      color: _isFollowing ? AppTheme.thinBorderColor : AppTheme.primaryColor,
                      width: AppTheme.thinBorderWidth,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: AppTheme.spacing8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                    ),
                  ),
                  child: Text(
                    _isFollowing ? 'Following' : 'Follow',
                    style: AppTheme.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppTheme.spacing8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showContactOptions();
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
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildBioSection() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About ${widget.advisor.name}',
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppTheme.spacing8),
          Text(
            widget.advisor.bio,
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textPrimaryColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Performance Overview
          _buildPerformanceOverview(),
          const SizedBox(height: AppTheme.spacing24),
          // Performance Charts
          _buildPerformanceCharts(),
        ],
      ),
    );
  }

  Widget _buildPerformanceOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Overview',
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        Row(
          children: [
            Expanded(
              child: _buildPerformanceCard(
                title: 'Total Clients',
                value: widget.advisor.totalClients.toString(),
                subtitle: 'Clients advised',
                icon: Icons.people,
                color: Colors.blue,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildPerformanceCard(
                title: 'Success Rate',
                value: '${widget.advisor.successRate.toStringAsFixed(1)}%',
                subtitle: 'Advisory success rate',
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing12),
        Row(
          children: [
            Expanded(
              child: _buildPerformanceCard(
                title: 'Avg Return',
                value: '${widget.advisor.averageReturn.toStringAsFixed(1)}%',
                subtitle: 'Average return',
                icon: Icons.percent,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: AppTheme.spacing12),
            Expanded(
              child: _buildPerformanceCard(
                title: 'Satisfaction',
                value: '${widget.advisor.clientSatisfaction.toStringAsFixed(1)}/5.0',
                subtitle: 'Client satisfaction',
                icon: Icons.star,
                color: Colors.purple,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPerformanceCard({
    required String title,
    required String value,
    required String subtitle,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
        border: Border.all(
          color: AppTheme.thinBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppTheme.spacing8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                ),
                child: Icon(
                  icon,
                  color: color,
                  size: 20,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          Text(
            value,
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: AppTheme.spacing4),
          Text(
            title,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildPerformanceCharts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Performance Trends',
          style: AppTheme.titleMedium.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppTheme.spacing16),
        Container(
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
            border: Border.all(
              color: AppTheme.thinBorderColor,
              width: 1,
            ),
          ),
          child: Column(
            children: [
              _buildChartItem(
                title: 'Advisory Success Rate',
                percentage: widget.advisor.successRate.toInt(),
                color: Colors.green,
                description: 'Successful advisory cases',
              ),
              const SizedBox(height: AppTheme.spacing16),
              _buildChartItem(
                title: 'Client Satisfaction',
                percentage: (widget.advisor.clientSatisfaction * 20).toInt(),
                color: Colors.blue,
                description: 'Average client rating',
              ),
              const SizedBox(height: AppTheme.spacing16),
              _buildChartItem(
                title: 'Return Performance',
                percentage: (widget.advisor.averageReturn / 2).toInt(),
                color: Colors.orange,
                description: 'Average return rate',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildChartItem({
    required String title,
    required int percentage,
    required Color color,
    required String description,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '$percentage%',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppTheme.spacing8),
        Container(
          height: 8,
          decoration: BoxDecoration(
            color: AppTheme.thinBorderColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage / 100,
            child: Container(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppTheme.spacing4),
        Text(
          description,
          style: AppTheme.bodySmall.copyWith(
            color: AppTheme.textSecondaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildCasesTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      itemCount: widget.advisor.recentCases.length,
      itemBuilder: (context, index) {
        final case_ = widget.advisor.recentCases[index];
        return Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
            border: Border.all(
              color: AppTheme.thinBorderColor,
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      case_.companyName,
                      style: AppTheme.titleMedium.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textPrimaryColor,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing8,
                      vertical: AppTheme.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: case_.status == 'Active' ? Colors.green : Colors.blue,
                      borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                    ),
                    child: Text(
                      case_.status,
                      style: AppTheme.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                case_.industry,
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppTheme.spacing12),
              Row(
                children: [
                  Expanded(
                    child: _buildCaseStat(
                      'Investment',
                      _formatCurrency(case_.investmentAmount),
                      Icons.monetization_on,
                    ),
                  ),
                  Expanded(
                    child: _buildCaseStat(
                      'Expected Return',
                      '${case_.expectedReturn.toStringAsFixed(1)}%',
                      Icons.trending_up,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing8),
              Text(
                'Date: ${_formatDate(case_.date)}',
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCaseStat(String label, String value, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 16,
              color: AppTheme.textSecondaryColor,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTheme.bodyMedium.copyWith(
            fontWeight: FontWeight.w600,
            color: AppTheme.textPrimaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAboutTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoCard(
            'Professional Information',
            [
              _buildInfoRow('Experience', widget.advisor.experience),
              _buildInfoRow('Education', widget.advisor.education),
              _buildInfoRow('Languages', widget.advisor.languages),
              _buildInfoRow('Join Date', widget.advisor.joinDate),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildInfoCard(
            'Performance Metrics',
            [
              _buildInfoRow('Total Clients', widget.advisor.totalClients.toString()),
              _buildInfoRow('Success Rate', '${widget.advisor.successRate.toStringAsFixed(1)}%'),
              _buildInfoRow('Average Return', '${widget.advisor.averageReturn.toStringAsFixed(1)}%'),
              _buildInfoRow('Client Satisfaction', '${widget.advisor.clientSatisfaction.toStringAsFixed(1)}/5.0'),
            ],
          ),
          const SizedBox(height: AppTheme.spacing16),
          _buildInfoCard(
            'Certifications',
            widget.advisor.certifications.map((cert) => 
              _buildCertificationItem(cert)
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
        border: Border.all(
          color: AppTheme.thinBorderColor,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTheme.titleMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: AppTheme.spacing12),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textPrimaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCertificationItem(Certification cert) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacing8),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            cert.name,
            style: AppTheme.bodyMedium.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${cert.issuer} • ${cert.date}',
            style: AppTheme.bodySmall.copyWith(
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    } else {
      return amount.toStringAsFixed(0);
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _showContactOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.borderRadius16),
        ),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.textSecondaryColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: AppTheme.spacing16),
            Text(
              'Contact ${widget.advisor.name}',
              style: AppTheme.titleMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            const SizedBox(height: AppTheme.spacing24),
            if (widget.advisor.phone != null)
              ListTile(
                leading: const Icon(Icons.phone),
                title: Text('Call'),
                subtitle: Text(widget.advisor.phone!),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement call functionality
                },
              ),
            if (widget.advisor.email != null)
              ListTile(
                leading: const Icon(Icons.email),
                title: Text('Email'),
                subtitle: Text(widget.advisor.email!),
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement email functionality
                },
              ),
            ListTile(
              leading: const Icon(Icons.message),
              title: Text('Message'),
              subtitle: Text('Send a direct message'),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement messaging functionality
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showMoreOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.surfaceColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.borderRadius16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(AppTheme.spacing16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(
                'Share Profile',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement share functionality
              },
            ),
            ListTile(
              leading: const Icon(Icons.report),
              title: Text(
                'Report Advisor',
                style: AppTheme.bodyMedium.copyWith(
                  color: AppTheme.errorColor,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                // TODO: Implement report functionality
              },
            ),
          ],
        ),
      ),
    );
  }
}
