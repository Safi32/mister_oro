import 'package:flutter/material.dart';
import '../widgets/AppTextField.dart';
import '../widgets/AppButton.dart';
import '../widgets/AppCard.dart';
import '../utils/AppColors.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  String _selectedRole = 'Vendedor';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final List<String> _roles = ['Vendedor', 'Verificador', 'Administrador'];

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
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
                _buildHeader(),
                const SizedBox(height: 30),
                _buildRoleSelection(),
                const SizedBox(height: 20),
                AppTextField(
                  controller: _nameController,
                  labelText: 'Nombre Completo',
                  hintText: 'Juan Pérez',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su nombre';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _emailController,
                  labelText: 'Correo Electrónico',
                  hintText: 'usuario@misteroro.com',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese su correo';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Por favor ingrese un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                AppTextField(
                  controller: _passwordController,
                  labelText: 'Contraseña',
                  hintText: '•••••••',
                  prefixIcon: Icons.lock,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese una contraseña';
                    }
                    if (value.length < 6) {
                      return 'La contraseña debe tener al menos 6 caracteres';
                    }
                    return null;
                  },
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
                const SizedBox(height: 16),
                AppTextField(
                  controller: _confirmPasswordController,
                  labelText: 'Confirmar Contraseña',
                  hintText: '•••••••',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscureConfirmPassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor confirme su contraseña';
                    }
                    if (value != _passwordController.text) {
                      return 'Las contraseñas no coinciden';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                AppButton(
                  text: 'Crear Cuenta',
                  onPressed: _handleSignUp,
                  backgroundColor: _getRoleColor(),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes una cuenta?',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Iniciar Sesión',
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

  Widget _buildHeader() {
    return Column(
      children: [
        Icon(
          Icons.app_registration,
          size: 64,
          color: _getRoleColor(),
        ),
        const SizedBox(height: 16),
        Text(
          'Crear Cuenta',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Únete a MISTER ORO',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleSelection() {
    return AppCard(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Seleccionar Rol',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Column(
            children: _roles.map((role) {
              return RadioListTile<String>(
                title: Text(
                  role,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: _selectedRole == role ? _getRoleColor() : AppColors.textPrimary,
                  ),
                ),
                subtitle: Text(
                  _getRoleDescription(role),
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                value: role,
                groupValue: _selectedRole,
                activeColor: _getRoleColor(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                secondary: Icon(
                  _getRoleIcon(role),
                  color: _selectedRole == role ? _getRoleColor() : AppColors.textSecondary,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getRoleDescription(String role) {
    switch (role) {
      case 'Vendedor':
        return 'Gestionar ventas y inventario personal';
      case 'Verificador':
        return 'Acceso de solo lectura a registros';
      case 'Administrador':
        return 'Control total del sistema';
      default:
        return '';
    }
  }

  IconData _getRoleIcon(String role) {
    switch (role) {
      case 'Vendedor':
        return Icons.store;
      case 'Verificador':
        return Icons.verified_user;
      case 'Administrador':
        return Icons.admin_panel_settings;
      default:
        return Icons.person;
    }
  }

  Color _getRoleColor() {
    switch (_selectedRole) {
      case 'Vendedor':
        return AppColors.primaryGold;
      case 'Verificador':
        return AppColors.infoBlue;
      case 'Administrador':
        return AppColors.purpleAccent;
      default:
        return AppColors.primaryGold;
    }
  }

  void _handleSignUp() async {
    // Validate all fields
    if (_nameController.text.isEmpty) {
      _showErrorSnackBar('Por favor ingrese su nombre completo');
      return;
    }

    if (_emailController.text.isEmpty) {
      _showErrorSnackBar('Por favor ingrese su correo electrónico');
      return;
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(_emailController.text)) {
      _showErrorSnackBar('Por favor ingrese un correo válido');
      return;
    }

    if (_passwordController.text.isEmpty) {
      _showErrorSnackBar('Por favor ingrese una contraseña');
      return;
    }

    if (_passwordController.text.length < 6) {
      _showErrorSnackBar('La contraseña debe tener al menos 6 caracteres');
      return;
    }

    if (_confirmPasswordController.text != _passwordController.text) {
      _showErrorSnackBar('Las contraseñas no coinciden');
      return;
    }

    // Show success message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cuenta creada exitosamente como $_selectedRole'),
        backgroundColor: AppColors.successGreen,
        duration: const Duration(seconds: 2),
      ),
    );

    // Navigate to login screen after a short delay
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      Navigator.pushReplacementNamed(context, '/login', arguments: _selectedRole);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.errorRed,
      ),
    );
  }
}
