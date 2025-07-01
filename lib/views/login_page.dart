import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home/home.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? errorText;

  void _login() {
    // Simulasi login sukses jika field tidak kosong
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        CupertinoPageRoute(builder: (context) => const Home()),
      );
    } else {
      setState(() {
        errorText = 'Email dan password wajib diisi';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF1565c0),
      child: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Text('',
                      style: GoogleFonts.roboto(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff404040))),
                  const SizedBox(height: 12),
                  Image.asset('images/logo.png', width: 100, height: 100),
                  const SizedBox(height: 16),
                  Text('STEPUP',
                      style: GoogleFonts.roboto(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2)),
                  Text('SHOES',
                      style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 6)),
                  const SizedBox(height: 32),
                  CupertinoTextField(
                    controller: emailController,
                    placeholder: 'Email Address',
                    padding: const EdgeInsets.all(16),
                    style: const TextStyle(fontSize: 18),
                    prefix: const Icon(CupertinoIcons.mail,
                        color: Color(0xFFB0B0B0)),
                  ),
                  const SizedBox(height: 16),
                  CupertinoTextField(
                    controller: passwordController,
                    placeholder: 'Password',
                    obscureText: true,
                    padding: const EdgeInsets.all(16),
                    style: const TextStyle(fontSize: 18),
                    prefix: const Icon(CupertinoIcons.lock,
                        color: Color(0xFFB0B0B0)),
                  ),
                  if (errorText != null) ...[
                    const SizedBox(height: 8),
                    Text(errorText!, style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 24),
                  CupertinoButton.filled(
                    child: const Text('Log in', style: TextStyle(fontSize: 18)),
                    onPressed: _login,
                  ),
                  const SizedBox(height: 12),
                  CupertinoButton(
                    child:
                        const Text('Sign up!', style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SignUpPage()),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () {},
                    child: const Text('Forgot password?',
                        style:
                            TextStyle(color: Color(0xFFB0B0B0), fontSize: 16)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
