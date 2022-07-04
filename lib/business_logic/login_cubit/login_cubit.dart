import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/models/account_model.dart';
import '../../data/network/responses/login_respository.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginRepository}) : super(LoginInitial());
  LoginRepository loginRepository;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  UserModel? userModel;
  Future loginUser(String email,String password)async{
    emit(LoginLoading());
    final data = await loginRepository.loginUser(email, password) as Map<String,dynamic>;
    if(data['status']==200){
      emit(LoginSuccess());
      final account = data['account'] as List<dynamic>;
      final userInfo = account.map((e) => UserModel.fromJson(e)).toList();
      userModel = userInfo.first;
      //print(userInfo.first.email);
    }else{
      emit(LoginErrorOccurred());
    }
  }

  bool loginValidation() {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      emit(LoginEmptyField());
      return false;
    }
    if (!emailController.text.contains('@')) {
      emit(LoginInvalidEmail());
      return false;
    }
    if(passwordController.text.length<6){
      emit(LoginWeakPassword());
      return false;
    }
    return true;
  }
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibility());
  }
  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
