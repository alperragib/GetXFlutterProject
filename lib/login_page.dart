import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_flutter_app/main_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  MainController controller = Get.find();

  var formKey = GlobalKey<FormState>();
  var textFieldUsername = TextEditingController();
  var textFieldPassword = TextEditingController();
  String errorText;
  Color primaryColor = Get.theme.primaryColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Login Page'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: <Widget>[
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 18.w, bottom: 18.w),
                          child: TextFormField(
                            controller: textFieldUsername,
                            style: TextStyle(fontSize: 18.sp),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorText: errorText,
                              errorStyle: TextStyle(color: primaryColor),
                              errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 3)),
                              disabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 3)),
                              labelText: 'Kullanıcı Adı',
                              labelStyle: TextStyle(color: primaryColor),
                              prefixIcon: Icon(
                                Icons.person,
                                color: primaryColor,
                              ),
                            ),
                            validator: (veri) {
                              if (veri.isEmpty) {
                                return "Bu alan boş bırakılamaz!";
                              } else if (veri.trim().length < 6) {
                                return "Kullanıcı adı minimum 6 karakter olabilir.";
                              } else if (!GetUtils.isUsername(veri.trim())) {
                                return "Girilen kullanıcı adı geçersiz.";
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 18.w, bottom: 32.w),
                          child: TextFormField(
                            controller: textFieldPassword,
                            obscureText: true,
                            style: TextStyle(fontSize: 18.sp),
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              errorText: errorText,
                              errorStyle: TextStyle(color: primaryColor),
                              errorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              border: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              focusedBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 3)),
                              disabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              enabledBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 2)),
                              focusedErrorBorder: new OutlineInputBorder(
                                  borderSide: new BorderSide(
                                      color: primaryColor, width: 3)),
                              labelText: 'Şifre',
                              labelStyle: TextStyle(color: primaryColor),
                              prefixIcon: Icon(
                                Icons.lock,
                                color: primaryColor,
                              ),
                            ),
                            validator: (veri) {
                              if (veri.isEmpty) {
                                return "Bu alan boş bırakılamaz!";
                              }
                              return null;
                            },
                          ),
                        ),
                        Obx(() => Visibility(
                              visible: controller.username.value == "",
                              child: ElevatedButton(
                                child: Padding(
                                  padding:
                                      EdgeInsets.only(top: 12.w, bottom: 12.w),
                                  child: Text(
                                    "Giriş Yap",
                                    style: TextStyle(
                                        fontSize: 18.sp, color: Colors.white),
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(primaryColor),
                                ),
                                onPressed: () {
                                  if (formKey.currentState.validate()) {
                                    FocusScope.of(context).unfocus();
                                    String username =
                                        textFieldUsername.text.trim();
                                    String password =
                                        textFieldPassword.text.trim();
                                    controller.usernameKaydet(username);
                                    textFieldUsername.text = "";
                                    textFieldPassword.text = "";
                                    Get.back();

                                  }
                                },
                              ),
                            )),
                        Obx(() => Visibility(
                              visible: controller.username.value == "",
                              child: Padding(
                                padding: EdgeInsets.only(top: 18.w),
                                child: ElevatedButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.w, bottom: 12.w),
                                    child: Text(
                                      "Google ile Giriş Yap",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.white),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                  ),
                                  onPressed: () {
                                    controller.signInWithGoogle();
                                  },
                                ),
                              ),
                            )),
                        Obx(() => Visibility(
                              visible: controller.username.value != "",
                              child: Padding(
                                padding:
                                    EdgeInsets.only(top: 18.w, bottom: 18.w),
                                child: ElevatedButton(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        top: 12.w, bottom: 12.w),
                                    child: Text(
                                      "Çıkış Yap",
                                      style: TextStyle(
                                          fontSize: 18.sp, color: Colors.white),
                                    ),
                                  ),
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(primaryColor),
                                  ),
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    controller.signOut();
                                    textFieldUsername.text = "";
                                    textFieldPassword.text = "";
                                  },
                                ),
                              ),
                            )),
                      ],
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
