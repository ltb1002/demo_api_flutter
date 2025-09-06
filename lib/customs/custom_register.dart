import 'package:flutter/material.dart';
import 'my_textFormFeild.dart';

class CustomRegisterForm extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> formKey;

  const CustomRegisterForm({
    super.key,
    required this.usernameController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          MyTextFormField(
            labelText: "Email or phone number",
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your username";
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value) &&
                  !RegExp(r'^\d{10,15}$').hasMatch(value)) {
                return "Please enter a valid email or phone number";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          MyTextFormField(
            labelText: "Password",
            controller: passwordController,
            isPassword: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your password";
              }
              if (value.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),
          const SizedBox(height: 20),

          MyTextFormField(
            labelText: "Confirm Password",
            controller: confirmPasswordController,
            isPassword: true,
            validator: (value) {
              if (value != passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
