import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/feed_provider.dart';
import '../../domain/models/post.dart';
import 'opportunity_details_screen.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  ConsumerState<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(feedProvider.notifier).loadMorePosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: RefreshIndicator(
        onRefresh: () => ref.read(feedProvider.notifier).refreshFeed(),
        child: Consumer(
          builder: (context, ref, child) {
            final feedState = ref.watch(feedProvider);
            
            return feedState.isLoading && feedState.posts.isEmpty
                ? _buildLoadingSkeleton()
                : CustomScrollView(
                    controller: _scrollController,
                    slivers: [
                      // Posts Section
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index < feedState.posts.length) {
                              return _buildPostCard(feedState.posts[index]);
                            }
                            return null;
                          },
                          childCount: feedState.posts.length,
                        ),
                      ),
                      
                      // Loading indicator for pagination
                      if (feedState.isLoading && feedState.posts.isNotEmpty)
                        SliverToBoxAdapter(
                          child: _buildLoadingSkeleton(),
                        ),
                    ],
                  );
          },
        ),
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppTheme.spacing16),
      child: Column(
        children: List.generate(3, (index) => Container(
          margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
          padding: const EdgeInsets.all(AppTheme.spacing16),
          decoration: BoxDecoration(
            color: AppTheme.surfaceColor,
            borderRadius: BorderRadius.circular(AppTheme.borderRadius12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.thinBorderColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacing12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 16,
                          width: 120,
                          color: AppTheme.thinBorderColor,
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 12,
                          width: 80,
                          color: AppTheme.thinBorderColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppTheme.spacing16),
              Container(
                height: 150, // Reduced from 200 to 150
                width: double.infinity,
                color: AppTheme.thinBorderColor,
              ),
              const SizedBox(height: AppTheme.spacing16),
              Container(
                height: 14,
                width: double.infinity,
                color: AppTheme.thinBorderColor,
              ),
            ],
          ),
        )),
      ),
    );
  }

  Widget _buildPostCard(Post post) {
    return GestureDetector(
      onTap: () {
        if (post.isInvestmentOpportunity) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => OpportunityDetailsScreen(opportunity: post),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppTheme.spacing16),
        decoration: const BoxDecoration(
          color: AppTheme.surfaceColor,
          border: Border(
            bottom: BorderSide(
              color: AppTheme.thinBorderColor,
              width: 0.5,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Post Header
            _buildPostHeader(post),
            
            // Post Image(s)
            if (post.imageUrls.isNotEmpty)
              _buildPostImages(post),
            
            // Investment Details (if it's an investment opportunity)
            if (post.isInvestmentOpportunity)
              _buildInvestmentDetails(post),
            
            // Post Actions (Like, Comment, Share)
            _buildPostActions(post),
            
            // Post Stats
          _buildPostStats(post),
          
          // Post Caption
          if (post.content != null && post.content!.isNotEmpty)
            _buildPostCaption(post),
          
          // Time Posted
          _buildTimePosted(post),
        ],
      ),
    ),
    );
  }

  Widget _buildPostHeader(Post post) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacing12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: AppTheme.primaryColor.withOpacity(0.1),
            child: Text(
              post.userName.isNotEmpty ? post.userName[0].toUpperCase() : 'U',
              style: AppTheme.titleMedium.copyWith(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: AppTheme.spacing8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.userName,
                      style: AppTheme.bodyMedium.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (post.isVerified) ...[
                      const SizedBox(width: AppTheme.spacing4),
                      const Icon(
                        Icons.verified,
                        size: 16,
                        color: AppTheme.primaryColor,
                      ),
                    ],
                  ],
                ),
                if (post.location != null)
                  Text(
                    post.location!,
                    style: AppTheme.bodySmall.copyWith(
                      color: AppTheme.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) => _handlePostMenuAction(value, post),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    Icon(Icons.share, size: 20),
                    SizedBox(width: 8),
                    Text('Share'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'bookmark',
                child: Row(
                  children: [
                    Icon(Icons.bookmark_border, size: 20),
                    SizedBox(width: 8),
                    Text('Bookmark'),
                  ],
                ),
              ),
            ],
            child: const Icon(
              Icons.more_vert,
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostImages(Post post) {
    if (post.imageUrls.length == 1) {
      return AspectRatio(
        aspectRatio: 1,
        child: Image.network(
          post.imageUrls.first,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: AppTheme.thinBorderColor,
              child: const Icon(
                Icons.image_not_supported,
                color: AppTheme.textSecondaryColor,
                size: 48,
              ),
            );
          },
        ),
      );
    } else {
      return SizedBox(
        height: 300,
        child: PageView.builder(
          itemCount: post.imageUrls.length,
          itemBuilder: (context, index) {
            return Image.network(
              post.imageUrls[index],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppTheme.thinBorderColor,
                  child: const Icon(
                    Icons.image_not_supported,
                    color: AppTheme.textSecondaryColor,
                    size: 48,
                  ),
                );
              },
            );
          },
        ),
      );
    }
  }

  Widget _buildInvestmentDetails(Post post) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacing12),
      padding: const EdgeInsets.all(AppTheme.spacing12),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(AppTheme.borderRadius8),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: AppTheme.primaryColor,
                size: 20,
              ),
              const SizedBox(width: AppTheme.spacing8),
              Text(
                'Investment Opportunity',
                style: AppTheme.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppTheme.spacing12),
          if (post.companyName != null)
            _buildInvestmentRow('Company', post.companyName!),
          if (post.industry != null)
            _buildInvestmentRow('Industry', post.industry!),
          if (post.investmentStage != null)
            _buildInvestmentRow('Stage', post.investmentStage!),
          if (post.fundingGoal != null)
            _buildInvestmentRow('Funding Goal', post.fundingGoal!),
          if (post.equityOffered != null)
            _buildInvestmentRow('Equity Offered', post.equityOffered!),
          if (post.expectedReturn != null)
            _buildInvestmentRow('Expected Return', post.expectedReturn!),
        ],
      ),
    );
  }

  Widget _buildInvestmentRow(String label, String value) {
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
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostActions(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacing12,
        vertical: AppTheme.spacing8,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => ref.read(feedProvider.notifier).likePost(post.id),
            child: Icon(
              post.isLiked ? Icons.favorite : Icons.favorite_border,
              color: post.isLiked ? Colors.red : AppTheme.textPrimaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          GestureDetector(
            onTap: () {
              // TODO: Navigate to comments screen
            },
            child: const Icon(
              Icons.chat_bubble_outline,
              color: AppTheme.textPrimaryColor,
              size: 24,
            ),
          ),
          const SizedBox(width: AppTheme.spacing16),
          GestureDetector(
            onTap: () => ref.read(feedProvider.notifier).sharePost(post.id),
            child: const Icon(
              Icons.share_outlined,
              color: AppTheme.textPrimaryColor,
              size: 24,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => ref.read(feedProvider.notifier).bookmarkPost(post.id),
            child: Icon(
              post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
              color: post.isBookmarked ? AppTheme.primaryColor : AppTheme.textPrimaryColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostStats(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (post.likesCount > 0)
            Text(
              '${post.likesCount} likes',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          if (post.commentsCount > 0) ...[
            const SizedBox(height: AppTheme.spacing4),
            Text(
              'View all ${post.commentsCount} comments',
              style: AppTheme.bodySmall.copyWith(
                color: AppTheme.textSecondaryColor,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPostCaption(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing12),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '${post.userName} ',
              style: AppTheme.bodyMedium.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            TextSpan(
              text: post.content!,
              style: AppTheme.bodyMedium.copyWith(
                color: AppTheme.textPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePosted(Post post) {
    final timeAgo = _getTimeAgo(post.createdAt);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppTheme.spacing12,
        AppTheme.spacing4,
        AppTheme.spacing12,
        AppTheme.spacing12,
      ),
      child: Text(
        timeAgo,
        style: AppTheme.bodySmall.copyWith(
          color: AppTheme.textSecondaryColor,
        ),
      ),
    );
  }

  void _handlePostMenuAction(String action, Post post) {
    switch (action) {
      case 'share':
        ref.read(feedProvider.notifier).sharePost(post.id);
        break;
      case 'bookmark':
        ref.read(feedProvider.notifier).bookmarkPost(post.id);
        break;
    }
  }

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays >= 365) {
      final years = (difference.inDays / 365).floor();
      return years == 1 ? '1y' : '${years}y';
    } else if (difference.inDays >= 30) {
      final months = (difference.inDays / 30).floor();
      return months == 1 ? '1mo' : '${months}mo';
    } else if (difference.inDays >= 7) {
      final weeks = (difference.inDays / 7).floor();
      return weeks == 1 ? '1w' : '${weeks}w';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
