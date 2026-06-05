# Hostel Hub

**Full Stack Hostel Management Mobile Application**

Hostel Hub is a full-stack mobile application developed using **Flutter**, **Node.js**, **Express.js**, and **MySQL**. The application provides hostel students with a centralized platform to manage complaints, leave requests, room bookings, notices, profile information, and other hostel-related services.

This project demonstrates complete frontend development, backend REST API development, MySQL database integration, and CRUD operations using modern software engineering practices.

---

# Project Overview

The Hostel Hub application was designed to simplify hostel management processes by providing students with a digital platform to interact with hostel services.

The application includes:

- Student Authentication
- Complaint Management
- Leave Request Management
- Room Booking
- Notice Management
- History Tracking
- Profile Management
- Contact & Support Features

For assignment requirements, two modules were fully integrated with a Node.js backend and MySQL database:

- Complaint Management Module
- Leave Request Management Module

---

# Assignment Requirements Covered

## Frontend

- Flutter User Interface
- Form Validation
- API Integration
- CRUD Screens

## Backend

- Node.js
- Express.js
- REST APIs
- Route Management

## Database

- MySQL Integration
- Database Design
- CRUD Operations

## Testing

- Postman API Testing
- Database Verification

---

# Features

## Authentication

- User Login
- User Registration
- Forgot Password
- Welcome Screen
- Splash Screen

## Student Services

- Complaint Management
- Leave Request Management
- Room Booking
- History Tracking
- Profile Management
- Edit Profile
- Contact Us
- Help & FAQs
- Fee Information

## Administrative Features

- Notice Management
- Room Information

## Backend Features

- REST API Integration
- MySQL Database Connectivity
- CRUD Operations
- Postman Tested Endpoints

---

# Technologies Used

## Frontend

- Flutter
- Dart
- Provider State Management

## Backend

- Node.js
- Express.js

## Database

- MySQL

## Testing

- Postman

## Development Tools

- VS Code
- MySQL Workbench
- GitHub
- Git

---

# Assignment Modules

## Module 1: Complaint Management

Implemented Complete CRUD Operations:

- Create Complaint
- Read Complaints
- Update Complaint
- Delete Complaint

### API Endpoints

| Method | Endpoint |
|----------|----------|
| GET | /complaints |
| POST | /complaints |
| PUT | /complaints/:id |
| DELETE | /complaints/:id |

---

## Module 2: Leave Request Management

Implemented Complete CRUD Operations:

- Create Leave Request
- Read Leave Requests
- Update Leave Request
- Delete Leave Request

### API Endpoints

| Method | Endpoint |
|----------|----------|
| GET | /leaves |
| POST | /leaves |
| PUT | /leaves/:id |
| DELETE | /leaves/:id |

---

# Project Structure

```text
HOSTEL_HUB/

├── android/
├── ios/
├── assets/

├── backend/
│   ├── routes/
│   │   ├── complaints.js
│   │   └── leaves.js
│   ├── database.sql
│   ├── db.js
│   ├── package.json
│   ├── POSTMAN_GUIDE.md
│   └── server.js

├── lib/
│   ├── models/
│   ├── providers/
│   ├── routes/
│   ├── screens/
│   │   ├── auth/
│   │   └── student/
│   ├── services/
│   ├── widgets/
│   └── main.dart

├── screenshots/
│   ├── dashboard.png
│   ├── complaint-module.png
│   ├── leave-module.png
│   ├── postman-api-testing.png
│   └── mysql-database.png

├── pubspec.yaml
└── README.md
```

---

# Project Screenshots

## Dashboard

![Dashboard](screenshots/dashboard.png.jpeg)

## Complaint Management Module

![Complaint Module](screenshots/complaint-module.png.jpeg)

## Leave Request Management Module

![Leave Module](screenshots/leave-module.png.jpeg)

## Postman API Testing

![Postman Testing](screenshots/postman-api-testing.png.jpeg)

## MySQL Database

![MySQL Database](screenshots/mysql-database.png.jpeg)

---

# Database

**Database Name**

```sql
hostel_hub_db
```

**Tables**

- complaints
- leaves

Database schema is available in:

```text
backend/database.sql
```

---

# Setup Instructions

## 1. Clone Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_LINK
cd HOSTEL_HUB
```

---

## 2. Database Setup

Create database:

```sql
CREATE DATABASE hostel_hub_db;
```

Run:

```text
backend/database.sql
```

inside MySQL Workbench.

Update credentials in:

```text
backend/db.js
```

---

## 3. Backend Setup

Navigate to backend folder:

```bash
cd backend
```

Install dependencies:

```bash
npm install
```

Run backend:

```bash
npm run dev
```

Backend URL:

```text
http://localhost:3000
```

---

## 4. Flutter Setup

Return to project root:

```bash
cd ..
```

Install packages:

```bash
flutter pub get
```

Run application:

```bash
flutter run
```

---

## API Configuration

### Flutter Web

```text
http://localhost:3000
```

### Android Emulator

```text
http://10.0.2.2:3000
```

### Physical Device

```text
http://YOUR_LOCAL_IP:3000
```

---

# Learning Outcomes

Through this project, I learned:

- Flutter Mobile Application Development
- State Management using Provider
- REST API Development using Express.js
- Node.js Backend Development
- MySQL Database Integration
- CRUD Operations
- API Testing using Postman
- Full Stack Mobile Application Development
- Git and GitHub Workflow
- Software Engineering Best Practices

---

# Author

**Muhammad Raza**

BS Software Engineering

SZABIST

Full Stack Mobile Application Development Project
