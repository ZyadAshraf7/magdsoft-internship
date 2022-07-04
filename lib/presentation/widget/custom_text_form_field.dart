import 'package:flutter/material.dart';

import '../styles/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final bool isPasswordField;
  final bool isPasswordVisible;
  TextEditingController? textEditingController;
  VoidCallback? changePasswordVisibility;

  CustomTextFormField({
    required this.hintText,
    required this.isPasswordField,
    required this.textEditingController,
    this.isPasswordVisible = false,
    this.changePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border:  Border.all(color: AppColor.darkGrey),
            color: AppColor.darkWhite,
            borderRadius: BorderRadius.circular(6),
          ),
          height: 53,
          width: 310,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            controller: textEditingController,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              hintStyle: const TextStyle(
                  color: AppColor.grey,
                  fontSize: 18
              ),
              contentPadding: const EdgeInsets.only(left: 20,right:20, top: 5),
              border: InputBorder.none,
              errorBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: hintText,
              //suffixIconColor: AppTheme.midGreyColor,
              suffixIcon: isPasswordField
                  ? IconButton(
                      onPressed: changePasswordVisibility,
                      icon: isPasswordVisible
                          ? const Icon(
                              Icons.visibility_off_rounded,
                              color: AppColor.grey,
                            )
                          : const Icon(
                              Icons.remove_red_eye,
                              color: AppColor.grey,
                            ),
                    )
                  : const SizedBox(),
            ),
          ),
        ),
      ],
    );
  }
}
