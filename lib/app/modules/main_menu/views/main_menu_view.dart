import 'package:clinic_max/app/data/constant/assets_constant.dart';
import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/modules/account/views/account_view.dart';
import 'package:clinic_max/app/modules/home/views/home_view.dart';
import 'package:clinic_max/app/modules/medical.record/views/medical_record_view.dart';
import 'package:clinic_max/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../controllers/main_menu_controller.dart';

class MainMenuView extends GetView<MainMenuController> {
  const MainMenuView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.greyColor,
      body: PersistentTabView(
        context,
        controller: controller.bottomNavcontroller,
        hideNavigationBarWhenKeyboardShows: true,
        screens: <Widget>[
          HomeView(),
          MedicalRecordView(),
          AccountView(),
        ],
        items: [
          PersistentBottomNavBarItem(
            activeColorPrimary: ColorConstant.primaryColor,
            icon: Icon(
              Icons.home,
              size: 26.sp,
            ),
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: ColorConstant.primaryColor,
            icon: Icon(
              Icons.shopping_basket,
              size: 26.sp,
            ),
          ),
          PersistentBottomNavBarItem(
            activeColorPrimary: ColorConstant.primaryColor,
            icon: Icon(
              Icons.person,
              size: 26.sp,
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 52),
        child: FloatingActionButton(
          backgroundColor: ColorConstant.white,
          onPressed: () async{
            await controller.logout();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(
              AssetsConstant.svgIconCustomerCare,
              width: 40.w,
            ),
          ),
        ),
      ),
    );
  }
}
