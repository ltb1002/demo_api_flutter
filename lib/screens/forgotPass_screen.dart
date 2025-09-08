import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../app/routes/app_routes.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  Future<void> sendForgotPasswordRequest() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your email",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse("http://10.0.2.2:8080/api/auth/forgot-password"), // emulator
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data["token"] ?? "";

        Get.snackbar(
          "Success",
          data["message"] ?? "Check your email",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Chuyển sang màn ResetPasswordScreen
        Get.toNamed(
          AppRoutes.resetpass,
          arguments: {"email": email, "token": token},
        );
      } else {
        Get.snackbar(
          "Error",
          "Failed: ${response.body}",
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
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "Enter your email"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : sendForgotPasswordRequest,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Send Token Link"),
            ),
          ],
        ),
      ),
    );
  }
}
