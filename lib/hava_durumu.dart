import 'package:flutter/material.dart';
import 'package:getx_flutter_app/main_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class HavaDurumu extends StatefulWidget {
  @override
  _HavaDurumuState createState() => _HavaDurumuState();
}

class _HavaDurumuState extends State<HavaDurumu> {
  MainController main_controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('15 days weather forecast in Erzincan'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 15,
        onPressed: () {
          main_controller.weatherUpdate();
        },
        child: Icon(
          Icons.refresh,
          size: 33,
        ),
      ),
      body: GetBuilder<MainController>(
        builder: (controller) => ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: controller.weatherList.length,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {
                  Share.share(
                      controller.weatherList[index].date +
                          ' ' +
                          controller.weatherList[index].gun +
                          ' günü Erzincan ' +
                          controller.weatherList[index].sicaklik_yuksek +
                          ' / ' +
                          controller.weatherList[index].sicaklik_dusuk +
                          ' ' +
                          controller.weatherList[index].hava,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        children: [
                          Text(
                            controller.weatherList[index].gun,
                          ),
                          Spacer(),
                          Text(
                            controller.weatherList[index].date
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 8.w, bottom: 2.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Text(
                                controller.weatherList[index].sicaklik_yuksek +
                                    ' / ' +
                                    controller
                                        .weatherList[index].sicaklik_dusuk +
                                    '   ' +
                                    controller.weatherList[index].hava,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
