import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../app_local.dart';
import '../../../business_logic/register_cubit/register_cubit.dart';
import '../../styles/colors.dart';
import '../../widget/custom_button.dart';
import '../../widget/custom_text_form_field.dart';
import '../../widget/toast.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerCubit = BlocProvider.of<RegisterCubit>(context);
    Size size = MediaQuery.of(context).size;
    FToast().init(context);
    return Scaffold(
      backgroundColor: AppColor.blue,
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if(state is RegisterErrorOccurred){
            showToast(registerCubit.errorMessage);
          }
          if(state is RegisterSuccess){
            showToast("${getLang(context, 'accountCreatedSuccessfully')}");
            Navigator.pushReplacementNamed(context, '/');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Column(
                  children: [
                    SizedBox(
                      width: 227,
                      height: 167,
                      child: Image.asset(
                        "assets/images/logo.png",
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
                              hintText: '${getLang(context, 'fullName')}',
                              isPasswordField: false,
                              textEditingController: registerCubit.fullNameController,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              hintText: '${getLang(context, 'email')}',
                              isPasswordField: false,
                              textEditingController: registerCubit.emailController,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              hintText: '${getLang(context, 'phoneNumber')}',
                              isPasswordField: false,
                              textEditingController: registerCubit.phoneNumberController,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              hintText: "${getLang(context, 'password')}",
                              isPasswordField: true,
                              isPasswordVisible: registerCubit.isPasswordVisible,
                              changePasswordVisibility: registerCubit.changePasswordVisibility,
                              textEditingController: registerCubit.passwordController,
                            ),
                            const SizedBox(height: 12),
                            CustomTextFormField(
                              hintText: "${getLang(context, 'confirmPassword')}",
                              isPasswordField: true,
                              isPasswordVisible: registerCubit.isConfirmPasswordVisible,
                              changePasswordVisibility: registerCubit.changeConfirmPasswordVisibility,
                              textEditingController: registerCubit.confirmPasswordController,
                            ),
                            const SizedBox(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomButton(
                                  title: "${getLang(context, 'login')}",
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(context, '/');
                                  },
                                ),
                                const SizedBox(width: 18),
                                if (state is RegisterLoading)
                                  const CircularProgressIndicator()
                                else
                                  CustomButton(
                                    title: "${getLang(context, 'register')}",
                                    onPressed: () {
                                      if(registerCubit.checkPasswordsEquivalent()) {
                                        registerCubit.registerUser(
                                          registerCubit.fullNameController.text,
                                          registerCubit.phoneNumberController.text,
                                          registerCubit.emailController.text,
                                          registerCubit.passwordController.text,
                                        );
                                      }else{
                                        showToast("${getLang(context, 'passwordsNotEquivalent')}");
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
