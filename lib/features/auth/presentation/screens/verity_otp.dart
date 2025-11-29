import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ost_ecommerce/features/auth/presentation/controllers/verify_otp_controller.dart';
import 'package:ost_ecommerce/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:ost_ecommerce/features/shared/presentation/widgets/centered_circular_progress.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../app/app_colors.dart';
import '../../../../app/controllers/auth_controller.dart';
import '../../../shared/presentation/screens/bottom_nav_holder_screen.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../../data/models/verify_otp_request_model.dart';
import '../widgets/app_logo.dart';


class OtpController extends GetxController {
  var secondsRemaining = 120.obs;

  @override
  void onInit() {
    super.onInit();
    _startTimer();
  }

  void _startTimer() async {
    while (secondsRemaining.value > 0) {
      await Future.delayed(const Duration(seconds: 1));
      secondsRemaining.value--;
    }
  }
}


class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key, required this.email});

  static const String name = '/verify-otp';
  final String email;

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  final VerifyOtpController _verifyOtpController = Get.find<VerifyOtpController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final OtpController controller = Get.put(OtpController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 48),
                AppLogo(width: 100),
                const SizedBox(height: 24),
                Text('Verify OTP', style: textTheme.titleLarge),
                Text(
                  'A 6 digits OTP has been sent to your email address',
                  style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                ),
                const SizedBox(height: 24),
                PinCodeTextField(
                  length: 4,
                  obscureText: false,
                  keyboardType: TextInputType.number,
                  pinTheme: PinTheme(shape: PinCodeFieldShape.box),
                  animationType: AnimationType.fade,
                  animationDuration: Duration(milliseconds: 300),
                  appContext: context,
                  controller: _otpTEController,
                ),
                const SizedBox(height: 16),
                GetBuilder<VerifyOtpController>(
                  builder: (controller) {
                    return Visibility(
                      visible: controller.verifyOtpInProgress == false,
                      replacement: CenteredCircularProgress(),
                      child: FilledButton(
                        onPressed: _onTapVerifyButton,
                        child: Text('Verify'),
                      ),
                    );
                  }
                ),
                const SizedBox(height: 16),

                // Timer with GetX
                Obx(() {
                  if (controller.secondsRemaining.value > 0) {
                    return Text(
                      "This code will expire in ${controller.secondsRemaining.value}s",
                      style: textTheme.bodyMedium,
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }),

                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () {
                    if (controller.secondsRemaining.value == 0) {
                      controller.secondsRemaining.value = 120;
                      controller.onInit();
                    }
                  },
                  child: Text(
                    "Resend Code",
                    style: textTheme.bodyMedium?.copyWith(
                      color: AppColors.themeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: _onTapBackToLoginButton,
                  child: Text('Back to Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapVerifyButton() {
    // TODO: Validate form
    _verifyOtp();
  }

  Future<void> _verifyOtp() async {
    VerifyOtpRequestModel model = VerifyOtpRequestModel(
        email: widget.email, otp: _otpTEController.text);
    final bool isSuccess = await _verifyOtpController.verifyOtp(model);
    if (isSuccess) {
      await Get.find<AuthController>().saveUserData(
          _verifyOtpController.userModel!, _verifyOtpController.accessToken!);
      Navigator.pushNamedAndRemoveUntil(
          context, BottomNavHolderScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, _verifyOtpController.errorMessage!);
    }
  }

  void _onTapBackToLoginButton() {
    Navigator.pushNamedAndRemoveUntil(context, SignInScreen.name, (p) => false);
  }

  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}