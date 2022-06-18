import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_flutter_app/ProfilePage.dart';
import 'package:getx_flutter_app/hava_durumu.dart';
import 'package:getx_flutter_app/main_controller.dart';
import 'HomePage.dart';

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => GetMaterialApp(
        title: 'Getx Flutter App',
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.purple,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.purple, foregroundColor: Colors.white),
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.orange,
          floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.orange, foregroundColor: Colors.black),
        ),
        themeMode: controller.theme,
        home: MyHomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MainController controller = Get.find();

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    HavaDurumu(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      bottomNavigationBar: new Theme(
        data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).primaryColor,
        primaryColor: Colors.white),
        child: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud),
            label: "Weather Forecast",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        iconSize: 24.w,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      )),
      body: _widgetOptions.elementAt(_selectedIndex),

    );
  }
}
