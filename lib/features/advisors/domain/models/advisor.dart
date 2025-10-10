class Advisor {
  final String id;
  final String name;
  final String specialization;
  final String location;
  final String bio;
  final String experience;
  final String education;
  final String languages;
  final String joinDate;
  final String? phone;
  final String? email;
  final bool isVerified;
  final double rating;
  final int totalReviews;
  final int totalClients;
  final double successRate;
  final double averageReturn;
  final double clientSatisfaction;
  final int totalInvestmentValue;
  final List<Certification> certifications;
  final List<AdvisoryCase> recentCases;

  const Advisor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.location,
    required this.bio,
    required this.experience,
    required this.education,
    required this.languages,
    required this.joinDate,
    this.phone,
    this.email,
    this.isVerified = false,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.totalClients = 0,
    this.successRate = 0.0,
    this.averageReturn = 0.0,
    this.clientSatisfaction = 0.0,
    this.totalInvestmentValue = 0,
    this.certifications = const [],
    this.recentCases = const [],
  });
}

class Certification {
  final String name;
  final String issuer;
  final String date;

  const Certification({
    required this.name,
    required this.issuer,
    required this.date,
  });
}

class AdvisoryCase {
  final String id;
  final String companyName;
  final String industry;
  final double investmentAmount;
  final double expectedReturn;
  final String status;
  final DateTime date;

  const AdvisoryCase({
    required this.id,
    required this.companyName,
    required this.industry,
    required this.investmentAmount,
    required this.expectedReturn,
    required this.status,
    required this.date,
  });
}
