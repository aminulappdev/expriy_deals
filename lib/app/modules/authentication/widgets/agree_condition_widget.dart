import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AgreeConditionCheck extends StatefulWidget {
  const AgreeConditionCheck({
    super.key,
    required this.onChanged,
  });

  final ValueChanged<bool> onChanged;

  @override
  State<AgreeConditionCheck> createState() => _AgreeConditionCheckState();
}

class _AgreeConditionCheckState extends State<AgreeConditionCheck> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
            widget.onChanged(isChecked); // notify parent
          },
        ),
        Flexible(
          child: RichText(
            text:  TextSpan(
              children: [
                TextSpan(
                  text: 'agree_condition.agree '.tr,
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'agree_condition.terms'.tr,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black),
                ),
                TextSpan(
                  text: 'agree_condition.and '.tr,
                  style: TextStyle(color: Colors.black),
                ),
                TextSpan(
                  text: 'agree_condition.privacy'.tr,
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
