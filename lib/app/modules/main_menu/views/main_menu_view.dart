import 'package:clinic_max/app/data/constant/assets_constant.dart';
import 'package:clinic_max/app/data/constant/color_constant.dart';
import 'package:clinic_max/app/data/utils/widgets/loading.dart';
import 'package:clinic_max/app/modules/account/controllers/account_controller.dart';
import 'package:clinic_max/app/modules/account/views/account_view.dart';
import 'package:clinic_max/app/modules/home/views/home_view.dart';
import 'package:clinic_max/app/modules/medical.record/controllers/medical_record_controller.dart';
import 'package:clinic_max/app/modules/medical.record/views/medical_record_view.dart';
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
    final medicalRecordController = Get.put(MedicalRecordController());
    final accountController = Get.put(AccountController());

    return Scaffold(
      backgroundColor: ColorConstant.greyColor,
      resizeToAvoidBottomInset: false,
      body: PersistentTabView(
        context,
        controller: controller.bottomNavcontroller,
        hideNavigationBarWhenKeyboardShows: true,
        onItemSelected: (index) async {
          switch (index) {
            case 1:
              LoadingApp.show();
              await medicalRecordController.getMedicalRecord();
              await medicalRecordController.getUserData();
              LoadingApp.dismiss();
              break;
            case 2:
              LoadingApp.show();
              await accountController.getUserFromRemote();
              LoadingApp.dismiss();
              break;
            default:
          }
        },
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
          onPressed: () async {},
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
