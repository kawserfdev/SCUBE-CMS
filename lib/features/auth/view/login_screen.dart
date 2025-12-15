import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_colors.dart';

import '../../../core/constants/app_sizes.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  InputDecoration _fieldDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppColors.textSecondary,
        fontSize: AppSizes.fontSizeXl,
      ),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.lg),
        borderSide: const BorderSide(color: AppColors.border, width: 2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.lg),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xl,
        vertical: AppSizes.xl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            // Top blue section
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: AppSizes.xxl),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo placeholder (replace with Image.asset/SVG if you have it)
                    Container(
                      width: 110,
                      height: 110,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.route_outlined,
                          size: 54,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.xxl,
                    ), // 22 -> 24 roughly or leaving 22
                    const Text(
                      'SCUBE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(
                      height: AppSizes.sm,
                    ), // 10 -> sm (8) or md (12)
                    const Text(
                      'Control & Monitoring System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom white card
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(44),
                    topRight: Radius.circular(44),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSizes.sm),
                      const Text(
                        'Login',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 40,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwSections,
                      ), // 26 -> 32? or 24 (xxl)
                      // Username
                      TextFormField(
                        decoration: _fieldDecoration(hint: 'Username'),
                      ),
                      const SizedBox(
                        height: AppSizes.spaceBtwInputFields,
                      ), // 18 -> 16
                      // Password
                      TextFormField(
                        obscureText: true,
                        decoration: _fieldDecoration(
                          hint: 'Password',
                          suffix: const Icon(
                            Icons.remove_red_eye_outlined,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Forget password?',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: AppSizes.fontSizeLg,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSizes.spaceBtwInputFields),

                      SizedBox(
                        height: 64,
                        child: ElevatedButton(
                          onPressed: controller.login,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppSizes.cardRadius,
                              ),
                            ),
                          ),
                          child: Obx(
                            () => controller.isLoading.value
                                ? const SizedBox(
                                    height: 22,
                                    width: 22,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2.5,
                                    ),
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSizes.spaceBtwInputFields),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t have any account? ",
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Register Now',
                              style: TextStyle(
                                color: AppColors.primary,
                                fontSize: AppSizes.fontSizeXl,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSizes.md),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
