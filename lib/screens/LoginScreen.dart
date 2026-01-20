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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _selectedRole = 'Vendedor';
  bool _obscurePassword = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get the selected role from navigation arguments
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      setState(() {
        _selectedRole = args;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceWhite,
      appBar: AppBar(
        backgroundColor: AppColors.surfaceWhite,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_outlined,
            color: AppColors.textPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                _buildRoleDisplay(),
                const SizedBox(height: 30),
                AppTextField(
                  controller: _emailController,
                  labelText: 'Correo Electrónico',
                  hintText: 'usuario@misteroro.com',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                AppTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  hintText: '•••••••',
                  prefixIcon: Icons.lock,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                AppButton(
                  text: 'Iniciar Sesión',
                  onPressed: _handleLogin,
                  backgroundColor: _getRoleColor(),
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Volver a Selección',
                    style: TextStyle(color: _getRoleColor()),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿No tienes cuenta?',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/signup'),
                      child: Text(
                        'Registrarse',
                        style: TextStyle(
                          color: _getRoleColor(),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleDisplay() {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Rol Seleccionado',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(_getRoleIcon(), color: _getRoleColor(), size: 24),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _getRoleDisplayName(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: _getRoleColor(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getRoleIcon() {
    switch (_selectedRole) {
      case 'Vendedor':
        return Icons.store;
      case 'Verificador':
        return Icons.verified_user;
      case 'Administrador':
        return Icons.admin_panel_settings;
      default:
        return Icons.store;
    }
  }

  String _getRoleDisplayName() {
    switch (_selectedRole) {
      case 'Vendedor':
        return 'Vendedor';
      case 'Verificador':
        return 'Verificador';
      case 'Administrador':
        return 'Administrador';
      default:
        return 'Vendedor';
    }
  }

  Color _getRoleColor() {
    switch (_selectedRole) {
      case 'Vendedor':
        return AppColors.primaryGold;
      case 'Verificador':
        return AppColors.primaryGold;
      case 'Administrador':
        return AppColors.primaryGold;
      default:
        return AppColors.primaryGold;
    }
  }

  void _handleLogin() async {
    
    switch (_selectedRole) {
      case 'Vendedor':
        Navigator.pushReplacementNamed(context, '/vendor-dashboard');
        break;
      case 'Verificador':
        Navigator.pushReplacementNamed(context, '/verifier');
        break;
      case 'Administrador':
        Navigator.pushReplacementNamed(context, '/admin-dashboard');
        break;
    }
  }
}
