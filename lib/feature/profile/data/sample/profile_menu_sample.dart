import 'package:shatably_app/core/utils/app_icons.dart';
import 'package:shatably_app/feature/profile/data/models/profile_model.dart';

List<ProfileMenuItem> getProfileMenuItems() {
  return [
    ProfileMenuItem(
      icon: AppIcons.paymentIcon,
      title: "Edit Profile",
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: AppIcons.paymentIcon,
      title: "Payment Methods",
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: AppIcons.transactioIcon,
      title: "Transactions",
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: AppIcons.helpIcon,
      title: "Help Center",
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: AppIcons.settingsIcon,
      title: "Settings",
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: AppIcons.policiesIcon,
      title: "Terms and Conditions",
      onTap: () {},
    ),
    ProfileMenuItem(
      icon: AppIcons.logoutIcon,
      title: "Logout",
      isLogout: true,
      onTap: () {},
    ),
  ];
}
