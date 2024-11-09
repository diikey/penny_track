import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:penny_track/utils/cache.dart';
import 'package:penny_track/utils/resources/routes_manager.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Cache cache = context.read<Cache>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              onChanged: (value) {
                // if (state is LoginFailed) {
                //   context.read<LoginBloc>().add(TextFieldChanged());
                // }
              },
              controller: usernameController,
              decoration: InputDecoration(
                labelText: "Username",
                // errorText: state.errorText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextFormField(
              onChanged: (value) {
                // if (state is LoginFailed) {
                //   context.read<LoginBloc>().add(TextFieldChanged());
                // }
              },
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Password",
                // errorText: state.errorText,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 12,
                ),
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 10,
            ),
            // if (state is LoginLoading)
            //   const Center(
            //     child: CircularProgressIndicator(),
            //   )
            // else
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    return;
                  }
                  // context.read<LoginBloc>().add(LoginBtnPressed(
                  //     usernameController.text, passwordController.text));
                  cache.setString(key: Cache.cacheToken, value: "newtoken");
                  Navigator.pushReplacementNamed(context, Routes.appRoute);
                },
                child: Text("Login"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
