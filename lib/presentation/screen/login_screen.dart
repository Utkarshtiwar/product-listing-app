import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:product_listing/state/loginController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF74EBD5), Color(0xFFACB6E5)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Card(
            color: Colors.white.withOpacity(0.18),
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 24),

            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  const Text(
                    "Welcome Back 👋",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ID field
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      hintText: "Enter ID",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  /// Password field
                  TextField(
                    controller: controller.passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.6),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 14,
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),

                  /// Login Button
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.isLoading.value?null:(){
                        final email = controller.emailController.text.trim();
                        final password = controller.passwordController.text.trim();
                        print(email);
                        print(password);
                        if (email.isEmpty || password.isEmpty) {
                          Get.snackbar("Error", "Please enter both fields");
                          return;
                        }
                        controller.login(email, password);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : const Text("Login", style: TextStyle(fontSize: 16)),
                    );
                  }),
                  const SizedBox(height: 8),
                  Text("Forgot Password?"),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Text("New User?"),
                  Text(
                    "Sign Up",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    ]
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
