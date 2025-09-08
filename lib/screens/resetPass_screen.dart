import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../customs/my_textFormFeild.dart';
import '../customs/custom_auth_button.dart';
import '../app/routes/app_routes.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  final String? token;

  const ResetPasswordScreen({super.key, required this.email, this.token});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tokenController;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    tokenController = TextEditingController(text: widget.token ?? "");
  }

  @override
  void dispose() {
    tokenController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> resetPassword() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/auth/reset-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": widget.email,
          "token": tokenController.text.trim(),
          "newPassword": passwordController.text.trim(),
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data["success"] == true) {
        Get.snackbar(
          "Success",
          data["message"] ?? "Password reset successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Chuyển về login
        Get.offAllNamed(AppRoutes.login, arguments: {"email": widget.email});
      } else {
        Get.snackbar(
          "Error",
          data["message"] ?? "Failed",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Cannot connect to server",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              MyTextFormField(
                labelText: "Token",
                controller: tokenController,
                validator: (v) =>
                    v == null || v.isEmpty ? "Token required" : null,
              ),
              const SizedBox(height: 20),
              MyTextFormField(
                labelText: "New Password",
                controller: passwordController,
                isPassword: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return "Enter password";
                  if (v.length < 6) return "Min 6 chars";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              MyTextFormField(
                labelText: "Confirm Password",
                controller: confirmController,
                isPassword: true,
                validator: (v) {
                  if (v != passwordController.text)
                    return "Passwords do not match";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              CustomAuthButton(
                text: "Reset Password",
                isLoading: isLoading,
                onPressed: resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
