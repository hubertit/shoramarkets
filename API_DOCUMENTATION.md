# Shora Markets API Documentation

## Overview
This document outlines the expected APIs for the Shora Markets platform, a comprehensive financial services application that includes investment opportunities, loans, savings, insurance, and social features.

## Base URL
```
https://api.shoramarkets.com/v1
```

## Authentication
All API endpoints require authentication using Bearer tokens in the Authorization header:
```
Authorization: Bearer <access_token>
```

---

## 1. Authentication APIs

### 1.1 User Registration
**POST** `/auth/register`

**Request Body:**
```json
{
  "name": "John Doe",
  "email": "john@example.com",
  "password": "securePassword123",
  "phoneNumber": "+1234567890",
  "role": "investor"
}
```

**Response:**
```json
{
  "success": true,
  "message": "User registered successfully",
  "data": {
    "user": {
      "id": "user_123",
      "name": "John Doe",
      "email": "john@example.com",
      "phoneNumber": "+1234567890",
      "role": "investor",
      "isActive": true,
      "createdAt": "2024-01-15T10:30:00Z",
      "profilePicture": "",
      "profileCover": "",
      "about": "",
      "address": ""
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 1.2 User Login
**POST** `/auth/login`

**Request Body:**
```json
{
  "email": "john@example.com",
  "password": "securePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Login successful",
  "data": {
    "user": {
      "id": "user_123",
      "name": "John Doe",
      "email": "john@example.com",
      "phoneNumber": "+1234567890",
      "role": "investor",
      "isActive": true,
      "lastLoginAt": "2024-01-15T10:30:00Z",
      "profilePicture": "https://api.shoramarkets.com/images/profile_123.jpg",
      "profileCover": "https://api.shoramarkets.com/images/cover_123.jpg",
      "about": "Passionate investor",
      "address": "123 Main St, City, Country"
    },
    "accessToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
    "refreshToken": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
  }
}
```

### 1.3 Forgot Password
**POST** `/auth/forgot-password`

**Request Body:**
```json
{
  "email": "john@example.com"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Password reset email sent",
  "data": {
    "resetToken": "reset_token_123",
    "expiresAt": "2024-01-15T12:30:00Z"
  }
}
```

### 1.4 Reset Password
**POST** `/auth/reset-password`

**Request Body:**
```json
{
  "token": "reset_token_123",
  "newPassword": "newSecurePassword123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Password reset successfully"
}
```

---

## 2. User Management APIs

### 2.1 Get User Profile
**GET** `/users/profile`

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "user_123",
    "name": "John Doe",
    "email": "john@example.com",
    "phoneNumber": "+1234567890",
    "role": "investor",
    "isActive": true,
    "createdAt": "2024-01-01T00:00:00Z",
    "lastLoginAt": "2024-01-15T10:30:00Z",
    "profilePicture": "https://api.shoramarkets.com/images/profile_123.jpg",
    "profileCover": "https://api.shoramarkets.com/images/cover_123.jpg",
    "about": "Passionate investor with 5 years experience",
    "address": "123 Main St, City, Country"
  }
}
```

### 2.2 Update User Profile
**PUT** `/users/profile`

**Request Body:**
```json
{
  "name": "John Smith",
  "phoneNumber": "+1234567891",
  "about": "Updated bio",
  "address": "456 New St, City, Country"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Profile updated successfully",
  "data": {
    "id": "user_123",
    "name": "John Smith",
    "email": "john@example.com",
    "phoneNumber": "+1234567891",
    "role": "investor",
    "isActive": true,
    "updatedAt": "2024-01-15T11:00:00Z",
    "about": "Updated bio",
    "address": "456 New St, City, Country"
  }
}
```

---

## 3. Brokers APIs

### 3.1 Get All Brokers
**GET** `/brokers?page=1&limit=20&specialization=technology&location=New York`

