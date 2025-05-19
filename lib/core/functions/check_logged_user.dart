import 'package:shatably_app/core/helpers/extensions.dart';
import '../services/api/token_manager.dart';

bool isLoggedInUser = false;
checkIfLoggedInUser() async {
  String? userId = await TokenManager.getRefreshToken();

  if (!userId.isNullOrEmpty()) {
    isLoggedInUser = true;
  } else {
    isLoggedInUser = false;
  }
}
