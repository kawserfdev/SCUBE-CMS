import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scubecms/core/constants/app_assets.dart';
import 'package:scubecms/core/constants/app_colors.dart';

import '../../../core/constants/app_sizes.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  InputDecoration _fieldDecoration({required String hint, Widget? suffix}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(
        color: AppColors.textMuted,
        fontSize: AppSizes.fontSizeMd,
      ),
      suffixIcon: suffix,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
        borderSide: const BorderSide(color: AppColors.border, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppSizes.inputFieldRadius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xl,
        vertical: AppSizes.xl,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: AppSizes.xxl * 2),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: AppSizes.xxl),
                    Image.asset(AppAssets.appLogo, width: 110, height: 110),
                  
                    const SizedBox(
                      height: AppSizes.xl,
                    ), 
                    const Text(
                      'SCUBE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const Text(
                      'Control & Monitoring System',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(
              ()=> Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 22),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
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
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: AppSizes.xxl,
                        ),
                        // Username
                        TextFormField(
                          decoration: _fieldDecoration(hint: 'Username'),
                        ),
                        const SizedBox(
                          height: AppSizes.md,
                        ), // 18 -> 16
                        // Password
                        TextFormField(
                          obscureText: loginController.isPasswordVisible.value,
                          decoration: _fieldDecoration(
                            hint: 'Password',
                            suffix: IconButton(
                              onPressed: loginController.togglePasswordVisibility,
                              icon: Icon( loginController.isPasswordVisible.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.remove_red_eye_outlined,
                                color: loginController.isPasswordVisible.value
                                    ? AppColors.textSecondary
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
              
                        const SizedBox(height: AppSizes.sm),
              
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'Forget password?',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppSizes.fontSizeSm,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ),
              
                        const SizedBox(height: AppSizes.xl),
              
                        SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            onPressed: loginController.login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadius,
                                ),
                              ),
                            ),
                            child: Obx(
                              () => loginController.isLoading.value
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
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ),
                          ),
                        ),
              
                        const SizedBox(height: AppSizes.sm),
              
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don’t have any account? ",
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: AppSizes.fontSizeSm,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Text(
                                'Register Now',
                                style: TextStyle(
                                  color: AppColors.primary,
                                  fontSize: AppSizes.fontSizeMd,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.xxl * 3),
                      ],
                    ),
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
