// filename: screen_access.dart

import '../../smine_widgets.dart';

class ScreenAccess {
  final bool canAccessEntry;
  final bool canAccessExit;
  final bool canAccessPayment;
  final bool canAccessLoading;
  final bool canAccessExpense;
  final bool canAccessInfo;
  final bool canAccessSunmiScreen;

  ScreenAccess({
    required this.canAccessEntry,
    required this.canAccessExit,
    required this.canAccessPayment,
    required this.canAccessLoading,
    required this.canAccessExpense,
    required this.canAccessInfo,
    required this.canAccessSunmiScreen,
  });

  factory ScreenAccess.forRole(UserRole role) {
    switch (role) {
      case UserRole.operator:
        return ScreenAccess(
          canAccessEntry: true,
          canAccessExit: true,
          canAccessPayment: true,
          canAccessLoading: false,
          canAccessExpense: false,
          canAccessInfo: false,
          canAccessSunmiScreen: false,
        );
      case UserRole.cashier:
        return ScreenAccess(
          canAccessEntry: false,
          canAccessExit: false,
          canAccessPayment: true,
          canAccessLoading: false,
          canAccessExpense: false,
          canAccessInfo: false,
          canAccessSunmiScreen: false,
        );
      case UserRole.loader:
        return ScreenAccess(
          canAccessEntry: false,
          canAccessExit: false,
          canAccessPayment: false,
          canAccessLoading: true,
          canAccessExpense: false,
          canAccessInfo: false,
          canAccessSunmiScreen: false,
        );
      case UserRole.admin:
        return ScreenAccess(
          canAccessEntry: true,
          canAccessExit: true,
          canAccessPayment: true,
          canAccessLoading: true,
          canAccessExpense: true,
          canAccessInfo: true,
          canAccessSunmiScreen: false,
        );
    }
  }
}
