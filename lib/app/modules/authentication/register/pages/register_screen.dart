import 'package:authentication_with_bloc_app/app/config/routers/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../components/app_title_and_textfield_widget.dart';
import '../../extensions/authentication_extention.dart';
import '../bloc/register_bloc.dart';
import '../widgets/register_alert_dialog_widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String nameErrorMessages = '';
  String emailErrorMessages = '';
  String passwordErrorMessages = '';

  bool isObscureText = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        leadingWidth: 50,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back,
            size: 24.0,
            color: Colors.grey,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Daftar dulu ,yuk! 👋🏻',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      'Isi data diri kamu dan mulai nikmati semua yang terbaik dari App',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 30),
                    _buildUsernameField(),
                    _buildEmailField(),
                    _buildPasswordField(),
                    const SizedBox(height: 20),
                    BlocConsumer<RegisterBloc, RegisterState>(
                      listener: (context, state) {
                        if (state is RegisterSuccess) {
                          context.goNamed(AppRoutes.home);
                        }
                        if (state is RegisterFailure) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return RegisterAlertDialogWidget(
                                failureMessage: state.failure?.toUpperCase(),
                              );
                            },
                          );
                        }
                      },
                      builder: (context, state) {
                        return SizedBox(
                          height: 44,
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: state is RegisterInitial
                                ? () {
                                    if (nameController.text.isNotEmpty &&
                                        emailController.text.isNotEmpty &&
                                        passwordController.text.isNotEmpty) {
                                      BlocProvider.of<RegisterBloc>(context)
                                          .add(
                                        UserRegisterEvent(
                                          name: nameController.text,
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
                            child: state is RegisterLoading
                                ? const SizedBox(
                                    height: 24,
                                    width: 24,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : const Text(
                                    'REGISTER',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField() {
    return AppTitleAndTextFieldWidget(
      controller: passwordController,
      title: 'Password',
      hintText: 'isi password kamu',
      obscureText: !isObscureText,
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
        onTap: () => setState(() => isObscureText = !isObscureText),
        borderRadius: BorderRadius.circular(25),
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
            const SizedBox(
              width: 6,
            ),
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
      hintText: 'Contoh: abc@gmail.com',
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
            const Icon(
              Icons.verified_user,
              size: 14.0,
              color: Colors.orange,
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
                  'Email adalah verifikasi akun keduamu agar lebih aman',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  AppTitleAndTextFieldWidget _buildUsernameField() {
    return AppTitleAndTextFieldWidget(
      title: 'Nama Lengkap',
      hintText: 'Isi nama lengkap',
      controller: nameController,
      onChanged: (query) {
        if (query.isEmpty) {
          nameErrorMessages = AuthError.nameEmpty.message;
        } else {
          nameErrorMessages = '';
        }
        setState(() {});
      },
      helper: Padding(
        padding: const EdgeInsets.only(top: 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.person,
              size: 14.0,
              color: Colors.orange,
            ),
            const SizedBox(width: 6),
            if (nameErrorMessages.isNotEmpty)
              Flexible(
                child: Text(
                  nameErrorMessages,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.red,
                  ),
                ),
              ),
            if (nameErrorMessages.isEmpty)
              const Flexible(
                child: Text(
                  'Buat nama kamu dengan benar ya!',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