**Response:**
```json
{
  "success": true,
  "data": {
    "brokers": [
      {
        "id": "broker_123",
        "name": "Sarah Johnson",
        "email": "sarah@example.com",
        "phone": "+1234567890",
        "avatar": "https://api.shoramarkets.com/images/avatar_123.jpg",
        "location": "New York, NY",
        "rating": 4.8,
        "totalReviews": 156,
        "isVerified": true,
        "joinDate": "2020-01-15",
        "specialization": "Technology",
        "experience": "8 years",
        "education": "MBA Finance",
        "languages": "English, Spanish",
        "bio": "Experienced technology investment broker",
        "totalInvestments": 45,
        "totalInvestmentValue": 2500000.00,
        "averageReturn": 12.5,
        "successfulDeals": 42,
        "activeDeals": 3,
        "successRate": 93.3,
        "clientsCount": 89,
        "clientSatisfaction": 4.7,
        "monthlyPerformance": [
          {
            "month": "2024-01",
            "investments": 5,
            "investmentValue": 150000.00,
            "returns": 8.5,
            "newClients": 3,
            "satisfaction": 4.8
          }
        ],
        "recentDeals": [
          {
            "id": "deal_123",
            "companyName": "TechStart Inc",
            "industry": "Technology",
            "investmentAmount": 100000.00,
            "expectedReturn": 15.0,
            "status": "active",
            "date": "2024-01-10T00:00:00Z",
            "imageUrl": "https://api.shoramarkets.com/images/company_123.jpg"
          }
        ],
        "certifications": [
          {
            "id": "cert_123",
            "name": "CFA",
            "issuer": "CFA Institute",
            "date": "2019-06-15",
            "imageUrl": "https://api.shoramarkets.com/images/cert_123.jpg"
          }
        ]
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalItems": 89,
      "itemsPerPage": 20
    }
  }
}
```

### 3.2 Get Broker Details
**GET** `/brokers/{brokerId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "broker_123",
    "name": "Sarah Johnson",
    "email": "sarah@example.com",
    "phone": "+1234567890",
    "avatar": "https://api.shoramarkets.com/images/avatar_123.jpg",
    "location": "New York, NY",
    "rating": 4.8,
    "totalReviews": 156,
    "isVerified": true,
    "joinDate": "2020-01-15",
    "specialization": "Technology",
    "experience": "8 years",
    "education": "MBA Finance",
    "languages": "English, Spanish",
    "bio": "Experienced technology investment broker with proven track record",
    "totalInvestments": 45,
    "totalInvestmentValue": 2500000.00,
    "averageReturn": 12.5,
    "successfulDeals": 42,
    "activeDeals": 3,
    "successRate": 93.3,
    "clientsCount": 89,
    "clientSatisfaction": 4.7,
    "monthlyPerformance": [
      {
        "month": "2024-01",
        "investments": 5,
        "investmentValue": 150000.00,
        "returns": 8.5,
        "newClients": 3,
        "satisfaction": 4.8
      }
    ],
    "recentDeals": [
      {
        "id": "deal_123",
        "companyName": "TechStart Inc",
        "industry": "Technology",
        "investmentAmount": 100000.00,
        "expectedReturn": 15.0,
        "status": "active",
        "date": "2024-01-10T00:00:00Z",
        "imageUrl": "https://api.shoramarkets.com/images/company_123.jpg"
      }
    ],
    "certifications": [
      {
        "id": "cert_123",
        "name": "CFA",
        "issuer": "CFA Institute",
        "date": "2019-06-15",
        "imageUrl": "https://api.shoramarkets.com/images/cert_123.jpg"
      }
    ]
  }
}
```

---

## 4. Advisors APIs

### 4.1 Get All Advisors
**GET** `/advisors?page=1&limit=20&specialization=finance&location=California`

**Response:**
```json
{
  "success": true,
  "data": {
    "advisors": [
      {
        "id": "advisor_123",
        "name": "Michael Chen",
        "specialization": "Financial Planning",
        "location": "San Francisco, CA",
        "bio": "Certified financial planner with 10+ years experience",
        "experience": "10 years",
        "education": "CFP, MBA",
        "languages": "English, Mandarin",
        "joinDate": "2019-03-15",
        "phone": "+1234567890",
        "email": "michael@example.com",
        "isVerified": true,
        "rating": 4.9,
        "totalReviews": 203,
        "totalClients": 156,
        "successRate": 95.2,
        "averageReturn": 11.8,
        "clientSatisfaction": 4.8,
        "totalInvestmentValue": 3200000,
        "certifications": [
          {
            "name": "CFP",
            "issuer": "CFP Board",
            "date": "2018-05-20"
          }
        ],
        "recentCases": [
          {
            "id": "case_123",
            "companyName": "StartupXYZ",
            "industry": "Fintech",
            "investmentAmount": 50000.00,
            "expectedReturn": 18.0,
            "status": "completed",
            "date": "2024-01-05T00:00:00Z"
          }
        ]
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 8,
      "totalItems": 156,
      "itemsPerPage": 20
    }
  }
}
```

