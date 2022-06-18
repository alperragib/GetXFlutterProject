import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'login_page.dart';
import 'main_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Getx Flutter App'),
        centerTitle: true,
      ),
      floatingActionButton:
      Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton(
          heroTag: 1,
          onPressed: () {
            controller.sayacArtir();
          },
          child: Icon(Icons.add),
        ),
        SizedBox(
          height: 14.w,
        ),
        FloatingActionButton(
          heroTag: 2,
          onPressed: () {
            controller.sayacAzalt();
          },
          child: Icon(Icons.remove),
        ),
        SizedBox(
          height: 28.w,
        ),
        FloatingActionButton(
          heroTag: 3,
          onPressed: () {
            Get.changeThemeMode(
                Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
            controller.changeTheme(Get.isDarkMode ? false : true);
            setState(() {});
          },
          child: Icon(Icons.lightbulb_outline),
        ),
      ]),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: <Widget>[
                  Obx(() => Visibility(
                    visible: controller.username.value!="",
                    child: Text(
                      "Hoşgeldin\n"+controller.username.value.toString(),
                      style: TextStyle(
                          fontSize: 18.sp),textAlign: TextAlign.center,
                    ),
                  )),
                  Image.asset(
                    "assets/ym_logo.png",
                    color: controller.box.read('darkmode') ?? false
                        ? Colors.white
                        : null,
                    width: 200.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.w, bottom: 8.w),
                    child: Text(
                      'You have pushed the button this many times:',
                      style: TextStyle(fontSize: 21.sp),
                    ),
                  ),
                  Obx(() => Text(
                    controller.sayac.value.toString(),
                    style: TextStyle(
                        fontSize: 40.sp, fontWeight: FontWeight.bold),
                  )),
                  Padding(
                    padding: EdgeInsets.only(top: 32.w, bottom: 16.w),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(LoginPage());
                      },
                      child: Text(
                        'Login Page',
                        style: TextStyle(fontSize: 16.sp,color: Colors.white),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                        padding: MaterialStateProperty.all(EdgeInsets.only(right: 16.w, left: 16.w, top: 8.w, bottom: 8.w)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
