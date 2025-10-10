import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../../shared/widgets/secondary_button.dart';
import '../../../../shared/utils/snackbar_helper.dart';
import '../../domain/models/post.dart';

class OpportunityDetailsScreen extends ConsumerStatefulWidget {
  final Post opportunity;

  const OpportunityDetailsScreen({
    super.key,
    required this.opportunity,
  });

  @override
  ConsumerState<OpportunityDetailsScreen> createState() => _OpportunityDetailsScreenState();
}

class _OpportunityDetailsScreenState extends ConsumerState<OpportunityDetailsScreen> {
  bool _isApplying = false;
  bool _isBookmarked = false;

  @override
  void initState() {
    super.initState();
    _isBookmarked = widget.opportunity.isBookmarked;
  }

  void _handleApply() async {
    setState(() => _isApplying = true);
    
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => _isApplying = false);
      showIntentionSnackBar(
        context,
        'Application submitted successfully! We\'ll contact you soon.',
        intent: SnackBarIntent.success,
      );
    }
  }

  void _handleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    
    showIntentionSnackBar(
      context,
      _isBookmarked ? 'Added to bookmarks' : 'Removed from bookmarks',
      intent: SnackBarIntent.success,
    );
  }

  void _handleShare() {
    final shareText = '''
🚀 Investment Opportunity: ${widget.opportunity.companyName ?? 'Startup'}

💰 Investment Amount: ${widget.opportunity.investmentAmount}
🎯 Funding Goal: ${widget.opportunity.fundingGoal}
📈 Expected Return: ${widget.opportunity.expectedReturn}
⏰ Duration: ${widget.opportunity.investmentDuration}

${widget.opportunity.content ?? ''}

#InvestmentOpportunity #StartupFunding #ShoraMarkets
    ''';
    
    Share.share(shareText);
  }

  void _handleContact() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'investments@shoramarkets.com',
      query: 'subject=Investment Inquiry - ${widget.opportunity.companyName ?? 'Startup'}',
    );
    
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      showIntentionSnackBar(
        context,
        'Could not open email client',
        intent: SnackBarIntent.error,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Opportunity Details',
          style: AppTheme.titleMedium,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _handleBookmark,
            icon: Icon(
              _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: _isBookmarked ? AppTheme.primaryColor : AppTheme.textSecondaryColor,
            ),
          ),
          IconButton(
            onPressed: _handleShare,
            icon: const Icon(
              Icons.share,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image
            if (widget.opportunity.imageUrls.isNotEmpty)
              Container(
                height: 250,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.opportunity.imageUrls.first),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Name and Stage
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.opportunity.companyName ?? 'Investment Opportunity',
                          style: AppTheme.headlineLarge,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppTheme.spacing12,
                          vertical: AppTheme.spacing4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
                        ),
                        child: Text(
                          widget.opportunity.investmentStage ?? 'Early Stage',
                          style: AppTheme.bodySmall.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacing8),
                  
                  // Industry
                  if (widget.opportunity.industry != null)
                    Text(
                      widget.opportunity.industry!,
                      style: AppTheme.bodyMedium.copyWith(
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  
                  const SizedBox(height: AppTheme.spacing16),
                  
                  // Investment Details Cards
                  _buildInvestmentDetails(),
                  
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Description
                  if (widget.opportunity.content != null) ...[
                    Text(
                      'About This Opportunity',
                      style: AppTheme.titleMedium,
                    ),
                    const SizedBox(height: AppTheme.spacing8),
                    Text(
                      widget.opportunity.content!,
                      style: AppTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppTheme.spacing24),
                  ],
                  
                  // Key Highlights
                  _buildKeyHighlights(),
                  
                  const SizedBox(height: AppTheme.spacing24),
                  
                  // Action Buttons
                  _buildActionButtons(),
                  
                  const SizedBox(height: AppTheme.spacing32),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInvestmentDetails() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildDetailRow(
            'Investment Amount',
            widget.opportunity.investmentAmount ?? 'Not specified',
            Icons.attach_money,
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildDetailRow(
            'Funding Goal',
            widget.opportunity.fundingGoal ?? 'Not specified',
            Icons.trending_up,
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildDetailRow(
            'Equity Offered',
            widget.opportunity.equityOffered ?? 'Not specified',
            Icons.pie_chart,
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildDetailRow(
            'Expected Return',
            widget.opportunity.expectedReturn ?? 'Not specified',
            Icons.show_chart,
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildDetailRow(
            'Duration',
            widget.opportunity.investmentDuration ?? 'Not specified',
            Icons.schedule,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: AppTheme.primaryColor,
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTheme.bodySmall.copyWith(
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              const SizedBox(height: AppTheme.spacing2),
              Text(
                value,
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKeyHighlights() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.star,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Key Highlights',
                style: AppTheme.titleMedium.copyWith(
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          _buildHighlightItem('✅ Verified Investment Opportunity'),
          _buildHighlightItem('📊 Transparent Financial Projections'),
          _buildHighlightItem('🤝 Experienced Management Team'),
          _buildHighlightItem('🌍 Market Growth Potential'),
          _buildHighlightItem('📈 Track Record of Success'),
        ],
      ),
    );
  }

  Widget _buildHighlightItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppTheme.spacing8),
      child: Text(
        text,
        style: AppTheme.bodyMedium,
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: SecondaryButton(
            label: 'Contact Us',
            onPressed: _handleContact,
            icon: Icons.email,
          ),
        ),
        const SizedBox(width: AppTheme.spacing12),
        Expanded(
          child: PrimaryButton(
            label: _isApplying ? 'Applying...' : 'Apply Now',
            isLoading: _isApplying,
            onPressed: _isApplying ? null : _handleApply,
          ),
        ),
      ],
    );
  }
}
