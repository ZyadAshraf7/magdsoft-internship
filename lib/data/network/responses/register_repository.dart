import '../../../constants/end_points.dart';
import '../../remote/dio_helper.dart';

class RegisterRepository {
  Future registerUser(String fullName, String phoneNumber, String email, String password) async {
    final response = await DioHelper.postData(url: registerURL, body: {
      'name': fullName,
      'email': email,
      'password': password,
      'phone': phoneNumber,
    });
    return response.data;
  }
}
