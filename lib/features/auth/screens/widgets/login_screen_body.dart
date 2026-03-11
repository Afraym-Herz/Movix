import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/mixins/keyboard_dismiss_mixin.dart';
import 'package:movix/core/utils/app_colors.dart';
import 'package:movix/core/utils/app_text_styles.dart';
import 'package:movix/core/utils/assets.dart';
import 'package:movix/core/utils/debouncer.dart';
import 'package:movix/core/utils/form_auto_scroll_extension.dart';
import 'package:movix/core/utils/no_over_scroll_indicator_behavior.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_cubit.dart';
import 'package:movix/features/auth/data/auth_cubit/auth_state.dart';
import 'package:movix/features/auth/screens/widgets/identifiy_and_secur_text_container.dart';
import 'package:movix/features/auth/screens/widgets/or_divider_row.dart';
import 'package:movix/features/auth/screens/widgets/custom_auth_button.dart';
import 'package:movix/features/auth/screens/widgets/custom_password_from_field.dart';
import 'package:movix/features/auth/screens/widgets/custom_text_form_field.dart';
import 'package:movix/features/auth/screens/widgets/sign_up_container.dart';
import 'package:movix/features/main_layout.dart';

class LoginScreenBody extends StatefulWidget {
  const LoginScreenBody({super.key});

  @override
  State<LoginScreenBody> createState() => _LoginScreenBodyState();
}

class _LoginScreenBodyState extends State<LoginScreenBody>
    with KeyboardDismissMixin {
  final Debouncer debouncer = Debouncer();
  String username = '';
  String password = '';
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: NoOverscrollIndicatorBehavior(),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Image.asset(Assets.imagesLogo),
                      Text(
                        'Welcome Back',
                        style: AppTextStyles.bold30(context),
                      ),
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
                          child: Form(
                            key: formKey,
                            autovalidateMode: autovalidateMode,
                            child: Column(
                              children: [
                                CustomTextFormField(
                                  labelText: 'USERNAME',
                                  hintText: "Enter your username",
                                  onSaved: (value) {
                                    username = value!;
                                  },
                                  focusNode: focusNode,
                                  fieldType: FieldType.text,
                                  textInputAction: TextInputAction.next,
                                ),
                                const SizedBox(height: 20),
                                CustomPasswordFormField(
                                  labelText: 'PASSWORD',
                                  onSaved: (value) {
                                    password = value!;
                                  },
                                  onFieldSubmitted: (_) {
                                    focusNode.unfocus();
                                    _submitForm();
                                  },
                                  fieldType: FieldType.password,
                                  textInputAction: TextInputAction.done,
                                  hintText: 'Enter your password',
                                ),
                                const SizedBox(height: 20),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthFailure) {
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            "Invalid username or password",
                                          ),
                                        ),
                                      );
                                    }
                                    if (state is AuthSuccess) {
                                      Navigator.pushReplacementNamed(
                                        context,
                                        MainLayout.routeName,
                                      );
                                    }
                                  },
                                  buildWhen: (previous, current) =>
                                      current is AuthLoading ||
                                      current is AuthInitial ||
                                      current is AuthFailure,

                                  builder: (context, state) => CustomAuthButton(
                                    text: 'LogIn',
                                    onPressed: () {
                                      focusNode.unfocus();
                                      _submitForm();
                                    },
                                    isLoading: state is AuthLoading,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 43),
                        child: OrDividerRow(),
                      ),
                      const SizedBox(height: 16),
                      const SignUpContainer(),
                      const SizedBox(height: 40),
                      const IdentifiyAndSecurTextContainer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _submitForm() {
    if (formKey.validateAndScroll()) {
      formKey.currentState!.save();

      log('username: $username, password: $password');

      context.read<AuthCubit>().signin(email: username, password: password);
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }
}
