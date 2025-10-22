import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickers/Screens/Home.dart';
import 'package:quickers/Screens/Signup.dart';
import 'package:quickers/main.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();

  Future<void> Login() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text.trim(),
      );
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login Failed. Try Again Later. ${e.toString()}'),
        ),
      );
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password reset email sent")),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/Quickr_icon.png', height: 200, width: 200),
              Text(
                'Fast. Local. Simple.',
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.gray,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 20),
              Card(
                elevation: 5,
                shadowColor: Colors.blueGrey.shade100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Welcome to Quickr!',
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                          color: Colors.blue.shade900,
                        ),
                      ),
                      const SizedBox(height: 20),

                      TextField(
                        controller: _email,
                        decoration: InputDecoration(
                          label: Text('Enter Your Email'),
                        ),
                      ),

                      const SizedBox(height: 15),

                      TextField(
                        controller: _pass,
                        obscureText: true,
                        decoration: InputDecoration(
                          label: Text('Enter Your Password '),
                        ),
                      ),

                      const SizedBox(height: 25),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue.shade700,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: Login,
                        child: Text(
                          'Login',
                          style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New User?...',
                            style: GoogleFonts.roboto(color: Colors.black54),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx) => signUp()),
                              );
                            },
                            child: Text(
                              'Sign up',
                              style: GoogleFonts.roboto(
                                color: Colors.blue.shade700,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () async {
                          if (_email.text.trim().isNotEmpty) {
                            await resetPassword(_email.text.trim());
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Enter the Email First')),
                            );
                          }
                        },
                        child: Text(
                          'Reset Password !',
                          style: GoogleFonts.robotoSlab(),
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
    );
  }
}
