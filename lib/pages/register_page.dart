import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:usertouserchat/auth/auth_services.dart';
import 'package:usertouserchat/components/my_button.dart';
import 'package:usertouserchat/components/my_textfield.dart';
import 'package:usertouserchat/pages/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();

  void onRegisterTap() {
    print('Register pressed');
    AuthServices authServices = AuthServices();
    if (_passwordController.text == _confirmpasswordController.text) {
      print('Password is correct');
      authServices.signUp(_emailController.text, _passwordController.text);
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Password do not match'),
              ));
    }
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
              "Let's create the account for you",
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
            MyTextField(
              hint: 'Confirm password',
              obsecureText: true,
              controller: _confirmpasswordController,
            ),

            SizedBox(
              height: 20,
            ),
            // login button
            MyButton(
              buttonText: 'Register',
              onTap: onRegisterTap,
            ),
            SizedBox(
              height: 20,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Already have an account? ',
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: () => Get.offAll(LoginPage()),
                  child: Text('Login',
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
    ;
  }
}
