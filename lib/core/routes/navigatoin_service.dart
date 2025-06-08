// import 'package:flutter/material.dart';

// class NavigationService {
//   NavigationService._();
//   static final NavigationService instance = NavigationService._();
//   final navKey = GlobalKey<NavigatorState>();

//   bool _checkDuplicates({
//     required String routePath,
//     required Object? arguments,
//   }) {
//     bool isNewRouteSameRoute = false;

//     popUntil(
//       predicate: (route) {
//         var isNewRouteSameRoute = route.settings.name == routePath;

//         return isNewRouteSameRoute;
//       },
//     );

//     return isNewRouteSameRoute;
//   }

//   Future<T?> popAndPushNamed<T>({
//     required String path,
//     Object? arguments,
//     bool preventDuplicate = false,
//   }) async {
//     if (preventDuplicate) {
//       if (_checkDuplicates(routePath: path, arguments: arguments)) {
//         return Future.value();
//       }
//     }
//     return navKey.currentState?.popAndPushNamed<T, T>(
//       path,
//       arguments: arguments,
//     );
//   }

//   Future<T?> pushNamed<T>({
//     required String path,
//     Object? arguments,
//     bool preventDuplicate = false,
//   }) async {
//     if (preventDuplicate) {
//       if (_checkDuplicates(routePath: path, arguments: arguments)) {
//         return Future.value();
//       }
//     }
//     return navKey.currentState?.pushNamed<T>(
//       path,
//       arguments: arguments,

//     );
//   }

//   Future<T?> pushReplacementNamed<T>({
//     required String path,
//     Object? arguments,
//   }) async =>
//       navKey.currentState?.pushReplacementNamed(
//         path,
//         arguments: arguments,
//       );

//   Future<T?> pushReplacement<T>({
//     required Widget page,
//     Object? arguments,
//   }) async =>
//       navKey.currentState?.pushReplacement(
//         MaterialPageRoute(
//             builder: (_) => page,
//             settings: RouteSettings(arguments: arguments)),
//       );

//   Future<T?> pushAndRemoveUntil<T>({
//     required String path,
//     Object? arguments,
//     bool Function(Route<dynamic> route)? predicate,
//   }) =>
//       navKey.currentState!.pushNamedAndRemoveUntil<T?>(
//         path,
//         predicate ?? (route) => false,
//         arguments: arguments,
//       );

//   Future<void> pop<T>({
//     T? result,
//   }) async =>
//       navKey.currentState?.pop<T>(
//         result,
//       );

//   Future<void> popUntil({
//     required bool Function(Route<dynamic> route) predicate,
//   }) async =>
//       navKey.currentState?.popUntil(
//         predicate,
//       );
// }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// import 'package:flutter/material.dart';

// class NavigationService {
//   NavigationService._();
//   static final NavigationService instance = NavigationService._();
//   final navKey = GlobalKey<NavigatorState>();

//   // Helper method to get the correct NavigatorState
//   NavigatorState? _getNavigatorState({
//     BuildContext? context,
//     bool rootNavigator = true,
//   }) {
//     if (context != null) {
//       return Navigator.of(context, rootNavigator: rootNavigator);
//     }
//     return navKey
//         .currentState; // Fallback to root navigator if context not provided
//   }

//   bool _checkDuplicates({
//     required String routePath,
//     required Object? arguments,
//     BuildContext? context, // Added context to _checkDuplicates
//     bool rootNavigator = true, // Added rootNavigator to _checkDuplicates
//   }) {
//     bool isNewRouteSameRoute = false;
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );

//     navigator?.popUntil((route) {
//       isNewRouteSameRoute = route.settings.name == routePath;
//       return isNewRouteSameRoute;
//     });

//     return isNewRouteSameRoute;
//   }

//   Future<T?> popAndPushNamed<T>({
//     required String path,
//     Object? arguments,
//     bool preventDuplicate = false,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) async {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );

//     if (preventDuplicate) {
//       if (_checkDuplicates(
//         routePath: path,
//         arguments: arguments,
//         context: context,
//         rootNavigator: rootNavigator,
//       )) {
//         return Future.value();
//       }
//     }
//     return navigator?.popAndPushNamed<T, T>(path, arguments: arguments);
//   }

