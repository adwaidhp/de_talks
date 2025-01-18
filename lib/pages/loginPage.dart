import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart';
import 'package:de_talks/text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/LoginBg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Login',
                    style: AppTextStyles.bold.copyWith(
                      fontSize: 24,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 40),
                    decoration: BoxDecoration(
                      color: AppColors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.blackOverlay,
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/images/Login.png',
                            height: 200,
                            width: 200,
                          ),
                          const SizedBox(height: 30),
                          _buildRoundedInputField(
                            hintText: "Enter Email",
                            controller: emailController,
                            icon: 'assets/icons/email.svg',
                          ),
                          const SizedBox(height: 20),
                          _buildRoundedInputField(
                            hintText: "Enter Password",
                            controller: passwordController,
                            icon: 'assets/icons/Key.svg',
                            obscureText: true,
                          ),
                          const SizedBox(height: 30),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  // Handle login
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.black,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedInputField({
    required String hintText,
    required TextEditingController controller,
    required String icon,
    bool obscureText = false,
  }) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: AppColors.blackOverlay,
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle: TextStyle(color: AppColors.black),
              filled: true,
              fillColor: AppColors.grey,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: SvgPicture.asset(
                  icon,
                  colorFilter: ColorFilter.mode(
                    AppColors.black.withOpacity(0.6),
                    BlendMode.srcIn,
                  ),
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