### 4.2 Get Advisor Details
**GET** `/advisors/{advisorId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "advisor_123",
    "name": "Michael Chen",
    "specialization": "Financial Planning",
    "location": "San Francisco, CA",
    "bio": "Certified financial planner with 10+ years experience helping clients achieve their financial goals",
    "experience": "10 years",
    "education": "CFP, MBA",
    "languages": "English, Mandarin",
    "joinDate": "2019-03-15",
    "phone": "+1234567890",
    "email": "michael@example.com",
    "isVerified": true,
    "rating": 4.9,
    "totalReviews": 203,
    "totalClients": 156,
    "successRate": 95.2,
    "averageReturn": 11.8,
    "clientSatisfaction": 4.8,
    "totalInvestmentValue": 3200000,
    "certifications": [
      {
        "name": "CFP",
        "issuer": "CFP Board",
        "date": "2018-05-20"
      }
    ],
    "recentCases": [
      {
        "id": "case_123",
        "companyName": "StartupXYZ",
        "industry": "Fintech",
        "investmentAmount": 50000.00,
        "expectedReturn": 18.0,
        "status": "completed",
        "date": "2024-01-05T00:00:00Z"
      }
    ]
  }
}
```

---

## 5. Businesses APIs

### 5.1 Get All Businesses
**GET** `/businesses?page=1&limit=20&industry=technology&stage=startup`

**Response:**
```json
{
  "success": true,
  "data": {
    "businesses": [
      {
        "id": "business_123",
        "name": "TechInnovate Solutions",
        "industry": "Technology",
        "location": "Austin, TX",
        "description": "AI-powered business automation platform",
        "stage": "Series A",
        "fundingGoal": 5000000.00,
        "equityOffered": 15.0,
        "website": "https://techinnovate.com",
        "email": "contact@techinnovate.com",
        "phone": "+1234567890",
        "isVerified": true,
        "rating": 4.6,
        "totalReviews": 89,
        "totalInvestors": 45,
        "fundingProgress": 65.0,
        "expectedReturn": 25.0,
        "riskLevel": 7.5,
        "totalInvestmentValue": 3250000.00,
        "tags": ["AI", "Automation", "B2B"],
        "images": [
          "https://api.shoramarkets.com/images/business_123_1.jpg",
          "https://api.shoramarkets.com/images/business_123_2.jpg"
        ],
        "foundedDate": "2022-03-15",
        "teamSize": "15-20",
        "businessModel": "SaaS",
        "keyMetrics": [
          "Monthly Recurring Revenue: $150K",
          "Customer Acquisition Cost: $500",
          "Customer Lifetime Value: $15K"
        ],
        "financials": {
          "revenue": 1800000.00,
          "expenses": 1200000.00,
          "profit": 600000.00,
          "growthRate": 35.0
        },
        "achievements": [
          "Won TechCrunch Startup Battle",
          "Featured in Forbes 30 Under 30"
        ],
        "socialLinks": {
          "linkedin": "https://linkedin.com/company/techinnovate",
          "twitter": "https://twitter.com/techinnovate"
        },
        "nextMilestone": "International expansion",
        "useOfFunds": "Product development and marketing",
        "exitStrategy": "IPO or acquisition",
        "competitiveAdvantage": "Proprietary AI algorithms",
        "targetMarkets": ["SMB", "Enterprise"],
        "businessPlan": "https://api.shoramarkets.com/documents/business_plan_123.pdf",
        "pitchDeck": "https://api.shoramarkets.com/documents/pitch_deck_123.pdf",
        "demoVideo": "https://api.shoramarkets.com/videos/demo_123.mp4",
        "isActive": true,
        "createdAt": "2024-01-01T00:00:00Z",
        "updatedAt": "2024-01-15T10:30:00Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 12,
      "totalItems": 234,
      "itemsPerPage": 20
    }
  }
}
```

