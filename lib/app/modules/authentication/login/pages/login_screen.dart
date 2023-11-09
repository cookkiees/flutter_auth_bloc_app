import 'package:authentication_with_bloc_app/app/modules/authentication/extensions/authentication_extention.dart';
import 'package:authentication_with_bloc_app/app/modules/authentication/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/app_title_and_textfield_widget.dart';
import '../../../../config/routers/app_routes.dart';
import '../widgets/login_alert_dialog_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String emailErrorMessages = '';
  String passwordErrorMessages = '';
  bool isObscureText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leadingWidth: 50,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selamat datang kembali ,yuk Login! 👋🏻',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text(
                  'Isi data diri kamu yang terdaftar dan mari nikmati kembali semua yang terbaik dari App',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 30),
                _buildEmailField(),
                _buildPasswordField(),
                const SizedBox(height: 30),
                BlocConsumer<LoginBloc, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      context.goNamed(AppRoutes.home, queryParameters: {});
                    }
                    if (state is LoginFailure) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return LoginAlertDialogWidget(
                            failureMessage: state.failure?.toUpperCase(),
                          );
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return SizedBox(
                      height: 38,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            state is LoginInitial || state is LoginFailure
                                ? () {
                                    if (emailController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty) {
                                      BlocProvider.of<LoginBloc>(context).add(
                                        UserLoginEvent(
                                          email: emailController.text,
                                          password: passwordController.text,
                                        ),
                                      );
                                    }
                                  }
                                : () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: state is LoginLoading
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : const Text(
                                'LOGIN',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Belum punya akun ? ',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey,
                      ),
                    ),
                    InkWell(
                      onTap: () => context.pushNamed(AppRoutes.register),
                      child: const Text(
                        'Daftar Sekarang',
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.red,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppTitleAndTextFieldWidget _buildPasswordField() {
    return AppTitleAndTextFieldWidget(
      title: 'Password',
      hintText: 'isi password kamu',
      obscureText: !isObscureText,
      controller: passwordController,
      onChanged: (query) {
        if (query.isEmpty) {
          passwordErrorMessages = AuthError.passwordEmpty.message;
        } else if (query.length < 6) {
          passwordErrorMessages = AuthError.passwordTooShort.message;
        } else {
          passwordErrorMessages = '';
        }
        setState(() {});
      },
      suffixIcon: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () => setState(() => isObscureText = !isObscureText),
        child: const Icon(
          Icons.remove_red_eye_outlined,
          size: 20,
          color: Colors.grey,
        ),
      ),
      helper: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          children: [
            const Icon(
              Icons.lock,
              size: 14.0,
              color: Colors.red,
            ),
            const SizedBox(width: 6),
            if (passwordErrorMessages.isNotEmpty)
              Text(
                passwordErrorMessages,
                style: const TextStyle(
                  fontSize: 11,
                  color: Colors.red,
                ),
              ),
            if (passwordErrorMessages.isEmpty)
              const Text(
                'Password lebih dari 6 karakter',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  AppTitleAndTextFieldWidget _buildEmailField() {
    return AppTitleAndTextFieldWidget(
      title: 'Email',
      hintText: 'isi email kamu',
      controller: emailController,
      onChanged: (query) {
        if (query.isEmpty) {
          emailErrorMessages = AuthError.emailEmpty.message;
        } else if (!isEmailValid(query)) {
          emailErrorMessages = AuthError.invalidEmail.message;
        } else {
          emailErrorMessages = '';
        }
        setState(() {});
      },
      helper: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 3),
              child: Icon(
                Icons.email,
                size: 14.0,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 6),
            if (emailErrorMessages.isNotEmpty)
              Flexible(
                child: Text(
                  emailErrorMessages,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                  ),
                ),
              ),
            if (emailErrorMessages.isEmpty)
              const Flexible(
                child: Text(
                  'Masukan email kamu yang terdaftar di App',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
