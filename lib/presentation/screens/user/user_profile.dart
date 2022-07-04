import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app_local.dart';
import '../../../business_logic/login_cubit/login_cubit.dart';
import '../../../data/models/account_model.dart';
import '../../styles/colors.dart';
import '../../widget/custom_button.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final UserModel? user = BlocProvider.of<LoginCubit>(context).userModel;
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: AppColor.blue,
        title: Text(
          "${getLang(context, 'userData')}",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'Name: ' + (user!.fullName!),
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue,
                    ),
                  ),
                  Text(
                    'Email: ' + (user.email!),
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue,
                    ),
                  ),
                  Text(
                    'Phone: ' + (user.phoneNumber!),
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: AppColor.blue,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: CustomButton(
                      title: "${getLang(context, 'logout')}",
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      color: AppColor.red,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
