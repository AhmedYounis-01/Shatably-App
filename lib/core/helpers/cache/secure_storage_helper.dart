import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

final storage = FlutterSecureStorage();

class SecureStorageHelper {
  static final Logger logger = Logger();

  // Onboarding Methods
  static Future<void> saveOnboardingSeen() async {
    await storage.write(key: "onboardingSeen", value: 'true');
  }

  static Future<bool> hasSeenOnboarding() async {
    final value = await storage.read(key: "onboardingSeen");
    return value == 'true';
  }

  // التحقق من تسجيل الدخول بناءً على وجود UserId
  static Future<bool> isLoggedIn() async {
    final userId = await storage.read(key: "userId");
    logger.i('Checking if user is logged in: ${userId != null}');
    return userId != null; // المستخدم مسجل دخول إذا كان هناك userId محفوظ
  }

  // User Authentication Methods
  static Future<void> saveUserId(String userId) async {
    await storage.write(key: "userId", value: userId);
  }

  static Future<String?> getUserId() async {
    final userId = await storage.read(key: "userId");
    logger.i('UserId retrieved: $userId');
    return userId;
  }

  static Future<void> clearAll() async {
    await storage.deleteAll();
  }
}
