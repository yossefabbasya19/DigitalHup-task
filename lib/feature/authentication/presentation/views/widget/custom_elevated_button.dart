import 'package:digital_hub_task/core/app_color/app_color.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.txt,
    required this.onPressed,
    this.isLoading = false,
  });

  final String txt;
  final bool? isLoading;

  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          backgroundColor: WidgetStatePropertyAll(AppColor.black),
        ),
        onPressed: onPressed,
        child: isLoading!
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                txt,
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                ),
              ),
      ),
    );
  }
}
