import 'package:flutter/material.dart';
import '../widgets/AppCard.dart';
import '../utils/AppColors.dart';

class StakeholderSelectionScreen extends StatelessWidget {
  const StakeholderSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTitle(),
                const SizedBox(height: 40),
                _buildStakeholderCards(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'MISTER ORO',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryGold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sales & Inventory Management System',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildStakeholderCards(BuildContext context) {
    return Column(
      children: [
        _buildStakeholderCard(
          'Vendedor',
          'Gestionar ventas, inventario y calculadora',
          Icons.store,
          AppColors.primaryGold,
          () => Navigator.pushNamed(context, '/login', arguments: 'Vendedor'),
        ),
        const SizedBox(height: 20),
        _buildStakeholderCard(
          'Verificador',
          'Acceso de solo lectura a ventas y transferencias',
          Icons.verified_user,
          AppColors.infoBlue,
          () => Navigator.pushNamed(context, '/login', arguments: 'Verificador'),
        ),
        const SizedBox(height: 20),
        _buildStakeholderCard(
          'Administrador',
          'Control total del sistema y configuración',
          Icons.admin_panel_settings,
          AppColors.purpleAccent,
          () => Navigator.pushNamed(context, '/login', arguments: 'Administrador'),
        ),
      ],
    );
  }

  Widget _buildStakeholderCard(
    String title,
    String description,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              size: 40,
              color: color,
            ),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textLight,
            size: 24,
          ),
        ],
      ),
    );
  }
}