//   Future<T?> pushNamed<T>({
//     required String path,
//     Object? arguments,
//     bool preventDuplicate = false,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) async {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );

//     if (preventDuplicate) {
//       if (_checkDuplicates(
//         routePath: path,
//         arguments: arguments,
//         context: context,
//         rootNavigator: rootNavigator,
//       )) {
//         return Future.value();
//       }
//     }
//     return navigator?.pushNamed<T>(path, arguments: arguments);
//   }

//   Future<T?> pushReplacementNamed<T>({
//     required String path,
//     Object? arguments,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) async {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );
//     return navigator?.pushReplacementNamed(path, arguments: arguments);
//   }

//   Future<T?> pushReplacement<T>({
//     required Widget page,
//     Object? arguments,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) async {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );
//     return navigator?.pushReplacement(
//       MaterialPageRoute(
//         builder: (_) => page,
//         settings: RouteSettings(arguments: arguments),
//       ),
//     );
//   }

//   Future<T?> pushAndRemoveUntil<T>({
//     required String path,
//     Object? arguments,
//     bool Function(Route<dynamic> route)? predicate,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );
//     return navigator!.pushNamedAndRemoveUntil<T?>(
//       path,
//       predicate ?? (route) => false,
//       arguments: arguments,
//     );
//   }

//   Future<void> pop<T>({
//     T? result,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) async {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );
//     return navigator?.pop<T>(result);
//   }

//   Future<void> popUntil({
//     required bool Function(Route<dynamic> route) predicate,
//     BuildContext? context, // New: Optional BuildContext for specific Navigator
//     bool rootNavigator = true, // New: Optional rootNavigator flag
//   }) async {
//     final navigator = _getNavigatorState(
//       context: context,
//       rootNavigator: rootNavigator,
//     );
//     return navigator?.popUntil(predicate);
//   }
// }

//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';

class NavigationService {
  NavigationService._();
  static final NavigationService instance = NavigationService._();

  // Global navigator key for root navigation
  final GlobalKey<NavigatorState> rootNavKey = GlobalKey<NavigatorState>();

  // Navigator key for tab navigation (inside bottom nav bar)
  final GlobalKey<NavigatorState> tabNavKey = GlobalKey<NavigatorState>();

  // Get current context
  BuildContext? get currentContext =>
      rootNavKey.currentContext ?? tabNavKey.currentContext;

  // Check if we're currently in a tab navigation context
  bool get isInTabNavigation => tabNavKey.currentState != null;

  bool _checkDuplicates({
    required String routePath,
    required Object? arguments,
    bool useRootNavigator = false,
  }) {
    bool isNewRouteSameRoute = false;
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;

    if (navigatorState == null) return false;

    try {
      navigatorState.popUntil((route) {
        if (route.settings.name == routePath) {
          isNewRouteSameRoute = true;
          return true;
        }
        return route.isFirst;
      });
    } catch (e) {
      // Handle case where there's only one route in stack
      final currentRoute = ModalRoute.of(currentContext!);
      isNewRouteSameRoute = currentRoute?.settings.name == routePath;
    }

    return isNewRouteSameRoute;
  }

  // ==================== ROOT NAVIGATION METHODS ====================
  // Use these when you want to navigate outside the bottom nav bar context

  Future<T?> pushNamedWithRootNavigator<T>({
    required String path,
    Object? arguments,
    bool preventDuplicate = false,
  }) async {
    if (preventDuplicate) {
      if (_checkDuplicates(
        routePath: path,
        arguments: arguments,
        useRootNavigator: true,
      )) {
        return Future.value();
      }
    }
    return rootNavKey.currentState?.pushNamed<T>(path, arguments: arguments);
  }

  Future<T?> pushReplacementNamedWithRootNavigator<T>({
    required String path,
    Object? arguments,
  }) async => rootNavKey.currentState?.pushReplacementNamed<T, T>(
    path,
    arguments: arguments,
  );

  Future<T?> pushAndRemoveUntilWithRootNavigator<T>({
    required String path,
    Object? arguments,
    bool Function(Route<dynamic> route)? predicate,
  }) => rootNavKey.currentState!.pushNamedAndRemoveUntil<T?>(
    path,
    predicate ?? (route) => false,
    arguments: arguments,
  );

  // ==================== TAB NAVIGATION METHODS ====================
  // Use these for navigation within the bottom nav bar context

