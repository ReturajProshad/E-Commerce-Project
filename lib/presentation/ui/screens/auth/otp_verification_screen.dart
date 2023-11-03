import 'dart:async';
import 'package:crafty_bay_app/data/services/network_caller.dart';
import 'package:crafty_bay_app/data/utility/urls.dart';
import 'package:crafty_bay_app/presentation/state_holders/otp_verification_controller.dart';
import 'package:crafty_bay_app/presentation/ui/screens/main_bottom_nav_screen.dart';
import 'package:crafty_bay_app/presentation/ui/utility/app_colors.dart';
import 'package:crafty_bay_app/presentation/ui/utility/image_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  const OTPVerificationScreen({Key? key, required this.email})
      : super(key: key);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final TextEditingController _otpTEController = TextEditingController();
  late Timer _timer;
  late var _countdownController = StreamController<int>();
  int count = 0;
  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    _countdownController.close();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_countdownController.isClosed) {
        timer.cancel();
      } else {
        _countdownController.sink.add(_timer.tick);
        if (_timer.tick >= 120) {
          timer.cancel();
          _countdownController.close();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                Center(
                  child: SvgPicture.asset(
                    ImageAssets.craftyBayLogoSVG,
                    width: 100,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Enter your OTP code',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text('A 4 digit OTP code has been sent',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.grey)),
                const SizedBox(
                  height: 24,
                ),
                pin_code_field(context),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<OtpVerificationController>(
                      builder: (controller) {
                    if (controller.otpVerificationInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () {
                        verifyOtp(controller);
                      },
                      child: const Text('Next'),
                    );
                  }),
                ),
                const SizedBox(
                  height: 24,
                ),
                code_expaire_text_and_count(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  StreamBuilder<int> code_expaire_text_and_count() {
    return StreamBuilder<int>(
      stream: _countdownController.stream,
      builder: (context, snapshot) {
        final countdownValue = snapshot.data ?? 0;
        count = countdownValue;
        return Column(
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.grey),
                children: [
                  TextSpan(text: 'This code will expire in '),
                  TextSpan(
                    text: '${120 - countdownValue}s',
                    style: TextStyle(
                      color: countdownValue > 0
                          ? AppColors.primaryColor
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                //print(count);
                if (count == 120) {
                  resendOtp(widget.email);
                  if (mounted) {
                    count = 0;
                    _countdownController.close();
                    _countdownController = StreamController<int>();
                    _startTimer();
                    setState(() {});
                  }
                }
              },
              style: TextButton.styleFrom(
                  foregroundColor: count < 120
                      ? const Color.fromARGB(255, 241, 2, 2)
                      : AppColors.primaryColor),
              child: const Text(
                'Resend',
              ),
            ),
          ],
        );
      },
    );
  }

  PinCodeTextField pin_code_field(BuildContext context) {
    return PinCodeTextField(
      controller: _otpTEController,
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 50,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.white,
        selectedFillColor: Colors.white,
        activeColor: AppColors.primaryColor,
        inactiveColor: AppColors.primaryColor,
        selectedColor: Colors.green,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (v) {},
      onChanged: (value) {},
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
    );
  }

  Future<void> verifyOtp(OtpVerificationController controller) async {
    final response =
        await controller.verifyOtp(widget.email, _otpTEController.text.trim());
    if (response) {
      Get.offAll(() => const MainBottomNavScreen());
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Otp verification failed! Try again'),
          ),
        );
      }
    }
  }

  void resendOtp(String Email) {
    Get.snackbar("Attention !", "We Resend an otp");
    NetworkCaller.getRequest(Urls.verifyEmail(Email));
  }
}
