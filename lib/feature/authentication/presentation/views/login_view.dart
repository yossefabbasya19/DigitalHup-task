import 'package:digital_hub_task/core/assets_maneger.dart';
import 'package:digital_hub_task/core/route_manager/my_router.dart';
import 'package:digital_hub_task/core/validator/vaildator.dart';
import 'package:digital_hub_task/feature/authentication/presentation/views/widget/custom_elevated_button.dart';
import 'package:digital_hub_task/feature/authentication/presentation/views/widget/custom_text_button.dart';
import 'package:digital_hub_task/feature/authentication/presentation/views/widget/custom_text_form_field.dart';
import 'package:digital_hub_task/feature/authentication/presentation/views/widget/toggle_button.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formKey = GlobalKey();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.sizeOf(context).width * 0.03,
          ),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.05),
                Image(image: AssetImage(AssetsManager.appLogo)),
                CustomTextFormField(
                  icon: Icons.email,
                  txt: "Email",
                  isPassword: false,
                  validate: Validator.emailValidator,
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.015),
                CustomTextFormField(
                  icon: Icons.password,
                  txt: "Password",
                  isPassword: true,
                  validate: Validator.passwordValidator,
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                CustomTextButton(txt: "forget Password", onPressed: () {}),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                CustomElevatedButton(
                  isLoading: loading,
                  txt: "Login",
                  onPressed: () async{
                    loading = true;
                    setState(() {

                    });
                   await Future.delayed(Duration(seconds: 1),);
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, MyRouter.homeView);
                    }
                    loading = false;
                    setState(() {

                    });
                  },
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t Have Account?"),
                    CustomTextButton(txt: "Create Account", onPressed: () {}),
                  ],
                ),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.03),
                CustomToggleSwitch(),
                SizedBox(height: MediaQuery.sizeOf(context).height * 0.1),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
