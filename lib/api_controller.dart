
import 'package:get/get_connect/connect.dart';

class ApiController extends GetConnect {

  Future<Response<dynamic>> getHavaDurumu() => get('http://yazilimmuhendisim.com/api/hava_durumu.php');



/*
 Map map = {'id': '1', 'name': 'yazilimmuhendisim'};

  Future<Response> postUser(Map data) {
    post("", data);
  }


  Future<Response> postCases(List<int> image) {
    final form = FormData({
      'file': MultipartFile(image, filename: 'avatar.png'),
      'otherFile': MultipartFile(image, filename: 'cover.png'),
    });
    return post('http://youapi/users/upload', form);
  }
*/
}