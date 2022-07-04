import '../../../constants/end_points.dart';
import '../../remote/dio_helper.dart';

class LoginRepository{
  Future loginUser(String email,String password)async{
    final response = await DioHelper.postData(url: loginURL, body: {
      "email": email,
      "password": password,
    });
    return response.data;
  }
}