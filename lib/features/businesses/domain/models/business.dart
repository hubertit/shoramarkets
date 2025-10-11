class Business {
  final String id;
  final String name;
  final String industry;
  final String location;
  final String description;
  final String stage;
  final String fundingGoal;
  final String equityOffered;
  final String? website;
  final String? email;
  final String? phone;
  final bool isVerified;
  final double rating;
  final int totalReviews;
  final int totalInvestors;
  final double fundingProgress;
  final double expectedReturn;
  final double riskLevel;
  final int totalInvestmentValue;
  final List<String> tags;
  final List<String> images;
  final String foundedDate;
  final String teamSize;
  final String businessModel;
  final List<String> keyMetrics;
  final Map<String, dynamic> financials;
  final List<String> achievements;
  final Map<String, String> socialLinks;
  final String nextMilestone;
  final String useOfFunds;
  final String exitStrategy;
  final String competitiveAdvantage;
  final List<String> targetMarkets;
  final String businessPlan;
  final String pitchDeck;
  final String demoVideo;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Business({
    required this.id,
    required this.name,
    required this.industry,
    required this.location,
    required this.description,
    required this.stage,
    required this.fundingGoal,
    required this.equityOffered,
    this.website,
    this.email,
    this.phone,
    this.isVerified = false,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.totalInvestors = 0,
    this.fundingProgress = 0.0,
    this.expectedReturn = 0.0,
    this.riskLevel = 0.0,
    this.totalInvestmentValue = 0,
    this.tags = const [],
    this.images = const [],
    required this.foundedDate,
    required this.teamSize,
    required this.businessModel,
    this.keyMetrics = const [],
    this.financials = const {},
    this.achievements = const [],
    this.socialLinks = const {},
    required this.nextMilestone,
    required this.useOfFunds,
    required this.exitStrategy,
    required this.competitiveAdvantage,
    this.targetMarkets = const [],
    required this.businessPlan,
    required this.pitchDeck,
    required this.demoVideo,
    this.isActive = true,
    required this.createdAt,
    required this.updatedAt,
  });
}
