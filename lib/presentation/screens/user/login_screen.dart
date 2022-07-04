import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../app_local.dart';
import '../../../business_logic/localize_cubit/localize_cubit.dart';
import '../../../business_logic/login_cubit/login_cubit.dart';
import '../../styles/colors.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';
import '../../widget/toast.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final loginCubit = BlocProvider.of<LoginCubit>(context);
    FToast().init(context);
    return Scaffold(
      backgroundColor: AppColor.blue,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if(state is LoginEmptyField){
            showToast("${getLang(context, 'emptyFiledRequired')}");
          }
          else if(state is LoginInvalidEmail){
            showToast("${getLang(context, 'invalidEmail')}");
          }
          else if(state is LoginErrorOccurred){
            showToast("${getLang(context, 'wrongPassword')}");
          }
          else if(state is LoginWeakPassword){
            showToast("${getLang(context, 'weakPassword')}");
          }
          else if(state is LoginSuccess){
            Navigator.pushReplacementNamed(context, '/userProfile');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                height: size.height,
                width: size.width,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          if (AppLocale.of(context).isEnglishLocal) {
                            BlocProvider.of<LocalizeCubit>(context).translateToArabic();
                          } else {
                            BlocProvider.of<LocalizeCubit>(context).translateToEnglish();
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          height: 31,
                          width: 90,
                          decoration: const BoxDecoration(
                            color: AppColor.white,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Center(
                            child: Text(
                              "${getLang(context, 'language')}",
                              style: const TextStyle(color: AppColor.blue, fontSize: 17, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 227,
                      height: 167,
                      child: Image.asset(
                        "assets/images/flutterLogo.png",
                      ),
                    ),
                    const SizedBox(height: 14),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: AppColor.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomTextFormField(
                              hintText: '${getLang(context, 'email')}',
                              isPasswordField: false,
                              textEditingController: loginCubit.emailController,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              hintText: "${getLang(context, 'password')}",
                              isPasswordField: true,
                              isPasswordVisible: loginCubit.isPasswordVisible,
                              changePasswordVisibility: loginCubit.changePasswordVisibility,
                              textEditingController: loginCubit.passwordController,
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  title: "${getLang(context, 'register')}",
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/register');
                                  },
                                ),
                                const SizedBox(width: 18),
                                if (state is LoginLoading)
                                  const CircularProgressIndicator()
                                else
                                  CustomButton(
                                    title: "${getLang(context, 'login')}",
                                    onPressed: () {
                                      if (loginCubit.loginValidation()) {
                                        loginCubit.loginUser(loginCubit.emailController.text, loginCubit.passwordController.text);
                                      }
                                    },
                                  ),
                              ],
                            )
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
    );
  }
}
