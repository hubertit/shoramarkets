import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/post.dart';

class FeedState {
  final List<Post> posts;
  final bool isLoading;
  final String? error;
  final bool hasMorePosts;

  const FeedState({
    this.posts = const [],
    this.isLoading = false,
    this.error,
    this.hasMorePosts = true,
  });

  FeedState copyWith({
    List<Post>? posts,
    bool? isLoading,
    String? error,
    bool? hasMorePosts,
  }) {
    return FeedState(
      posts: posts ?? this.posts,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMorePosts: hasMorePosts ?? this.hasMorePosts,
    );
  }
}

class FeedNotifier extends StateNotifier<FeedState> {
  FeedNotifier() : super(const FeedState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      state = state.copyWith(
        isLoading: false,
        posts: _getMockPosts(),
        hasMorePosts: true,
      );
    }
  }

  Future<void> refreshFeed() async {
    state = state.copyWith(isLoading: true, error: null);
    
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      state = state.copyWith(
        isLoading: false,
        posts: _getMockPosts(),
        hasMorePosts: true,
      );
    }
  }

  Future<void> loadMorePosts() async {
    if (!state.hasMorePosts || state.isLoading) return;
    
    state = state.copyWith(isLoading: true);
    
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    if (mounted) {
      final newPosts = _getMockPosts();
      state = state.copyWith(
        isLoading: false,
        posts: [...state.posts, ...newPosts],
        hasMorePosts: false, // No more posts for demo
      );
    }
  }

  Future<void> likePost(String postId) async {
    // Optimistic update - change UI immediately
    final currentPost = state.posts.firstWhere((post) => post.id == postId);
    final isCurrentlyLiked = currentPost.isLiked;
    final currentLikesCount = currentPost.likesCount;
    
    // Update UI immediately
    final optimisticPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          isLiked: !isCurrentlyLiked,
          likesCount: isCurrentlyLiked ? currentLikesCount - 1 : currentLikesCount + 1,
        );
      }
      return post;
    }).toList();
    
    state = state.copyWith(posts: optimisticPosts);
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Keep the optimistic update for demo
  }

  Future<void> bookmarkPost(String postId) async {
    // Optimistic update - change UI immediately
    final currentPost = state.posts.firstWhere((post) => post.id == postId);
    final isCurrentlyBookmarked = currentPost.isBookmarked;
    final currentBookmarksCount = currentPost.bookmarksCount;
    
    // Update UI immediately
    final optimisticPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(
          isBookmarked: !isCurrentlyBookmarked,
          bookmarksCount: isCurrentlyBookmarked ? currentBookmarksCount - 1 : currentBookmarksCount + 1,
        );
      }
      return post;
    }).toList();
    
    state = state.copyWith(posts: optimisticPosts);
    
    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 500));
    
    // Keep the optimistic update for demo
  }

  void sharePost(String postId) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(sharesCount: post.sharesCount + 1);
      }
      return post;
    }).toList();
    
    state = state.copyWith(posts: updatedPosts);
  }

  void addComment(String postId, String content) {
    final updatedPosts = state.posts.map((post) {
      if (post.id == postId) {
        return post.copyWith(commentsCount: post.commentsCount + 1);
      }
      return post;
    }).toList();
    
    state = state.copyWith(posts: updatedPosts);
  }

  List<Post> _getMockPosts() {
    final now = DateTime.now();
    return [
      Post(
        id: '1',
        userId: '1',
        userName: 'TechStart Rwanda',
        userAvatar: null,
        content: '🚀 Exciting opportunity! We are raising 500M RWF for our fintech platform that is revolutionizing mobile payments in East Africa. Join us in building the future of financial inclusion!',
        imageUrls: [
          'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800', // Stock market chart
        ],
        createdAt: now.subtract(const Duration(hours: 2)),
        updatedAt: now.subtract(const Duration(hours: 2)),
        likesCount: 45,
        commentsCount: 12,
        sharesCount: 8,
        bookmarksCount: 23,
        isLiked: false,
        isBookmarked: false,
        hashtags: ['#fintech', '#investment', '#startup', '#rwanda'],
        location: 'Kigali, Rwanda',
        isVerified: true,
        isInvestmentOpportunity: true,
        investmentAmount: '500M RWF',
        investmentStage: 'Series A',
        industry: 'Fintech',
        companyName: 'TechStart Rwanda',
        fundingGoal: '500M RWF',
        equityOffered: '15%',
        expectedReturn: '25% annually',
        investmentDuration: '3-5 years',
      ),
      Post(
        id: '2',
        userId: '2',
        userName: 'AgriTech Solutions',
        userAvatar: null,
        content: '🌱 Looking for investors to scale our smart farming technology across Rwanda. We have already helped 500+ farmers increase yields by 40%. Ready to expand to Uganda and Tanzania!',
        imageUrls: [
          'https://images.unsplash.com/photo-1551288049-bebda4e38f71?w=800', // Business analytics dashboard
        ],
        createdAt: now.subtract(const Duration(hours: 4)),
        updatedAt: now.subtract(const Duration(hours: 4)),
        likesCount: 67,
        commentsCount: 18,
        sharesCount: 15,
        bookmarksCount: 31,
        isLiked: true,
        isBookmarked: false,
        hashtags: ['#agritech', '#sustainability', '#investment', '#africa'],
        location: 'Kigali, Rwanda',
        isVerified: true,
        isInvestmentOpportunity: true,
        investmentAmount: '300M RWF',
        investmentStage: 'Seed',
        industry: 'AgriTech',
        companyName: 'AgriTech Solutions',
        fundingGoal: '300M RWF',
        equityOffered: '20%',
        expectedReturn: '30% annually',
        investmentDuration: '2-4 years',
      ),
      Post(
        id: '3',
        userId: '3',
        userName: 'EduTech Africa',
        userAvatar: null,
        content: '📚 Our online learning platform has reached 10,000+ students across Rwanda. We are seeking 200M RWF to expand our curriculum and reach more underserved communities. Education is the key to Africa\'s future!',
        imageUrls: [
          'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?w=800', // Team collaboration
        ],
        createdAt: now.subtract(const Duration(hours: 6)),
        updatedAt: now.subtract(const Duration(hours: 6)),
        likesCount: 89,
        commentsCount: 25,
        sharesCount: 22,
        bookmarksCount: 45,
        isLiked: false,
        isBookmarked: true,
        hashtags: ['#edtech', '#education', '#investment', '#socialimpact'],
        location: 'Kigali, Rwanda',
        isVerified: true,
        isInvestmentOpportunity: true,
        investmentAmount: '200M RWF',
        investmentStage: 'Pre-Seed',
        industry: 'EdTech',
        companyName: 'EduTech Africa',
        fundingGoal: '200M RWF',
        equityOffered: '25%',
        expectedReturn: '20% annually',
        investmentDuration: '3-5 years',
      ),
      Post(
        id: '4',
        userId: '4',
        userName: 'HealthTech Innovations',
        userAvatar: null,
        content: '🏥 Telemedicine platform connecting rural communities with healthcare providers. We have served 5,000+ patients and are ready to scale across East Africa. Healthcare access for all!',
        imageUrls: [
          'https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?w=800', // Medical technology
        ],
        createdAt: now.subtract(const Duration(hours: 8)),
        updatedAt: now.subtract(const Duration(hours: 8)),
        likesCount: 123,
        commentsCount: 34,
        sharesCount: 28,
        bookmarksCount: 67,
        isLiked: true,
        isBookmarked: true,
        hashtags: ['#healthtech', '#telemedicine', '#investment', '#healthcare'],
        location: 'Kigali, Rwanda',
        isVerified: true,
        isInvestmentOpportunity: true,
        investmentAmount: '750M RWF',
        investmentStage: 'Series A',
        industry: 'HealthTech',
        companyName: 'HealthTech Innovations',
        fundingGoal: '750M RWF',
        equityOffered: '12%',
        expectedReturn: '35% annually',
        investmentDuration: '4-6 years',
      ),
      Post(
        id: '5',
        userId: '5',
        userName: 'Green Energy Co.',
        userAvatar: null,
        content: '⚡ Solar energy solutions for rural communities. We have installed 1,000+ solar systems and are expanding to provide clean energy access across Rwanda. Sustainable energy for all!',
        imageUrls: [
          'https://images.unsplash.com/photo-1466611653911-95081537e5b7?w=800', // Solar panels
        ],
        createdAt: now.subtract(const Duration(hours: 12)),
        updatedAt: now.subtract(const Duration(hours: 12)),
        likesCount: 156,
        commentsCount: 42,
        sharesCount: 35,
        bookmarksCount: 89,
        isLiked: false,
        isBookmarked: false,
        hashtags: ['#renewableenergy', '#solar', '#investment', '#sustainability'],
        location: 'Kigali, Rwanda',
        isVerified: true,
        isInvestmentOpportunity: true,
        investmentAmount: '1B RWF',
        investmentStage: 'Series A',
        industry: 'Clean Energy',
        companyName: 'Green Energy Co.',
        fundingGoal: '1B RWF',
        equityOffered: '18%',
        expectedReturn: '28% annually',
        investmentDuration: '5-7 years',
      ),
    ];
  }
}

final feedProvider = StateNotifierProvider<FeedNotifier, FeedState>((ref) {
  return FeedNotifier();
});
