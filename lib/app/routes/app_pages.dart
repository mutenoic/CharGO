import 'package:get/get.dart';

import '../modules/add_credits/bindings/add_credits_binding.dart';
import '../modules/add_credits/views/add_credits_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map_screen/bindings/map_binding.dart';
import '../modules/map_screen/views/map_view.dart';
import '../modules/my_chargers/bindings/my_chargers_binding.dart';
import '../modules/my_chargers/views/my_chargers_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => const MapScreen(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.MY_CHARGERS,
      page: () => const MyChargersView(),
      binding: MyChargersBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CREDITS,
      page: () => const AddCreditsView(),
      binding: AddCreditsBinding(),
    ),
  ];
}
