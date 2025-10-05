// import 'package:json_annotation/json_annotation.dart';

// part 'broker.g.dart';

// @JsonSerializable()
class Broker {
  final String id;
  final String name;
  final String? email;
  final String? phone;
  final String? avatar;
  final String location;
  final double rating;
  final int totalReviews;
  final bool isVerified;
  final String joinDate;
  final String specialization;
  final String experience;
  final String education;
  final String languages;
  final String bio;
  
  // Performance metrics
  final int totalInvestments;
  final double totalInvestmentValue;
  final double averageReturn;
  final int successfulDeals;
  final int activeDeals;
  final double successRate;
  final int clientsCount;
  final double clientSatisfaction;
  
  // Monthly performance data
  final List<MonthlyPerformance> monthlyPerformance;
  
  // Recent deals
  final List<Deal> recentDeals;
  
  // Certifications
  final List<Certification> certifications;

  const Broker({
    required this.id,
    required this.name,
    this.email,
    this.phone,
    this.avatar,
    required this.location,
    required this.rating,
    required this.totalReviews,
    required this.isVerified,
    required this.joinDate,
    required this.specialization,
    required this.experience,
    required this.education,
    required this.languages,
    required this.bio,
    required this.totalInvestments,
    required this.totalInvestmentValue,
    required this.averageReturn,
    required this.successfulDeals,
    required this.activeDeals,
    required this.successRate,
    required this.clientsCount,
    required this.clientSatisfaction,
    required this.monthlyPerformance,
    required this.recentDeals,
    required this.certifications,
  });

  // factory Broker.fromJson(Map<String, dynamic> json) => _$BrokerFromJson(json);
  // Map<String, dynamic> toJson() => _$BrokerToJson(this);

  Broker copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? location,
    double? rating,
    int? totalReviews,
    bool? isVerified,
    String? joinDate,
    String? specialization,
    String? experience,
    String? education,
    String? languages,
    String? bio,
    int? totalInvestments,
    double? totalInvestmentValue,
    double? averageReturn,
    int? successfulDeals,
    int? activeDeals,
    double? successRate,
    int? clientsCount,
    double? clientSatisfaction,
    List<MonthlyPerformance>? monthlyPerformance,
    List<Deal>? recentDeals,
    List<Certification>? certifications,
  }) {
    return Broker(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      location: location ?? this.location,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      isVerified: isVerified ?? this.isVerified,
      joinDate: joinDate ?? this.joinDate,
      specialization: specialization ?? this.specialization,
      experience: experience ?? this.experience,
      education: education ?? this.education,
      languages: languages ?? this.languages,
      bio: bio ?? this.bio,
      totalInvestments: totalInvestments ?? this.totalInvestments,
      totalInvestmentValue: totalInvestmentValue ?? this.totalInvestmentValue,
      averageReturn: averageReturn ?? this.averageReturn,
      successfulDeals: successfulDeals ?? this.successfulDeals,
      activeDeals: activeDeals ?? this.activeDeals,
      successRate: successRate ?? this.successRate,
      clientsCount: clientsCount ?? this.clientsCount,
      clientSatisfaction: clientSatisfaction ?? this.clientSatisfaction,
      monthlyPerformance: monthlyPerformance ?? this.monthlyPerformance,
      recentDeals: recentDeals ?? this.recentDeals,
      certifications: certifications ?? this.certifications,
    );
  }
}

// @JsonSerializable()
class MonthlyPerformance {
  final String month;
  final int investments;
  final double investmentValue;
  final double returns;
  final int newClients;
  final double satisfaction;

  const MonthlyPerformance({
    required this.month,
    required this.investments,
    required this.investmentValue,
    required this.returns,
    required this.newClients,
    required this.satisfaction,
  });

  // factory MonthlyPerformance.fromJson(Map<String, dynamic> json) => _$MonthlyPerformanceFromJson(json);
  // Map<String, dynamic> toJson() => _$MonthlyPerformanceToJson(this);
}

// @JsonSerializable()
class Deal {
  final String id;
  final String companyName;
  final String industry;
  final double investmentAmount;
  final double expectedReturn;
  final String status;
  final DateTime date;
  final String? imageUrl;

  const Deal({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.investmentAmount,
    required this.expectedReturn,
    required this.status,
    required this.date,
    this.imageUrl,
  });

  // factory Deal.fromJson(Map<String, dynamic> json) => _$DealFromJson(json);
  // Map<String, dynamic> toJson() => _$DealToJson(this);
}

// @JsonSerializable()
class Certification {
  final String id;
  final String name;
  final String issuer;
  final String date;
  final String? imageUrl;

  const Certification({
    required this.id,
    required this.name,
    required this.issuer,
    required this.date,
    this.imageUrl,
  });

  // factory Certification.fromJson(Map<String, dynamic> json) => _$CertificationFromJson(json);
  // Map<String, dynamic> toJson() => _$CertificationToJson(this);
}
