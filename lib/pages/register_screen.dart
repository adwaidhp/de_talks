import 'package:flutter/material.dart';
import 'package:de_talks/colors.dart'; // Ensure this matches your file structure.

class RegisterScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "Let's begin",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height * 0.87,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        // Profile Icon with Gradient
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                AppColors.lightBlueAccent,
                                AppColors.darkBlueContrast,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Input Fields
                        _buildRoundedInputField(
                          hintText: "Enter Name",
                          controller: nameController,
                        ),
                        const SizedBox(height: 10),
                        _buildRoundedInputField(
                          hintText: "Enter Email",
                          controller: emailController,
                        ),
                        const SizedBox(height: 10),
                        _buildRoundedInputField(
                          hintText: "Enter Password",
                          controller: passwordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        _buildRoundedInputField(
                          hintText: "Confirm Password",
                          controller: confirmPasswordController,
                          obscureText: true,
                        ),
                        const SizedBox(height: 10),
                        _buildRoundedInputField(
                          hintText: "Enter City",
                          controller: cityController,
                        ),
                        const SizedBox(height: 20),
                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Registration Successful!'),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.darkBlueContrast,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 3, // Shadow effect
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 12.0),
                              child: Text(
                                'REGISTER',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Already Registered Section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already registered?',
                              style: TextStyle(color: AppColors.darkerGrey),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context); // Navigate back
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                  color: AppColors.darkBlueContrast,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoundedInputField({
    required String hintText,
    required TextEditingController controller,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: AppColors.darkerGrey),
            border: InputBorder.none,
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $hintText';
            }
            return null;
          },
        ),
      ),
    );
  }
}
