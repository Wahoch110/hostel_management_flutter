import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'providers/student_provider.dart';
import 'providers/room_provider.dart';
import 'providers/notice_provider.dart';
import 'providers/history_provider.dart';
import 'routes/app_routes.dart';

import 'screens/auth/splash_screen.dart';
import 'screens/auth/welcome_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/auth/forgot_password_screen.dart';

import 'screens/student/main_screen.dart';
import 'screens/student/notices_screen.dart';
import 'screens/student/room_detail_screen.dart';
import 'screens/student/book_room_screen.dart';
import 'screens/student/complaint_screen.dart';
import 'screens/student/leave_request_screen.dart';
import 'screens/student/visitor_request_screen.dart';
import 'screens/student/room_change_screen.dart';
import 'screens/student/fee_payment_screen.dart';
import 'screens/student/edit_profile_screen.dart';
import 'screens/student/history_screen.dart';
import 'screens/student/help_faq_screen.dart';
import 'screens/student/contact_us_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => StudentProvider()),
        ChangeNotifierProvider(create: (_) => RoomProvider()),
        ChangeNotifierProvider(create: (_) => NoticeProvider()),
        ChangeNotifierProvider(create: (_) => HistoryProvider()),
      ],
      child: const HostelHubApp(),
    ),
  );
}

class HostelHubApp extends StatelessWidget {
  const HostelHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:                      'HostelHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor:            const Color(0xFF4F46E5),
        scaffoldBackgroundColor: const Color(0xFFF5F4FF),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF4F46E5),
            primary:   const Color(0xFF4F46E5)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF4F46E5),
          foregroundColor: Colors.white,
          elevation:       0,
          titleTextStyle: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF4F46E5),
            foregroundColor: Colors.white,
            elevation:       0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12)),
            textStyle: const TextStyle(
                fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      initialRoute: AppRoutes.splash,

      routes: {
        AppRoutes.splash:       (_) => const SplashScreen(),
        AppRoutes.welcome:      (_) => const WelcomeScreen(),
        AppRoutes.login:        (_) => const LoginScreen(),
        AppRoutes.signup:       (_) => const SignupScreen(),
        AppRoutes.forgotPass:   (_) => const ForgotPasswordScreen(),
        AppRoutes.main:         (_) => const MainScreen(),
        AppRoutes.notices:      (_) => const NoticesScreen(),
        AppRoutes.roomDetail:   (_) => const RoomDetailScreen(),
        AppRoutes.bookRoom:     (_) => const BookRoomScreen(),
        AppRoutes.complaint:    (_) => const ComplaintScreen(),
        AppRoutes.leaveRequest: (_) => const LeaveRequestScreen(),
        AppRoutes.visitorReq:   (_) => const VisitorRequestScreen(),
        AppRoutes.roomChange:   (_) => const RoomChangeScreen(),
        AppRoutes.feePayment:   (_) => const FeePaymentScreen(),
        AppRoutes.editProfile:  (_) => const EditProfileScreen(),
        AppRoutes.history:      (_) => const HistoryScreen(),
        AppRoutes.helpFaq:      (_) => const HelpFaqScreen(),
        AppRoutes.contactUs:    (_) => const ContactUsScreen(),
      },
    );
  }
}
