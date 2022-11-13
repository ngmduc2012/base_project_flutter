import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'controller.dart';

class CustomTextInput2 extends StatelessWidget {
  final String tag;
  final FormFieldValidator<String> validator;
  final String? initialValue;
  final bool isPasswordField;
  final String hintText;
  final bool suffixIcon;
  final Widget? focusIcon;
  final Widget? normalIcon;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<String>? onChanged;

  CustomTextInput2({
    Key? key,
    required this.tag,
    required this.isPasswordField,
    this.hintText = "",
    this.suffixIcon = false,
    required this.validator,
    this.initialValue,
    this.focusIcon,
    this.normalIcon,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.onFieldSubmitted,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CustomTextInput2Controller>(
        tag: tag,
        init: CustomTextInput2Controller(
          isPasswordField: isPasswordField,
          hintText: hintText,
          keyboardType: keyboardType,
          suffixIcon: suffixIcon,
          textInputAction: textInputAction,
          initialValue: initialValue ?? "",
        ),
        builder: (_) {
          return TextFormField(
            onChanged: onChanged,
            initialValue: initialValue,
            cursorColor: Colors.indigo,
            onFieldSubmitted: onFieldSubmitted,
            textInputAction: _.textInputAction,
            focusNode: _.focusNode,
            obscureText: _.isPasswordField && _.showPassword,
            keyboardType: _.keyboardType,
            decoration: InputDecoration(
              isDense: true,
              prefixIcon: _.hasFocus ? _.focusIcon : _.normalIcon,
              suffixIcon: _.isPasswordField && _.suffixIcon
                  ? GestureDetector(
                      onTap: () {
                        _.toggleShowPassword();
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        child: Icon(
                          _.showPassword
                              ? FontAwesomeIcons.eyeSlash
                              : FontAwesomeIcons.eye,
                          size: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    )
                  : null,
              filled: true,
              fillColor: Colors.grey[100],
              contentPadding: EdgeInsets.only(
                top: 16,
                left: _.normalIcon != null ? 45 : 16,
                right: 0,
                bottom: 12,
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              errorStyle: TextStyle(
                color: Colors.red,
                fontSize: 14,
              ),
              hintText: _.hintText,
              hintStyle: TextStyle(
                color: Colors.black45,
                fontWeight: FontWeight.w400,
              ),
            ),
            controller: _.controller,
            validator: validator,
          );
        });
  }
}
