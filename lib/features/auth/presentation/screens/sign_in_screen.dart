import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ost_ecommerce/app/controllers/login_controller.dart';
import 'package:ost_ecommerce/app/extensions/localization_extension.dart';
import 'package:ost_ecommerce/features/auth/data/models/login_request_model.dart';
import 'package:ost_ecommerce/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:ost_ecommerce/features/shared/presentation/widgets/centered_circular_progress.dart';

import '../../../../app/controllers/auth_controller.dart';
import '../../../../app/forgot_password_email_screen.dart';
import '../../../shared/presentation/screens/bottom_nav_holder_screen.dart';
import '../../../shared/presentation/widgets/snack_bar_message.dart';
import '../widgets/app_logo.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  static const String name = '/sign-in';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();

  final LoginController _loginController = Get.find<LoginController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    bool obscureText = true;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  const SizedBox(height: 48),
                  AppLogo(width: 100),
                  const SizedBox(height: 24),
                  Text(
                    context.localization.welcomeBack,
                    style: textTheme.titleLarge,
                  ),
                  Text(
                    context.localization.loginHeadline,
                    style: textTheme.bodyLarge?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 25),
                  TextFormField(
                    controller: _emailTEController,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(hintText: 'Email'),
                    validator:(String? value){
                      String email = value ?? '';
                      if(EmailValidator.validate(email) == false){
                        return 'Enter a valid email';
                      }
                      return null;
                    } ,

                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordTEController,
                    obscureText: _obscureText,
                    decoration: InputDecoration(hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscureText ? Icons.visibility_off : Icons.visibility,
                        ), onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                      },

                    ),
                  ),
                    validator:(String? value){
                      if((value?.length ?? 0) <= 4){
                        return 'Enter a valid Password';
                      }
                      return null;
                    } ,
                  ),
                  const SizedBox(height: 16),
                  GetBuilder<LoginController>(
                    builder: (_) {
                      return Visibility(
                        visible: _loginController.logInProgress == false,
                        replacement: CenteredCircularProgress(),
                        child: FilledButton(
                          onPressed: _onTapLoginButton,
                          child: Text('Login'),
                        ),
                      );
                    }
                  ),

                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: _onTapForgotPasswordButton,
                    child: Text('Forgot Password ?'),
                  ),

                  const SizedBox(height: 1),
                  TextButton(
                    onPressed: _onTapSignUpButton,
                    child: Text('Sign up'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapLoginButton() {
    if(_formKey.currentState!.validate()){
      _signIn();
    }
  }

  Future<void> _signIn() async {
    LoginRequestModel model = LoginRequestModel(
        email: _emailTEController.text.trim(),
        password: _passwordTEController.text);
    bool isSuccess = await _loginController.login(model);
    if (isSuccess) {
      await Get.find<AuthController>().saveUserData(
          _loginController.userModel!, _loginController.accessToken!);
      Navigator.pushNamedAndRemoveUntil(
          context, BottomNavHolderScreen.name, (predicate) => false);
    } else {
      showSnackBarMessage(context, _loginController.errorMessage!);
    }
  }

  void _onTapSignUpButton() {
    Navigator.pushNamed(context, SignUpScreen.name);
  }

  void _onTapForgotPasswordButton() {
    Navigator.pushNamed(context, ForgotPasswordEmailScreen.name);
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
