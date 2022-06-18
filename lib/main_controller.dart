import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_flutter_app/api_controller.dart';
import 'package:getx_flutter_app/main.dart';
import 'package:getx_flutter_app/weather.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainController extends GetxController {

  var sayac = 0.obs;
  var username = "".obs;
  final box = GetStorage();

  List<Weather> weatherList = List<Weather>();

  bool get isDark => box.read('darkmode') ?? false;

  ThemeMode get theme => isDark ? ThemeMode.dark : ThemeMode.light;

  void changeTheme(bool val) {
    box.write('darkmode', val);
  }

  void sayacArtir() {
    sayac.value = sayac.value + 1;
    box.write("sayac", sayac.value);
    /*
    Get.snackbar(
        'Sayaç değeri artırıldı.', 'Sayacın yeni değeri ${sayac.value} oldu.',
        colorText: Colors.white,
        backgroundColor: Colors.green,
        icon: Icon(Icons.add_circle_outline));

     */
  }

  void sayacAzalt() {
    if (sayac.value == 0) {
      Get.defaultDialog(
        barrierDismissible: true,
        title: "Oppsss!",
        middleText:
            "Sayacı negatif sayılara azaltmak istediğinize emin misiniz?",
        textCancel: "Hayır",
        textConfirm: "Evet",
        confirmTextColor: Get.isDarkMode ? Colors.black87 : Colors.white,
        onConfirm: () {
          sayac.value = sayac.value - 1;
          box.write("sayac", sayac.value);
          Get.back();
          /*
          Get.snackbar('Sayaç değeri azaltıldı.',
              'Sayacın yeni değeri ${sayac.value} oldu.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: Icon(Icons.remove_circle_outline));

           */
        },
      );
    } else {
      sayac.value = sayac.value - 1;
      box.write("sayac", sayac.value);
      /*
      Get.snackbar(
          'Sayaç değeri azaltıldı.', 'Sayacın yeni değeri ${sayac.value} oldu.',
          colorText: Colors.white,
          backgroundColor: Colors.red,
          icon: Icon(Icons.remove_circle_outline));

       */
    }
  }

  void usernameKaydet(String usernameG) {
    username.value = usernameG;
    box.write("username", username.value);
  }

  void usernameSil() {
    username.value = "";
    box.remove("username");
  }

  void weatherUpdate() {

    ApiController().getHavaDurumu().then((response) {
      if (response != null && response.body != null && response.isOk) {
        var jsonVeri = json.decode(response.body);
        if (jsonVeri['success'].toString() == "1") {
          weatherList = List<Weather>();
          var jsonArray = jsonVeri['Erzincan'] as List;
          for (int i = 0; i < jsonArray.length; i++) {
            weatherList.add(Weather(
                jsonArray[i]['tarih'],
                jsonArray[i]['gun'],
                jsonArray[i]['hava'],
                jsonArray[i]['sicaklik_yuksek'],
                jsonArray[i]['sicaklik_dusuk']));
          }
          /*
          Get.snackbar('Güncelleme Başarılı.',
              'Hava durumu tablosu başarıyla güncellendi.',
              colorText: Colors.white,
              backgroundColor: Colors.green,
              icon: Icon(Icons.check_circle_outline));

           */
          update();
        } else {
          /*
          Get.snackbar('Güncelleme Başarısız!',
              'Lütfen internet bağlantınızı kontrol ediniz.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: Icon(Icons.error_outline));

           */
        }
      } else {
        /*
        Get.snackbar('Güncelleme Başarısız!',
            'Lütfen internet bağlantınızı kontrol ediniz.',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.error_outline));

         */
      }
    });
  }

  Future<void> signInWithGoogle() async {

    FirebaseAuth auth = FirebaseAuth.instance;
    User user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);
        user = userCredential.user;
        if (user != null && user.email != null && user.displayName != null) {
          usernameKaydet(user.displayName);
          Get.off(MyHomePage());
        } else {
          Get.snackbar('Giriş Başarısız!',
              'Error occurred using Google Sign-In. Try again.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: Icon(Icons.error_outline));
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.snackbar('Giriş Başarısız!',
              'The account already exists with a different credential.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: Icon(Icons.error_outline));
        } else if (e.code == 'invalid-credential') {
          Get.snackbar('Giriş Başarısız!',
              'Error occurred while accessing credentials. Try again.',
              colorText: Colors.white,
              backgroundColor: Colors.red,
              icon: Icon(Icons.error_outline));
        }
      } catch (e) {
        Get.snackbar('Giriş Başarısız!',
            'Error occurred using Google Sign-In. Try again.',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.error_outline));
      }
    }
  }

  Future<void> signOut() async {
    final GoogleSignIn googleSignIn = GoogleSignIn();
    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser.isBlank) {

      usernameSil();

    } else {
      try {
        if (!kIsWeb) {
          await googleSignIn.signOut();
        }
        await auth.signOut();

        usernameSil();
      } catch (e) {
        Get.snackbar('Çıkış Yapılamadı!', 'Error signing out. Try again.',
            colorText: Colors.white,
            backgroundColor: Colors.red,
            icon: Icon(Icons.error_outline));
      }
    }
  }

  void firebaseInit()async{
     await Firebase.initializeApp();
  }

  @override
  void onInit() {
    sayac.value = box.read("sayac") ?? 0;
    username.value = box.read("username") ?? "";
    firebaseInit();
    weatherUpdate();
    super.onInit();
  }
}
