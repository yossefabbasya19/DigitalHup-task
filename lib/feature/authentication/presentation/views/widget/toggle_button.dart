import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:digital_hub_task/core/app_color/app_color.dart';
import 'package:digital_hub_task/core/assets_maneger.dart';
import 'package:flutter/material.dart';

class CustomToggleSwitch extends StatefulWidget {
  const CustomToggleSwitch({super.key});

  @override
  State<CustomToggleSwitch> createState() => _CustomToggleSwitchState();
}

class _CustomToggleSwitchState extends State<CustomToggleSwitch> {
   int nullableValue = 0;

  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<int?>.rolling(
      style: ToggleStyle(
        indicatorColor: AppColor.black,
        borderColor: AppColor.black,
        backgroundColor: Colors.white,
      ),
      height: MediaQuery.sizeOf(context).height * 0.05,
      allowUnlistedValues: false,
      styleAnimationType: AnimationType.onHover,
      current: nullableValue,
      values: const [0, 1],
      onChanged: (i) {
        if (i == 0) {
        } else {
        }
        nullableValue = i!;
        setState(() {

        });
      },
      padding: EdgeInsets.zero,
      iconBuilder: (value, foreground) {
        if (value == 0) {
          return Image(
            image: AssetImage(AssetsManager.egyptFlag),
            fit: BoxFit.fill,
          );
        } else {
          return Image(
            image: AssetImage(AssetsManager.aucFlag),
            fit: BoxFit.fill,
          );
        }
      },
    );
  }
}
