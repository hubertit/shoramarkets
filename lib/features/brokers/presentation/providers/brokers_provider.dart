import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/broker.dart';

class BrokersState {
  final List<Broker> brokers;
  final bool isLoading;
  final String? error;
  final bool hasMoreBrokers;

  const BrokersState({
    this.brokers = const [],
    this.isLoading = false,
    this.error,
    this.hasMoreBrokers = true,
  });

  BrokersState copyWith({
    List<Broker>? brokers,
    bool? isLoading,
    String? error,
    bool? hasMoreBrokers,
  }) {
    return BrokersState(
      brokers: brokers ?? this.brokers,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      hasMoreBrokers: hasMoreBrokers ?? this.hasMoreBrokers,
    );
  }
}

class BrokersNotifier extends StateNotifier<BrokersState> {
  BrokersNotifier() : super(const BrokersState()) {
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    state = state.copyWith(isLoading: true, error: null);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    final now = DateTime.now();
    final mockBrokers = [
      Broker(
        id: '1',
        name: 'Jean Claude Nkurunziza',
        email: 'jean.claude@shoramarkets.com',
        phone: '+250 788 123 456',
        avatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
        location: 'Kigali, Rwanda',
        rating: 4.8,
        totalReviews: 127,
        isVerified: true,
        joinDate: 'January 2022',
        specialization: 'Fintech & Agritech',
        experience: '8 years',
        education: 'MBA Finance, University of Rwanda',
        languages: 'English, French, Kinyarwanda',
        bio: 'Experienced investment broker specializing in fintech and agritech startups. Successfully facilitated over 50M RWF in investments with 95% success rate.',
        totalInvestments: 45,
        totalInvestmentValue: 125000000, // 125M RWF
        averageReturn: 28.5,
        successfulDeals: 43,
        activeDeals: 8,
        successRate: 95.6,
        clientsCount: 67,
        clientSatisfaction: 4.8,
        monthlyPerformance: [
          MonthlyPerformance(
            month: 'Jan 2024',
            investments: 5,
            investmentValue: 15000000,
            returns: 4200000,
            newClients: 3,
            satisfaction: 4.9,
          ),
          MonthlyPerformance(
            month: 'Feb 2024',
            investments: 7,
            investmentValue: 22000000,
            returns: 6300000,
            newClients: 4,
            satisfaction: 4.7,
          ),
          MonthlyPerformance(
            month: 'Mar 2024',
            investments: 6,
            investmentValue: 18000000,
            returns: 5100000,
            newClients: 2,
            satisfaction: 4.8,
          ),
        ],
        recentDeals: [
          Deal(
            id: '1',
            companyName: 'TechStart Rwanda',
            industry: 'Fintech',
            investmentAmount: 50000000,
            expectedReturn: 25.0,
            status: 'Active',
            date: now.subtract(const Duration(days: 5)),
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
          ),
          Deal(
            id: '2',
            companyName: 'AgriTech Solutions',
            industry: 'Agritech',
            investmentAmount: 30000000,
            expectedReturn: 30.0,
            status: 'Completed',
            date: now.subtract(const Duration(days: 15)),
            imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=200',
          ),
        ],
        certifications: [
          Certification(
            id: '1',
            name: 'Certified Investment Professional',
            issuer: 'Rwanda Capital Markets Authority',
            date: '2023',
          ),
          Certification(
            id: '2',
            name: 'Chartered Financial Analyst',
            issuer: 'CFA Institute',
            date: '2022',
          ),
        ],
      ),
      Broker(
        id: '2',
        name: 'Marie Claire Uwimana',
        email: 'marie.claire@shoramarkets.com',
        phone: '+250 789 234 567',
        avatar: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=400',
        location: 'Kigali, Rwanda',
        rating: 4.9,
        totalReviews: 89,
        isVerified: true,
        joinDate: 'March 2021',
        specialization: 'HealthTech & EdTech',
        experience: '6 years',
        education: 'MSc Economics, Carnegie Mellon',
        languages: 'English, French, Kinyarwanda',
        bio: 'Passionate about impact investing in healthcare and education sectors. Expert in due diligence and risk assessment for early-stage startups.',
        totalInvestments: 38,
        totalInvestmentValue: 98000000, // 98M RWF
        averageReturn: 32.1,
        successfulDeals: 36,
        activeDeals: 6,
        successRate: 94.7,
        clientsCount: 52,
        clientSatisfaction: 4.9,
        monthlyPerformance: [
          MonthlyPerformance(
            month: 'Jan 2024',
            investments: 4,
            investmentValue: 12000000,
            returns: 3800000,
            newClients: 2,
            satisfaction: 4.9,
          ),
          MonthlyPerformance(
            month: 'Feb 2024',
            investments: 6,
            investmentValue: 18000000,
            returns: 5800000,
            newClients: 3,
            satisfaction: 4.8,
          ),
          MonthlyPerformance(
            month: 'Mar 2024',
            investments: 5,
            investmentValue: 15000000,
            returns: 4800000,
            newClients: 2,
            satisfaction: 4.9,
          ),
        ],
        recentDeals: [
          Deal(
            id: '3',
            companyName: 'HealthTech Innovations',
            industry: 'HealthTech',
            investmentAmount: 75000000,
            expectedReturn: 35.0,
            status: 'Active',
            date: now.subtract(const Duration(days: 3)),
            imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=200',
          ),
          Deal(
            id: '4',
            companyName: 'EduTech Africa',
            industry: 'EdTech',
            investmentAmount: 20000000,
            expectedReturn: 20.0,
            status: 'Completed',
            date: now.subtract(const Duration(days: 20)),
            imageUrl: 'https://images.unsplash.com/photo-1494790108755-2616b612b786?w=200',
          ),
        ],
        certifications: [
          Certification(
            id: '3',
            name: 'Certified Investment Professional',
            issuer: 'Rwanda Capital Markets Authority',
            date: '2023',
          ),
          Certification(
            id: '4',
            name: 'Impact Investment Specialist',
            issuer: 'Global Impact Investing Network',
            date: '2022',
          ),
        ],
      ),
      Broker(
        id: '3',
        name: 'Patrick Nsengimana',
        email: 'patrick@shoramarkets.com',
        phone: '+250 787 345 678',
        avatar: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?w=400',
        location: 'Kigali, Rwanda',
        rating: 4.7,
        totalReviews: 156,
        isVerified: true,
        joinDate: 'June 2020',
        specialization: 'Clean Energy & Manufacturing',
        experience: '10 years',
        education: 'BSc Engineering, University of Rwanda',
        languages: 'English, French, Kinyarwanda',
        bio: 'Engineering background with focus on sustainable energy and manufacturing investments. Strong track record in green energy projects.',
        totalInvestments: 52,
        totalInvestmentValue: 156000000, // 156M RWF
        averageReturn: 26.8,
        successfulDeals: 48,
        activeDeals: 10,
        successRate: 92.3,
        clientsCount: 78,
        clientSatisfaction: 4.7,
        monthlyPerformance: [
          MonthlyPerformance(
            month: 'Jan 2024',
            investments: 8,
            investmentValue: 25000000,
            returns: 6700000,
            newClients: 4,
            satisfaction: 4.6,
          ),
          MonthlyPerformance(
            month: 'Feb 2024',
            investments: 6,
            investmentValue: 20000000,
            returns: 5400000,
            newClients: 3,
            satisfaction: 4.7,
          ),
          MonthlyPerformance(
            month: 'Mar 2024',
            investments: 7,
            investmentValue: 22000000,
            returns: 5900000,
            newClients: 5,
            satisfaction: 4.8,
          ),
        ],
        recentDeals: [
          Deal(
            id: '5',
            companyName: 'Green Energy Co.',
            industry: 'Clean Energy',
            investmentAmount: 100000000,
            expectedReturn: 28.0,
            status: 'Active',
            date: now.subtract(const Duration(days: 7)),
            imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
          ),
          Deal(
            id: '6',
            companyName: 'SolarTech Rwanda',
            industry: 'Clean Energy',
            investmentAmount: 40000000,
            expectedReturn: 32.0,
            status: 'Completed',
            date: now.subtract(const Duration(days: 25)),
            imageUrl: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
          ),
        ],
        certifications: [
          Certification(
            id: '5',
            name: 'Certified Investment Professional',
            issuer: 'Rwanda Capital Markets Authority',
            date: '2023',
          ),
          Certification(
            id: '6',
            name: 'Renewable Energy Investment Specialist',
            issuer: 'International Renewable Energy Agency',
            date: '2021',
          ),
        ],
      ),
      Broker(
        id: '4',
        name: 'Grace Mukamana',
        email: 'grace@shoramarkets.com',
        phone: '+250 786 456 789',
        avatar: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=400',
        location: 'Kigali, Rwanda',
        rating: 4.6,
        totalReviews: 98,
        isVerified: true,
        joinDate: 'September 2022',
        specialization: 'E-commerce & Logistics',
        experience: '5 years',
        education: 'MBA Business Administration, INES Ruhengeri',
        languages: 'English, French, Kinyarwanda',
        bio: 'Specialized in e-commerce and logistics investments. Strong background in digital transformation and supply chain optimization.',
        totalInvestments: 29,
        totalInvestmentValue: 72000000, // 72M RWF
        averageReturn: 24.5,
        successfulDeals: 27,
        activeDeals: 5,
        successRate: 93.1,
        clientsCount: 41,
        clientSatisfaction: 4.6,
        monthlyPerformance: [
          MonthlyPerformance(
            month: 'Jan 2024',
            investments: 3,
            investmentValue: 8000000,
            returns: 1960000,
            newClients: 2,
            satisfaction: 4.5,
          ),
          MonthlyPerformance(
            month: 'Feb 2024',
            investments: 4,
            investmentValue: 12000000,
            returns: 2940000,
            newClients: 3,
            satisfaction: 4.6,
          ),
          MonthlyPerformance(
            month: 'Mar 2024',
            investments: 5,
            investmentValue: 15000000,
            returns: 3675000,
            newClients: 2,
            satisfaction: 4.7,
          ),
        ],
        recentDeals: [
          Deal(
            id: '7',
            companyName: 'LogiTech Rwanda',
            industry: 'Logistics',
            investmentAmount: 25000000,
            expectedReturn: 22.0,
            status: 'Active',
            date: now.subtract(const Duration(days: 10)),
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
          ),
          Deal(
            id: '8',
            companyName: 'ShopRwanda',
            industry: 'E-commerce',
            investmentAmount: 18000000,
            expectedReturn: 26.0,
            status: 'Completed',
            date: now.subtract(const Duration(days: 30)),
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
          ),
        ],
        certifications: [
          Certification(
            id: '7',
            name: 'Certified Investment Professional',
            issuer: 'Rwanda Capital Markets Authority',
            date: '2023',
          ),
          Certification(
            id: '8',
            name: 'Digital Business Specialist',
            issuer: 'Rwanda Development Board',
            date: '2022',
          ),
        ],
      ),
      Broker(
        id: '5',
        name: 'David Nkurunziza',
        email: 'david@shoramarkets.com',
        phone: '+250 785 567 890',
        avatar: 'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=400',
        location: 'Kigali, Rwanda',
        rating: 4.5,
        totalReviews: 73,
        isVerified: true,
        joinDate: 'November 2022',
        specialization: 'Tourism & Hospitality',
        experience: '4 years',
        education: 'BSc Tourism Management, University of Rwanda',
        languages: 'English, French, Kinyarwanda',
        bio: 'Focused on tourism and hospitality investments. Deep understanding of Rwanda\'s tourism sector and international market trends.',
        totalInvestments: 22,
        totalInvestmentValue: 55000000, // 55M RWF
        averageReturn: 21.8,
        successfulDeals: 20,
        activeDeals: 4,
        successRate: 90.9,
        clientsCount: 35,
        clientSatisfaction: 4.5,
        monthlyPerformance: [
          MonthlyPerformance(
            month: 'Jan 2024',
            investments: 2,
            investmentValue: 6000000,
            returns: 1308000,
            newClients: 1,
            satisfaction: 4.4,
          ),
          MonthlyPerformance(
            month: 'Feb 2024',
            investments: 3,
            investmentValue: 9000000,
            returns: 1962000,
            newClients: 2,
            satisfaction: 4.5,
          ),
          MonthlyPerformance(
            month: 'Mar 2024',
            investments: 4,
            investmentValue: 12000000,
            returns: 2616000,
            newClients: 2,
            satisfaction: 4.6,
          ),
        ],
        recentDeals: [
          Deal(
            id: '9',
            companyName: 'Rwanda Safari Tours',
            industry: 'Tourism',
            investmentAmount: 15000000,
            expectedReturn: 18.0,
            status: 'Active',
            date: now.subtract(const Duration(days: 12)),
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
          ),
          Deal(
            id: '10',
            companyName: 'Kigali Boutique Hotel',
            industry: 'Hospitality',
            investmentAmount: 20000000,
            expectedReturn: 25.0,
            status: 'Completed',
            date: now.subtract(const Duration(days: 35)),
            imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
          ),
        ],
        certifications: [
          Certification(
            id: '9',
            name: 'Certified Investment Professional',
            issuer: 'Rwanda Capital Markets Authority',
            date: '2023',
          ),
          Certification(
            id: '10',
            name: 'Tourism Investment Specialist',
            issuer: 'Rwanda Development Board',
            date: '2022',
          ),
        ],
      ),
    ];

    state = state.copyWith(
      isLoading: false,
      brokers: mockBrokers,
      hasMoreBrokers: false, // For mock data, assume no more brokers
    );
  }

  Future<void> refreshBrokers() async {
    await _loadInitialData();
  }

  Future<void> loadMoreBrokers() async {
    if (state.isLoading || !state.hasMoreBrokers) return;

    state = state.copyWith(isLoading: true);

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // For mock data, we don't have more brokers
    state = state.copyWith(
      isLoading: false,
      hasMoreBrokers: false,
    );
  }

  Future<void> searchBrokers(String query) async {
    if (query.isEmpty) {
      await refreshBrokers();
      return;
    }

    state = state.copyWith(isLoading: true);

    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    final filteredBrokers = state.brokers.where((broker) {
      return broker.name.toLowerCase().contains(query.toLowerCase()) ||
             broker.specialization.toLowerCase().contains(query.toLowerCase()) ||
             broker.location.toLowerCase().contains(query.toLowerCase());
    }).toList();

    state = state.copyWith(
      isLoading: false,
      brokers: filteredBrokers,
    );
  }
}

final brokersProvider = StateNotifierProvider<BrokersNotifier, BrokersState>((ref) {
  return BrokersNotifier();
});
