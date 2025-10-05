class Post {
  final String id;
  final String userId;
  final String userName;
  final String? userAvatar;
  final String? content;
  final List<String> imageUrls;
  final String? videoUrl;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int likesCount;
  final int commentsCount;
  final int sharesCount;
  final int bookmarksCount;
  final bool isLiked;
  final bool isBookmarked;
  final List<String> hashtags;
  final String? location;
  final bool isVerified;
  
  // Investment-specific fields
  final String? investmentAmount;
  final String? investmentStage;
  final String? industry;
  final String? companyName;
  final String? fundingGoal;
  final String? equityOffered;
  final String? expectedReturn;
  final String? investmentDuration;
  final bool isInvestmentOpportunity;

  const Post({
    required this.id,
    required this.userId,
    required this.userName,
    this.userAvatar,
    this.content,
    this.imageUrls = const [],
    this.videoUrl,
    required this.createdAt,
    required this.updatedAt,
    this.likesCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.bookmarksCount = 0,
    this.isLiked = false,
    this.isBookmarked = false,
    this.hashtags = const [],
    this.location,
    this.isVerified = false,
    this.investmentAmount,
    this.investmentStage,
    this.industry,
    this.companyName,
    this.fundingGoal,
    this.equityOffered,
    this.expectedReturn,
    this.investmentDuration,
    this.isInvestmentOpportunity = false,
  });

  Post copyWith({
    String? id,
    String? userId,
    String? userName,
    String? userAvatar,
    String? content,
    List<String>? imageUrls,
    String? videoUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    int? bookmarksCount,
    bool? isLiked,
    bool? isBookmarked,
    List<String>? hashtags,
    String? location,
    bool? isVerified,
    String? investmentAmount,
    String? investmentStage,
    String? industry,
    String? companyName,
    String? fundingGoal,
    String? equityOffered,
    String? expectedReturn,
    String? investmentDuration,
    bool? isInvestmentOpportunity,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      userAvatar: userAvatar ?? this.userAvatar,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      videoUrl: videoUrl ?? this.videoUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      bookmarksCount: bookmarksCount ?? this.bookmarksCount,
      isLiked: isLiked ?? this.isLiked,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      hashtags: hashtags ?? this.hashtags,
      location: location ?? this.location,
      isVerified: isVerified ?? this.isVerified,
      investmentAmount: investmentAmount ?? this.investmentAmount,
      investmentStage: investmentStage ?? this.investmentStage,
      industry: industry ?? this.industry,
      companyName: companyName ?? this.companyName,
      fundingGoal: fundingGoal ?? this.fundingGoal,
      equityOffered: equityOffered ?? this.equityOffered,
      expectedReturn: expectedReturn ?? this.expectedReturn,
      investmentDuration: investmentDuration ?? this.investmentDuration,
      isInvestmentOpportunity: isInvestmentOpportunity ?? this.isInvestmentOpportunity,
    );
  }
}