  Future<T?> pushNamedInTab<T>({
    required String path,
    Object? arguments,
    bool preventDuplicate = false,
  }) async {
    if (preventDuplicate) {
      if (_checkDuplicates(
        routePath: path,
        arguments: arguments,
        useRootNavigator: false,
      )) {
        return Future.value();
      }
    }
    return tabNavKey.currentState?.pushNamed<T>(path, arguments: arguments);
  }

  Future<T?> pushReplacementNamedInTab<T>({
    required String path,
    Object? arguments,
  }) async => tabNavKey.currentState?.pushReplacementNamed<T, T>(
    path,
    arguments: arguments,
  );

  // ==================== LEGACY METHODS (UPDATED) ====================
  // These now default to tab navigation but can be configured

  Future<T?> popAndPushNamed<T>({
    required String path,
    Object? arguments,
    bool preventDuplicate = false,
    bool useRootNavigator = false,
  }) async {
    if (preventDuplicate) {
      if (_checkDuplicates(
        routePath: path,
        arguments: arguments,
        useRootNavigator: useRootNavigator,
      )) {
        return Future.value();
      }
    }
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return navigatorState?.popAndPushNamed<T, T>(path, arguments: arguments);
  }

  Future<T?> pushNamed<T>({
    required String path,
    Object? arguments,
    bool preventDuplicate = false,
    bool useRootNavigator = false,
  }) async {
    if (preventDuplicate) {
      if (_checkDuplicates(
        routePath: path,
        arguments: arguments,
        useRootNavigator: useRootNavigator,
      )) {
        return Future.value();
      }
    }
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return navigatorState?.pushNamed<T>(path, arguments: arguments);
  }

  Future<T?> pushReplacementNamed<T>({
    required String path,
    Object? arguments,
    bool useRootNavigator = false,
  }) async {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return navigatorState?.pushReplacementNamed<T, T>(
      path,
      arguments: arguments,
    );
  }

  Future<T?> pushReplacement<T>({
    required Widget page,
    Object? arguments,
    bool useRootNavigator = false,
  }) async {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return navigatorState?.pushReplacement(
      MaterialPageRoute(
        builder: (_) => page,
        settings: RouteSettings(arguments: arguments),
      ),
    );
  }

  Future<T?> pushAndRemoveUntil<T>({
    required String path,
    Object? arguments,
    bool Function(Route<dynamic> route)? predicate,
    bool useRootNavigator = false,
  }) {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return navigatorState!.pushNamedAndRemoveUntil<T?>(
      path,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  // ==================== POP METHODS ====================

  Future<void> pop<T>({T? result, bool useRootNavigator = false}) async {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    if (navigatorState?.canPop() == true) {
      navigatorState?.pop<T>(result);
    }
  }

  Future<void> popUntil({
    required bool Function(Route<dynamic> route) predicate,
    bool useRootNavigator = false,
  }) async {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    navigatorState?.popUntil(predicate);
  }

  // ==================== UTILITY METHODS ====================

  bool canPop({bool useRootNavigator = false}) {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return navigatorState?.canPop() ?? false;
  }

  // Reset tab navigator to initial route
  void resetTabNavigator() {
    if (tabNavKey.currentState?.canPop() == true) {
      tabNavKey.currentState?.popUntil((route) => route.isFirst);
    }
  }

  // Reset root navigator to initial route
  void resetRootNavigator() {
    if (rootNavKey.currentState?.canPop() == true) {
      rootNavKey.currentState?.popUntil((route) => route.isFirst);
    }
  }

  // Get current route name
  String? getCurrentRouteName({bool useRootNavigator = false}) {
    final navigatorState =
        useRootNavigator ? rootNavKey.currentState : tabNavKey.currentState;
    return ModalRoute.of(
      navigatorState?.context ?? currentContext!,
    )?.settings.name;
  }

  // Navigate to specific tab and optionally push a route in that tab
  Future<void> navigateToTab({
    required int tabIndex,
    String? routeName,
    Object? arguments,
  }) async {
    // This method should be implemented in your main app or bottom nav bar widget
    // You can use a callback or state management to switch tabs
    // Then optionally push a route in that tab
    if (routeName != null) {
      await pushNamedInTab(path: routeName, arguments: arguments);
    }
  }
}