### 5.2 Get Business Details
**GET** `/businesses/{businessId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "business_123",
    "name": "TechInnovate Solutions",
    "industry": "Technology",
    "location": "Austin, TX",
    "description": "AI-powered business automation platform that helps companies streamline their operations",
    "stage": "Series A",
    "fundingGoal": 5000000.00,
    "equityOffered": 15.0,
    "website": "https://techinnovate.com",
    "email": "contact@techinnovate.com",
    "phone": "+1234567890",
    "isVerified": true,
    "rating": 4.6,
    "totalReviews": 89,
    "totalInvestors": 45,
    "fundingProgress": 65.0,
    "expectedReturn": 25.0,
    "riskLevel": 7.5,
    "totalInvestmentValue": 3250000.00,
    "tags": ["AI", "Automation", "B2B"],
    "images": [
      "https://api.shoramarkets.com/images/business_123_1.jpg",
      "https://api.shoramarkets.com/images/business_123_2.jpg"
    ],
    "foundedDate": "2022-03-15",
    "teamSize": "15-20",
    "businessModel": "SaaS",
    "keyMetrics": [
      "Monthly Recurring Revenue: $150K",
      "Customer Acquisition Cost: $500",
      "Customer Lifetime Value: $15K"
    ],
    "financials": {
      "revenue": 1800000.00,
      "expenses": 1200000.00,
      "profit": 600000.00,
      "growthRate": 35.0
    },
    "achievements": [
      "Won TechCrunch Startup Battle",
      "Featured in Forbes 30 Under 30"
    ],
    "socialLinks": {
      "linkedin": "https://linkedin.com/company/techinnovate",
      "twitter": "https://twitter.com/techinnovate"
    },
    "nextMilestone": "International expansion",
    "useOfFunds": "Product development and marketing",
    "exitStrategy": "IPO or acquisition",
    "competitiveAdvantage": "Proprietary AI algorithms",
    "targetMarkets": ["SMB", "Enterprise"],
    "businessPlan": "https://api.shoramarkets.com/documents/business_plan_123.pdf",
    "pitchDeck": "https://api.shoramarkets.com/documents/pitch_deck_123.pdf",
    "demoVideo": "https://api.shoramarkets.com/videos/demo_123.mp4",
    "isActive": true,
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-15T10:30:00Z"
  }
}
```

---

## 6. Loans APIs

### 6.1 Get All Loans
**GET** `/loans?page=1&limit=20&status=active&type=cash`

**Response:**
```json
{
  "success": true,
  "data": {
    "loans": [
      {
        "id": "loan_123",
        "name": "Business Expansion Loan",
        "description": "Loan for expanding business operations",
        "type": "cash",
        "amount": 50000.00,
        "interestRate": 8.5,
        "termInMonths": 24,
        "startDate": "2024-01-01T00:00:00Z",
        "dueDate": "2026-01-01T00:00:00Z",
        "status": "active",
        "walletId": "wallet_123",
        "guarantors": ["guarantor_1", "guarantor_2"],
        "collateral": {
          "type": "property",
          "value": 75000.00,
          "description": "Commercial property"
        },
        "purpose": "Equipment purchase",
        "monthlyPayment": 2250.00,
        "totalRepayment": 54000.00,
        "remainingBalance": 45000.00,
        "createdAt": "2024-01-01T00:00:00Z",
        "updatedAt": "2024-01-15T10:30:00Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 45,
      "itemsPerPage": 20
    }
  }
}
```

### 6.2 Create Loan
**POST** `/loans`

**Request Body:**
```json
{
  "name": "Equipment Purchase Loan",
  "description": "Loan for purchasing new equipment",
  "type": "device",
  "amount": 25000.00,
  "interestRate": 7.5,
  "termInMonths": 18,
  "purpose": "Equipment upgrade",
  "guarantors": ["guarantor_1"],
  "collateral": {
    "type": "equipment",
    "value": 30000.00,
    "description": "Manufacturing equipment"
  }
}
```

