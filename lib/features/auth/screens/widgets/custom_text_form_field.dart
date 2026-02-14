import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/utils/build_out_line_input_border.dart';
import 'package:movix/core/utils/functions.dart';

enum FieldType { email, password, newPassword, name, age, text }

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
    required this.fieldType,
    this.focusNode,
    required this.textInputAction,
    this.onFieldSubmitted,
  });

  final String labelText;
  final String hintText;
  final void Function(String?)? onSaved;
  final FieldType fieldType;

  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: AppTextStyles.semiBold12(context).copyWith(
            color: AppColors.greyColor,
          ),
        ),

        const SizedBox(height: 8),

        TextFormField(
          style: AppTextStyles.medium14(context).copyWith(
            color: const Color(0xff6B7280),
          ),
          keyboardType: fieldType == FieldType.age
              ? TextInputType.number
              : TextInputType.emailAddress,
          autofillHints: fieldType == FieldType.email
              ? [AutofillHints.email]
              : fieldType == FieldType.name
              ? [AutofillHints.name]
              : null,
              
          focusNode: focusNode,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          validator: (value) {
            return validatorFunction(
              value,
              labelText: labelText,
              fieldType: fieldType,
            );
          },

          onSaved: onSaved,
          decoration: InputDecoration(
            fillColor: const Color(0xff121212),
            filled: true,
            contentPadding: const EdgeInsets.only( left: 16, right: 16, top: 10, bottom: 10) ,
            border: buildOutLineInputBorder(),
            enabledBorder: buildOutLineInputBorder(),
            focusedBorder: buildOutLineInputBorder().copyWith(
              borderSide: const BorderSide(
                color: Color(0xff121212),
                width: 2,
              ),
            ),
            hintText: hintText,
            hintStyle: AppTextStyles.regular14(
              context,
            ).copyWith(color: const Color(0xff6B7280)),
          ),
        ),
      ],
    );
  }
}
