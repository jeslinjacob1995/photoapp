import 'package:get/get.dart';

import 'package:photoapp/app/modules/home/bindings/home_binding.dart';
import 'package:photoapp/app/modules/home/views/home_view.dart';
import 'package:photoapp/app/modules/viewImage/bindings/view_image_binding.dart';
import 'package:photoapp/app/modules/viewImage/views/view_image_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_IMAGE,
      page: () => ViewImageView(),
      binding: ViewImageBinding(),
    ),
  ];
}