**Response:**
```json
{
  "success": true,
  "message": "Loan application submitted successfully",
  "data": {
    "id": "loan_456",
    "name": "Equipment Purchase Loan",
    "description": "Loan for purchasing new equipment",
    "type": "device",
    "amount": 25000.00,
    "interestRate": 7.5,
    "termInMonths": 18,
    "startDate": "2024-01-15T00:00:00Z",
    "dueDate": "2025-07-15T00:00:00Z",
    "status": "pending",
    "walletId": "wallet_123",
    "guarantors": ["guarantor_1"],
    "collateral": {
      "type": "equipment",
      "value": 30000.00,
      "description": "Manufacturing equipment"
    },
    "purpose": "Equipment upgrade",
    "monthlyPayment": 1450.00,
    "totalRepayment": 26100.00,
    "remainingBalance": 25000.00,
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

### 6.3 Get Loan Details
**GET** `/loans/{loanId}`

**Response:**
```json
{
  "success": true,
  "data": {
    "id": "loan_123",
    "name": "Business Expansion Loan",
    "description": "Loan for expanding business operations",
    "type": "cash",
    "amount": 50000.00,
    "interestRate": 8.5,
    "termInMonths": 24,
    "startDate": "2024-01-01T00:00:00Z",
    "dueDate": "2026-01-01T00:00:00Z",
    "status": "active",
    "walletId": "wallet_123",
    "guarantors": ["guarantor_1", "guarantor_2"],
    "collateral": {
      "type": "property",
      "value": 75000.00,
      "description": "Commercial property"
    },
    "purpose": "Equipment purchase",
    "monthlyPayment": 2250.00,
    "totalRepayment": 54000.00,
    "remainingBalance": 45000.00,
    "createdAt": "2024-01-01T00:00:00Z",
    "updatedAt": "2024-01-15T10:30:00Z",
    "repayments": [
      {
        "id": "repayment_123",
        "loanId": "loan_123",
        "amount": 2250.00,
        "paymentMethod": "mobileMoney",
        "status": "completed",
        "paymentDate": "2024-01-01T00:00:00Z",
        "transactionId": "txn_123",
        "notes": "Monthly payment",
        "createdAt": "2024-01-01T00:00:00Z"
      }
    ]
  }
}
```

### 6.4 Make Loan Payment
**POST** `/loans/{loanId}/payments`

**Request Body:**
```json
{
  "amount": 2250.00,
  "paymentMethod": "mobileMoney",
  "notes": "Monthly payment"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Payment processed successfully",
  "data": {
    "id": "repayment_456",
    "loanId": "loan_123",
    "amount": 2250.00,
    "paymentMethod": "mobileMoney",
    "status": "completed",
    "paymentDate": "2024-01-15T10:30:00Z",
    "transactionId": "txn_456",
    "notes": "Monthly payment",
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

---

## 7. Savings APIs

### 7.1 Get All Savings Goals
**GET** `/savings/goals?page=1&limit=20&status=active`

**Response:**
```json
{
  "success": true,
  "data": {
    "goals": [
      {
        "id": "goal_123",
        "name": "Emergency Fund",
        "description": "Emergency fund for unexpected expenses",
        "currentAmount": 2500.00,
        "targetAmount": 10000.00,
        "currency": "USD",
        "targetDate": "2024-12-31T00:00:00Z",
        "createdAt": "2024-01-01T00:00:00Z",
        "isActive": true,
        "contributors": ["user_123"],
        "walletId": "wallet_123"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 2,
      "totalItems": 25,
      "itemsPerPage": 20
    }
  }
}
```

### 7.2 Create Savings Goal
**POST** `/savings/goals`

**Request Body:**
```json
{
  "name": "Vacation Fund",
  "description": "Saving for summer vacation",
  "targetAmount": 5000.00,
  "currency": "USD",
  "targetDate": "2024-06-30T00:00:00Z"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Savings goal created successfully",
  "data": {
    "id": "goal_456",
    "name": "Vacation Fund",
    "description": "Saving for summer vacation",
    "currentAmount": 0.00,
    "targetAmount": 5000.00,
    "currency": "USD",
    "targetDate": "2024-06-30T00:00:00Z",
    "createdAt": "2024-01-15T10:30:00Z",
    "isActive": true,
    "contributors": ["user_123"],
    "walletId": "wallet_123"
  }
}
```

### 7.3 Add to Savings Goal
**POST** `/savings/goals/{goalId}/topup`

**Request Body:**
```json
{
  "amount": 500.00,
  "currency": "USD"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Savings goal updated successfully",
  "data": {
    "id": "goal_123",
    "name": "Emergency Fund",
    "description": "Emergency fund for unexpected expenses",
    "currentAmount": 3000.00,
    "targetAmount": 10000.00,
    "currency": "USD",
    "targetDate": "2024-12-31T00:00:00Z",
    "createdAt": "2024-01-01T00:00:00Z",
    "isActive": true,
    "contributors": ["user_123"],
    "walletId": "wallet_123"
  }
}
```

---

## 8. Insurance APIs

### 8.1 Get All Insurance Policies
**GET** `/insurance/policies?page=1&limit=20&status=active&type=health`

**Response:**
```json
{
  "success": true,
  "data": {
    "policies": [
      {
        "id": "policy_123",
        "name": "Comprehensive Health Insurance",
        "description": "Full health coverage including dental and vision",
        "type": "health",
        "providerName": "HealthGuard Insurance",
        "providerId": "provider_123",
        "premiumAmount": 150.00,
        "coverageAmount": 100000.00,
        "paymentFrequency": "monthly",
        "status": "active",
        "startDate": "2024-01-01T00:00:00Z",
        "endDate": "2024-12-31T00:00:00Z",
        "renewalDate": "2024-12-01T00:00:00Z",
        "beneficiaries": ["beneficiary_1", "beneficiary_2"],
        "policyDetails": {
          "deductible": 1000.00,
          "coverageLimit": 100000.00,
          "network": "preferred"
        },
        "policyNumber": "HG-123456789",
        "documentUrl": "https://api.shoramarkets.com/documents/policy_123.pdf",
        "createdAt": "2024-01-01T00:00:00Z",
        "updatedAt": "2024-01-15T10:30:00Z"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 45,
      "itemsPerPage": 20
    }
  }
}
```

### 8.2 Purchase Insurance Policy
**POST** `/insurance/policies`

**Request Body:**
```json
{
  "name": "Life Insurance Policy",
  "description": "Term life insurance coverage",
  "type": "life",
  "providerId": "provider_456",
  "premiumAmount": 75.00,
  "coverageAmount": 500000.00,
  "paymentFrequency": "monthly",
  "beneficiaries": ["beneficiary_3"]
}
```

**Response:**
```json
{
  "success": true,
  "message": "Insurance policy purchased successfully",
  "data": {
    "id": "policy_456",
    "name": "Life Insurance Policy",
    "description": "Term life insurance coverage",
    "type": "life",
    "providerName": "LifeSecure Insurance",
    "providerId": "provider_456",
    "premiumAmount": 75.00,
    "coverageAmount": 500000.00,
    "paymentFrequency": "monthly",
    "status": "pending",
    "startDate": "2024-01-15T00:00:00Z",
    "endDate": "2025-01-15T00:00:00Z",
    "renewalDate": "2024-12-15T00:00:00Z",
    "beneficiaries": ["beneficiary_3"],
    "policyDetails": {
      "term": "1 year",
      "coverageLimit": 500000.00
    },
    "policyNumber": "LS-987654321",
    "documentUrl": null,
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

### 8.3 Submit Insurance Claim
**POST** `/insurance/claims`

**Request Body:**
```json
{
  "policyId": "policy_123",
  "description": "Medical expenses for emergency surgery",
  "type": "health",
  "claimAmount": 5000.00,
  "incidentDate": "2024-01-10T00:00:00Z",
  "documents": ["document_1.pdf", "document_2.pdf"],
  "notes": "Emergency appendectomy"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Insurance claim submitted successfully",
  "data": {
    "id": "claim_123",
    "policyId": "policy_123",
    "policyName": "Comprehensive Health Insurance",
    "description": "Medical expenses for emergency surgery",
    "type": "health",
    "status": "submitted",
    "claimAmount": 5000.00,
    "incidentDate": "2024-01-10T00:00:00Z",
    "claimDate": "2024-01-15T10:30:00Z",
    "documents": ["document_1.pdf", "document_2.pdf"],
    "notes": "Emergency appendectomy",
    "createdAt": "2024-01-15T10:30:00Z"
  }
}
```

---

## 9. Chat APIs

### 9.1 Get Chat Rooms
**GET** `/chat/rooms?page=1&limit=20`

**Response:**
```json
{
  "success": true,
  "data": {
    "rooms": [
      {
        "id": "room_123",
        "name": "Investment Discussion",
        "description": "General investment discussions",
        "walletId": "wallet_123",
        "wallet": {
          "id": "wallet_123",
          "name": "Main Wallet",
          "balance": 10000.00,
          "currency": "USD"
        },
        "members": [
          {
            "id": "user_123",
            "name": "John Doe",
            "email": "john@example.com",
            "avatar": "https://api.shoramarkets.com/images/avatar_123.jpg",
            "role": "owner",
            "joinedAt": "2024-01-01T00:00:00Z",
            "isOnline": true,
            "lastSeenAt": "2024-01-15T10:30:00Z"
          }
        ],
        "createdAt": "2024-01-01T00:00:00Z",
        "lastMessageAt": "2024-01-15T10:25:00Z",
        "lastMessageContent": "Great investment opportunity!",
        "lastMessageSender": "John Doe",
        "unreadCount": 3,
        "isActive": true,
        "groupAvatar": "https://api.shoramarkets.com/images/group_123.jpg"
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalItems": 89,
      "itemsPerPage": 20
    }
  }
}
```

### 9.2 Get Chat Messages
**GET** `/chat/rooms/{roomId}/messages?page=1&limit=50`

**Response:**
```json
{
  "success": true,
  "data": {
    "messages": [
      {
        "id": "message_123",
        "chatId": "room_123",
        "senderId": "user_123",
        "senderName": "John Doe",
        "senderAvatar": "https://api.shoramarkets.com/images/avatar_123.jpg",
        "content": "Great investment opportunity!",
        "type": "text",
        "timestamp": "2024-01-15T10:25:00Z",
        "status": "read",
        "attachments": null,
        "replyToMessageId": null,
        "replyToMessageContent": null
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 10,
      "totalItems": 456,
      "itemsPerPage": 50
    }
  }
}
```

### 9.3 Send Chat Message
**POST** `/chat/rooms/{roomId}/messages`

**Request Body:**
```json
{
  "content": "I'm interested in this investment",
  "type": "text",
  "replyToMessageId": "message_123"
}
```

**Response:**
```json
{
  "success": true,
  "message": "Message sent successfully",
  "data": {
    "id": "message_456",
    "chatId": "room_123",
    "senderId": "user_456",
    "senderName": "Jane Smith",
    "senderAvatar": "https://api.shoramarkets.com/images/avatar_456.jpg",
    "content": "I'm interested in this investment",
    "type": "text",
    "timestamp": "2024-01-15T10:30:00Z",
    "status": "sent",
    "attachments": null,
    "replyToMessageId": "message_123",
    "replyToMessageContent": "Great investment opportunity!"
  }
}
```

---

## 10. Feed APIs

### 10.1 Get Feed Posts
**GET** `/feed/posts?page=1&limit=20&type=investment`

**Response:**
```json
{
  "success": true,
  "data": {
    "posts": [
      {
        "id": "post_123",
        "userId": "user_123",
        "userName": "John Doe",
        "userAvatar": "https://api.shoramarkets.com/images/avatar_123.jpg",
        "content": "Exciting new investment opportunity in renewable energy!",
        "imageUrls": [
          "https://api.shoramarkets.com/images/post_123_1.jpg",
          "https://api.shoramarkets.com/images/post_123_2.jpg"
        ],
        "videoUrl": null,
        "createdAt": "2024-01-15T10:00:00Z",
        "updatedAt": "2024-01-15T10:00:00Z",
        "likesCount": 45,
        "commentsCount": 12,
        "sharesCount": 8,
        "bookmarksCount": 23,
        "isLiked": false,
        "isBookmarked": true,
        "hashtags": ["#renewableenergy", "#investment", "#sustainability"],
        "location": "San Francisco, CA",
        "isVerified": true,
        "investmentAmount": "50000",
        "investmentStage": "Series A",
        "industry": "Renewable Energy",
        "companyName": "GreenTech Solutions",
        "fundingGoal": "2000000",
        "equityOffered": "15",
        "expectedReturn": "25",
        "investmentDuration": "5 years",
        "isInvestmentOpportunity": true
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 25,
      "totalItems": 487,
      "itemsPerPage": 20
    }
  }
}
```

### 10.2 Create Feed Post
**POST** `/feed/posts`

**Request Body:**
```json
{
  "content": "Just completed a successful investment in a fintech startup!",
  "imageUrls": ["https://api.shoramarkets.com/images/startup_123.jpg"],
  "hashtags": ["#fintech", "#investment", "#success"],
  "location": "New York, NY",
  "isInvestmentOpportunity": false
}
```

**Response:**
```json
{
  "success": true,
  "message": "Post created successfully",
  "data": {
    "id": "post_456",
    "userId": "user_123",
    "userName": "John Doe",
    "userAvatar": "https://api.shoramarkets.com/images/avatar_123.jpg",
    "content": "Just completed a successful investment in a fintech startup!",
    "imageUrls": ["https://api.shoramarkets.com/images/startup_123.jpg"],
    "videoUrl": null,
    "createdAt": "2024-01-15T10:30:00Z",
    "updatedAt": "2024-01-15T10:30:00Z",
    "likesCount": 0,
    "commentsCount": 0,
    "sharesCount": 0,
    "bookmarksCount": 0,
    "isLiked": false,
    "isBookmarked": false,
    "hashtags": ["#fintech", "#investment", "#success"],
    "location": "New York, NY",
    "isVerified": true,
    "isInvestmentOpportunity": false
  }
}
```

### 10.3 Like/Unlike Post
**POST** `/feed/posts/{postId}/like`

**Response:**
```json
{
  "success": true,
  "message": "Post liked successfully",
  "data": {
    "postId": "post_123",
    "isLiked": true,
    "likesCount": 46
  }
}
```

---

## 11. Search APIs

### 11.1 Global Search
**GET** `/search?q=technology&type=all&page=1&limit=20`

**Response:**
```json
{
  "success": true,
  "data": {
    "query": "technology",
    "results": {
      "brokers": [
        {
          "id": "broker_123",
          "name": "Sarah Johnson",
          "specialization": "Technology",
          "rating": 4.8,
          "location": "New York, NY"
        }
      ],
      "advisors": [
        {
          "id": "advisor_123",
          "name": "Michael Chen",
          "specialization": "Financial Planning",
          "rating": 4.9,
          "location": "San Francisco, CA"
        }
      ],
      "businesses": [
        {
          "id": "business_123",
          "name": "TechInnovate Solutions",
          "industry": "Technology",
          "stage": "Series A",
          "location": "Austin, TX"
        }
      ],
      "posts": [
        {
          "id": "post_123",
          "content": "Exciting new investment opportunity in renewable energy!",
          "userName": "John Doe",
          "createdAt": "2024-01-15T10:00:00Z"
        }
      ]
    },
    "pagination": {
      "currentPage": 1,
      "totalPages": 5,
      "totalItems": 89,
      "itemsPerPage": 20
    }
  }
}
```

---

## 12. Notifications APIs

### 12.1 Get Notifications
**GET** `/notifications?page=1&limit=20&type=all`

**Response:**
```json
{
  "success": true,
  "data": {
    "notifications": [
      {
        "id": "notification_123",
        "title": "Loan Payment Due",
        "message": "Your monthly loan payment of $2,250 is due in 3 days",
        "type": "loan",
        "isRead": false,
        "createdAt": "2024-01-15T10:00:00Z",
        "actionUrl": "/loans/loan_123",
        "metadata": {
          "loanId": "loan_123",
          "amount": 2250.00,
          "dueDate": "2024-01-18T00:00:00Z"
        }
      }
    ],
    "pagination": {
      "currentPage": 1,
      "totalPages": 3,
      "totalItems": 45,
      "itemsPerPage": 20
    }
  }
}
```

### 12.2 Mark Notification as Read
**PUT** `/notifications/{notificationId}/read`

**Response:**
```json
{
  "success": true,
  "message": "Notification marked as read"
}
```

---

## Error Responses

All APIs return consistent error responses:

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": {
      "field": "email",
      "reason": "Invalid email format"
    }
  }
}
```

### Common Error Codes:
- `UNAUTHORIZED` - Invalid or missing authentication
- `FORBIDDEN` - Insufficient permissions
- `NOT_FOUND` - Resource not found
- `VALIDATION_ERROR` - Invalid input data
- `RATE_LIMIT_EXCEEDED` - Too many requests
- `INTERNAL_SERVER_ERROR` - Server error

---

## Rate Limiting

- **Authentication endpoints**: 5 requests per minute
- **General API endpoints**: 100 requests per minute
- **File upload endpoints**: 10 requests per minute

Rate limit headers are included in responses:
```
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1640995200
```

---

## WebSocket Events

### Real-time Chat
- **Connection**: `wss://api.shoramarkets.com/ws/chat`
- **Events**:
  - `message_sent` - New message received
  - `user_typing` - User is typing
  - `user_online` - User came online
  - `user_offline` - User went offline

### Real-time Notifications
- **Connection**: `wss://api.shoramarkets.com/ws/notifications`
- **Events**:
  - `notification_received` - New notification
  - `payment_processed` - Payment status update
  - `loan_status_changed` - Loan status update

---

This API documentation covers all the major features identified in the Shora Markets codebase, excluding wallet-specific functionality as requested. The APIs are designed to support the full range of financial services, social features, and user management capabilities of the platform.
