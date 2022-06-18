import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'main_controller.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Profile Page'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    size: 150.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.w,bottom: 16.w),
                    child: Obx(() => Text(
                      controller.username.value.isEmpty? "username":controller.username.value.toString(),
                      style: TextStyle(fontSize: 21.sp,fontWeight: FontWeight.bold)
                    )),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
