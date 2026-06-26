import 'dart:ui';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  final AuthService auth = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLogin = true;
  bool showPassword = false;
  bool isLoading = false;

  late AnimationController _controller;

  // POP UP DIALOG
  void showMessage(String title, String message) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          content: Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
                child: const Text("OK"),
              ),
            ),
          ],
        );
      },
    );
  }

// PASSWORD RESET
  Future<void> forgotPassword() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      showMessage(
        "Email Required",
        "Please enter your email address first.",
      );
      return;
    }
    try {
      await auth.resetPassword(email);
      if (!mounted) return;
      showMessage(
        "Password Reset",
        "A password reset link has been sent to:\n\n$email\n\nPlease check your inbox and spam folder.",
      );
    } catch (e) {
      if (!mounted) return;
      showMessage(
        "Error",
        e.toString(),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> submit() async {
    setState(() => isLoading = true);
    try {
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      if (email.isEmpty || password.isEmpty) {
        setState(() => isLoading = false);
        return;
      }
      if (isLogin) {
        await auth.signIn(email, password);
        if (!mounted) return;
        setState(() => isLoading = false);
        showMessage(
          "Success",
          "Login successful",
        );
        return;
      }

      // SIGN UP FLOW
      else {
        await auth.signUp(email, password);
        if (!mounted) return;
        setState(() => isLoading = false);
        Future.delayed(const Duration(milliseconds: 200), () {
          if (!mounted) return;
          showMessage(
            "Verify Your Email",
            "Your account has been created.\n\n"
                "A verification email has been sent.\n\n"
                "Please check your inbox (and spam folder) and verify your account before logging in.",
          );
        });
        setState(() {
          isLogin = true;
        });
        return;
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      final error = e.toString().toLowerCase();
      if (error.contains('email-not-verified')) {
        showMessage(
          "Email Not Verified",
          "Please verify your email before logging in.",
        );
      } else if (error.contains('wrong-password')) {
        showMessage(
          "Wrong Password",
          "Incorrect password.",
        );
      } else if (error.contains('user-not-found')) {
        showMessage(
          "Account Not Found",
          "No account exists with this email.",
        );
      } else {
        showMessage(
          "Error",
          e.toString(),
        );
      }
    }
  }

  Future<void> googleLogin() async {
    setState(() => isLoading = true);
    try {
      final user = await auth.signInWithGoogle();
      if (!mounted) return;
      showMessage(
        user != null ? "Success" : "Cancelled",
        user != null
            ? "Google login successful"
            : "Google login cancelled",
      );
    } catch (e) {
      if (!mounted) return;
      showMessage(
        "Google Login Error",
        e.toString(),
      );
    }
    if (mounted) setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  // Colors.grey.shade900,
                  // Colors.blue.shade500,
                  Colors.blue,
                ],
              ),
            ),
            child: child,
          );
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.white30),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          isLogin ? "Login" : "Create Account",
                          style: const TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 30),

                        /// EMAIL
                        TextField(
                          controller: emailController,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.email),
                            hintText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        /// PASSWORD
                        TextField(
                          controller: passwordController,
                          obscureText: !showPassword,
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  showPassword = !showPassword;
                                });
                              },
                            ),
                            hintText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        //PASSWORD RESET
                        Align(
                          alignment: Alignment.center,
                          child: TextButton(
                            onPressed: forgotPassword,
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        /// MAIN BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                              foregroundColor: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: isLoading
                                ? const CircularProgressIndicator()
                                : Text(
                              isLogin ? "Login" : "Sign up",
                              style: const TextStyle(fontSize: 22),
                            ),
                          ),
                        ),


                        const SizedBox(height: 20),

                        /// GOOGLE BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : googleLogin,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade100,
                              foregroundColor: Colors.blue.shade900,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Login with",
                                  style: TextStyle(fontSize: 22),
                                ),
                                Image.asset(
                                  "assets/google.png",
                                  width: 100,
                                  height: 50,
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextButton(
                          onPressed: () {
                            setState(() => isLogin = !isLogin);
                          },
                          child: Text(
                            isLogin
                                ? "Create account"
                                : "Already have account?",
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22)
                            ,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}