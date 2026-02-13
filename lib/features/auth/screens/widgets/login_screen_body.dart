import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/utils/assets.dart';
import 'package:movix/features/auth/screens/widgets/identifiy_and_secur_text_container.dart';
import 'package:movix/features/auth/screens/widgets/or_divider_row.dart';
import 'package:movix/features/auth/screens/widgets/sign_up_container.dart';
import 'package:movix/features/auth/screens/widgets/custom_auth_button.dart';
import 'package:movix/features/auth/screens/widgets/custom_password_from_field.dart';
import 'package:movix/features/auth/screens/widgets/custom_text_form_field.dart';

class LoginScreenBody extends StatelessWidget {
  const LoginScreenBody({super.key});


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Image.asset(Assets.imagesLogo),
            Text('Welcome Back', style: AppTextStyles.bold30(context)),
            Text(
              'Sign in to sync your watchlists and favorites.',
              style: AppTextStyles.regular14(
                context,
              ).copyWith(color: AppColors.greyColor),
            ),
            const SizedBox(height: 8),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: const Color(0xff1E1E1E),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(25),
                child: Column(
                  children: [
                    CustomTextFormField(
                      labelText: 'EMAIL ADDRESS',
                      hintText: "Enter your email",
                      onSaved: (value) {},
                      fieldType: FieldType.email,
                      textInputAction: TextInputAction.done,
                    ),
                    const SizedBox(height: 20),
                    CustomPasswordFormField(
                      labelText: 'PASSWORD',
                      onSaved: (value) {},
                      fieldType: FieldType.password,
                      textInputAction: TextInputAction.done,
                      hintText: 'Enter your password',
                    ),
                    const SizedBox(height: 20),
                    CustomAuthButton(text: 'LogIn', onPressed: () {
                      log('login');
                      
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric( horizontal: 43),
              child: OrDividerRow(),
            ),
            const SizedBox(height: 16,),
            const SignUpContainer(),
            const SizedBox(height: 40,),
            const IdentifiyAndSecurTextContainer(),
          ],
        ),
      ),
    );
  }
}
