import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../data/network/responses/register_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.registerRepository}) : super(RegisterInitial());
  RegisterRepository registerRepository;

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  String errorMessage = "";
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  Future registerUser(String fullName,String phoneNumber,String email,String password)async{
    emit(RegisterLoading());
    final data = await registerRepository.registerUser(fullName, phoneNumber, email, password) as Map<String,dynamic>;
    if(data['status']==200){
      print(data);
      emit(RegisterSuccess());
  }else{
      errorMessage = data['message'];
      emit(RegisterErrorOccurred());
    }
  }
  bool checkPasswordsEquivalent(){
    if(passwordController.text!=confirmPasswordController.text){
      emit(PasswordsNotEquivalent());
      return false;
    }
    return true;
  }
  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibility());
  }
  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ChangeConfirmPasswordVisibility());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    fullNameController.dispose();
    phoneNumberController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
