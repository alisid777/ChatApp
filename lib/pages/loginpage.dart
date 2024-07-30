import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:usertouserchat/auth/auth_services.dart';
import 'package:usertouserchat/components/my_button.dart';
import 'package:usertouserchat/components/my_textfield.dart';
import 'package:usertouserchat/pages/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void onLoginTap() {
    print('login pressed ${_emailController.text} text');
    AuthServices authServices = AuthServices();
    authServices.signIn(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            // some text
            SizedBox(
              height: 50,
            ),
            Text(
              'Welcome back, you have been missed',
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            SizedBox(
              height: 25,
            ),
            //some inputs
            MyTextField(
              hint: 'Email',
              obsecureText: false,
              controller: _emailController,
            ),
            SizedBox(
              height: 20,
            ),
            MyTextField(
              hint: 'Password',
              obsecureText: true,
              controller: _passwordController,
            ),

            SizedBox(
              height: 20,
            ),
            // login button
            MyButton(
              buttonText: 'Login',
              onTap: onLoginTap,
            ),
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Not a member? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: () => Get.to(RegisterPage()),
                  child: Text('Register now',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary)),
                )
              ],
            )
            //register pin
          ],
        ),
      ),
    );
  }
}
