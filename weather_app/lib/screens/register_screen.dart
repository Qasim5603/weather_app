import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:weather_app/services/auth_service.dart';
import 'package:weather_app/screens/login_screen.dart';
import 'package:weather_app/screens/home_screen.dart';
import 'package:weather_app/widgets/button.dart';
import 'package:weather_app/widgets/textfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _name.dispose();
    _email.dispose();
    _password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Signup", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
                const SizedBox(height: 50),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Textfield(hint: "Enter Name", label: "Name", controller: _name),
                        const SizedBox(height: 20),
                        Textfield(hint: "Enter Email", label: "Email", controller: _email),
                        const SizedBox(height: 20),
                        Textfield(hint: "Enter Password", label: "Password", isPassword: true, controller: _password),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Button(
                  label: "Signup",
                  style: const TextStyle(fontSize: 18),
                  onPressed: _signup,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text("Already have an account? "),
                    InkWell(
                      onTap: () => goToLogin(context),
                      child: const Text("Login", style: TextStyle(color: Colors.deepPurpleAccent)),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  goToLogin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
  );

  goToHome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );

  _signup() async {
    final user = await _auth.createUserWithEmailAndPassword(_email.text, _password.text);
    if (user != null) {
      log("User Created Successfully");
      goToHome(context);
    }
  }
}
