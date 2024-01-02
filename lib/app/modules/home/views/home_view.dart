import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:maptask/common/app_colors/app_colors.dart';

import '../../../routes/app_pages.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:  Center(
        child: Center(
          child: InkWell(
            onTap: (){
              Get.toNamed(Routes.MAP);
            },
            child: Container(
              height: size.height * 0.08,
              width: size.width / 2,
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Center(child: Text("Choose your location",style: TextStyle(color: AppColors.white,fontSize: 16),),),
            ),
          ),
        )
      ),
    );
  }
}
