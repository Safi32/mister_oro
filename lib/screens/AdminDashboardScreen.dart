import 'package:flutter/material.dart';
import '../widgets/AppAppBar.dart';
import '../widgets/AppCard.dart';
import '../widgets/StatCard.dart';
import '../widgets/ActionCard.dart';
import '../utils/AppColors.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppAppBar(
        automaticallyImplyLeading: false,
        title: 'Panel Administrador',
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeCard(),
            const SizedBox(height: 24),
            _buildQuickActions(),
            const SizedBox(height: 24),
            _buildSystemStats(),
            const SizedBox(height: 24),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return GradientCard(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Panel de Administrador',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.surfaceWhite,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Control total del sistema',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.surfaceWhite,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Icon(
                Icons.admin_panel_settings,
                color: AppColors.surfaceWhite,
                size: 24,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Acceso Total',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.surfaceWhite,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Configuración y gestión completa',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.surfaceWhite.withAlpha((0.8 * 255).round()),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Acciones Rápidas',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            ActionCard(
              icon: Icons.people,
              title: 'Gestionar Usuarios',
              subtitle: 'Administrar y gestionar roles',
              color: AppColors.purpleAccent,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.settings,
              title: 'Configuración',
              subtitle: 'Ajustes del sistema',
              color: AppColors.primaryGold,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.analytics,
              title: 'Reportes',
              subtitle: 'Estadísticas y análisis',
              color: AppColors.infoBlue,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.security,
              title: 'Seguridad',
              subtitle: 'Configuración de seguridad',
              color: AppColors.successGreen,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.backup,
              title: 'Respaldo',
              subtitle: 'Gestionar respaldos',
              color: AppColors.warningOrange,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.system_update,
              title: 'Actualización',
              subtitle: 'Actualizar sistema',
              color: AppColors.purpleAccent,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSystemStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Estadísticas del Sistema',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.5,
          children: [
            StatCard(
              title: 'Usuarios Activos',
              value: '156',
              icon: Icons.people,
              color: AppColors.purpleAccent,
            ),
            StatCard(
              title: 'Vendedores',
              value: '12',
              icon: Icons.store,
              color: AppColors.primaryGold,
            ),
            StatCard(
              title: 'Verificadores',
              value: '8',
              icon: Icons.verified_user,
              color: AppColors.infoBlue,
            ),
            StatCard(
              title: 'Total Transacciones',
              value: '2,847',
              icon: Icons.swap_horiz,
              color: AppColors.successGreen,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Actividad Reciente',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        AppCard(
          child: Column(
            children: [
              _buildActivityItem(
                'Nuevo usuario registrado',
                'admin@misteroro.com',
                'Hace 5 minutos',
                AppColors.successGreen,
                Icons.person_add,
              ),
              const Divider(color: AppColors.divider),
              _buildActivityItem(
                'Configuración actualizada',
                'Sistema actualizado v2.1.0',
                'Hace 1 hora',
                AppColors.infoBlue,
                Icons.system_update,
              ),
              const Divider(color: AppColors.divider),
              _buildActivityItem(
                'Backup completado',
                'Datos respaldados',
                'Hace 30 minutos',
                AppColors.successGreen,
                Icons.backup,
              ),
              const Divider(color: AppColors.divider),
              _buildActivityItem(
                'Usuario bloqueado',
                'usuario@temporal.com',
                'Hace 2 horas',
                AppColors.errorRed,
                Icons.block,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    String title,
    String subtitle,
    String time,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withAlpha(30),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: color,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textLight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Está seguro que desea cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.errorRed,
              foregroundColor: AppColors.surfaceWhite,
            ),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}