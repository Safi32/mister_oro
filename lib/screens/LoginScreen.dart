import 'package:flutter/material.dart';
import '../widgets/AppTextField.dart';
import '../widgets/AppButton.dart';
import '../widgets/AppCard.dart';
import '../utils/AppColors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                _buildTitle(),
                const SizedBox(height: 40),
                _buildLoginForm(),
                const SizedBox(height: 40),
                _buildDemoCredentials(),
              ],
            ),
          ),
        ),
      ),
    );
  }

 

  Widget _buildTitle() {
    return const Text(
      'Inicio de Sesión Vendedor',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildLoginForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AppTextField(
            controller: _emailController,
            labelText: 'Correo Electrónico',
            hintText: 'correo@ejemplo.com',
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su correo';
              }
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Ingrese un correo válido';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          AppTextField(
            controller: _passwordController,
            labelText: 'Contraseña',
            hintText: '••••••••',
            prefixIcon: Icons.lock_outline,
            obscureText: _obscurePassword,
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese su contraseña';
              }
              if (value.length < 6) {
                return 'La contraseña debe tener al menos 6 caracteres';
              }
              return null;
            },
          ),
          const SizedBox(height: 32),
          AppButton(
            text: 'Iniciar Sesión',
            onPressed: _handleLogin,
            isLoading: false,
          ),
        ],
      ),
    );
  }

  Widget _buildDemoCredentials() {
    return AppCard(
      backgroundColor: AppColors.goldAccent.withOpacity(0.1),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Credenciales de Prueba',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryGold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Correo: vendor@misteroro.com\nContraseña: vendor123',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacementNamed(context, '/vendor-dashboard');
    }
  }
}
