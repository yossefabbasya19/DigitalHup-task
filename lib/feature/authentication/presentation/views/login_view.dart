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
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool loading = false;

  Future<void> _login(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;

    setState(() => loading = true);

    await Future.delayed(const Duration(seconds: 1));

      Navigator.pushReplacementNamed(context, MyRouter.homeView);

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),

              // Logo
              Image(image: AssetImage(AssetsManager.appLogo)),

              SizedBox(height: size.height * 0.03),

              // Email
              CustomTextFormField(
                icon: Icons.email,
                txt: "Email",
                isPassword: false,
                validate: Validator.emailValidator,
              ),

              SizedBox(height: size.height * 0.015),

              // Password
              CustomTextFormField(
                maxLineSelect: 1,
                icon: Icons.lock,
                txt: "Password",
                isPassword: true,
                validate: Validator.passwordValidator,
              ),

              SizedBox(height: size.height * 0.01),

              // Forget Password
              Align(
                alignment: Alignment.centerRight,
                child: CustomTextButton(
                  txt: "Forget Password?",
                  onPressed: () {},
                ),
              ),

              SizedBox(height: size.height * 0.015),

              // Login Button
              CustomElevatedButton(
                isLoading: loading,
                txt: "Login",
                onPressed: () => _login(context),
              ),

              SizedBox(height: size.height * 0.015),

              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account? "),
                  CustomTextButton(txt: "Create Account", onPressed: () {}),
                ],
              ),

              SizedBox(height: size.height * 0.03),

              // language Toggle
              const CustomToggleSwitch(),

              SizedBox(height: size.height * 0.1),
            ],
          ),
        ),
      ),
    );
  }
}
