import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/utils/build_out_line_input_border.dart';
import 'package:movix/core/utils/functions.dart';
import 'package:movix/features/auth/screens/widgets/confirm_auth_row.dart';
import 'package:movix/features/auth/screens/widgets/custom_text_form_field.dart';

class CustomPasswordFormField extends StatefulWidget {
  const CustomPasswordFormField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.onSaved,
    required this.fieldType,
    this.focusNode,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  final String labelText;
  final String hintText;
  final void Function(String?) onSaved;
  final FieldType fieldType;

  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;

  @override
  State<CustomPasswordFormField> createState() =>
      _CustomPasswordFormFieldState();
}

class _CustomPasswordFormFieldState extends State<CustomPasswordFormField> {
  bool isVisibale = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.labelText,
              style: AppTextStyles.semiBold12(context).copyWith(
                color: AppColors.greyColor,
                ),
            ),
            const Spacer(),
            ConfirmAuthRow(question: '', actionText: 'Forget?', action: () {
              log('forget password');
            }),
          ],
        ),

        const SizedBox(height: 8),

        TextFormField(
          style: AppTextStyles.medium14(context).copyWith(
            color: const Color(0xff6B7280),
          ),

          obscureText: !isVisibale,
          validator: (value) {
            return validatorFunction(
              value,
              labelText: widget.labelText,
              fieldType: widget.fieldType,
            );
          },
          onChanged: widget.onSaved,
          onSaved: widget.onSaved,
          autofillHints: widget.fieldType == FieldType.password
              ? [AutofillHints.password]
              : widget.fieldType == FieldType.newPassword
              ? [AutofillHints.newPassword]
              : null,
          focusNode: widget.focusNode,
          textInputAction: widget.textInputAction,
          onFieldSubmitted: widget.onFieldSubmitted,
          decoration: InputDecoration(
            fillColor: const Color(0xff121212),
            filled: true,
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 14.5,
              bottom: 14.5,
            ),
            border: buildOutLineInputBorder(),
            enabledBorder: buildOutLineInputBorder(),
            focusedBorder: buildOutLineInputBorder().copyWith(
              borderSide: const BorderSide(color: Color(0xff121212), width: 2),
            ),
            hintText: widget.hintText,
            hintStyle: AppTextStyles.regular14(context).copyWith(
              color: const Color(0xff6B7280),
              
            ),
            suffixIcon: IconButton(
              iconSize: 18,
              onPressed: () {
                setState(() {
                  isVisibale = !isVisibale;
                });
              },
              icon: isVisibale
                  ? const Icon(Icons.visibility_off, color: Colors.white)
                  : const Icon(Icons.visibility, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
