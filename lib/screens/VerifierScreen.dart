import 'package:flutter/material.dart';
import '../widgets/AppAppBar.dart';
import '../widgets/AppCard.dart';
import '../widgets/StatCard.dart';
import '../widgets/ActionCard.dart';
import '../utils/AppColors.dart';

class VerifierScreen extends StatelessWidget {
  const VerifierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppAppBar(
        automaticallyImplyLeading: false,
        title: 'Panel Verificador',
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
            _buildStatsOverview(),
            const SizedBox(height: 24),
            _buildRecentActivity(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return GradientCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Bienvenido, Verificador',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.surfaceWhite,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Panel de Verificación y Contabilidad',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.surfaceWhite,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.goldAccent.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.goldAccent.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.verified_user,
                  color: AppColors.primaryGold,
                  size: 20,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Acceso de Solo Lectura',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: AppColors.surfaceWhite,
                  ),
                ),
              ],
            ),
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
          childAspectRatio: 1.2,
          children: [
            ActionCard(
              icon: Icons.receipt_long,
              title: 'Ver Ventas',
              subtitle: 'Todos los registros',
              color: AppColors.infoBlue,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.inventory_2,
              title: 'Ver Inventario',
              subtitle: 'Transferencias',
              color: AppColors.purpleAccent,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.analytics,
              title: 'Reportes',
              subtitle: 'Análisis de datos',
              color: AppColors.successGreen,
              onTap: () {},
            ),
            ActionCard(
              icon: Icons.account_balance,
              title: 'Contabilidad',
              subtitle: 'Registros financieros',
              color: AppColors.primaryGold,
              onTap: () {},
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsOverview() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Resumen General',
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
              title: 'Total Ventas Hoy',
              value: '\$12,450',
              icon: Icons.trending_up,
              color: AppColors.successGreen,
            ),
            StatCard(
              title: 'Transferencias',
              value: '23',
              icon: Icons.swap_horiz,
              color: AppColors.infoBlue,
            ),
            StatCard(
              title: 'Vendedores Activos',
              value: '8',
              icon: Icons.people,
              color: AppColors.purpleAccent,
            ),
            StatCard(
              title: 'Productos en Stock',
              value: '156',
              icon: Icons.inventory,
              color: AppColors.primaryGold,
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
                'Venta #1234',
                'Vendedor: Juan Pérez',
                '\$2,340.50',
                AppColors.successGreen,
                Icons.receipt_long,
              ),
              const Divider(color: AppColors.divider),
              _buildActivityItem(
                'Transferencia #T567',
                'Almacén A → Almacén B',
                '50 unidades',
                AppColors.infoBlue,
                Icons.swap_horiz,
              ),
              const Divider(color: AppColors.divider),
              _buildActivityItem(
                'Venta #1233',
                'Vendedor: María García',
                '\$1,890.00',
                AppColors.successGreen,
                Icons.receipt_long,
              ),
              const Divider(color: AppColors.divider),
              _buildActivityItem(
                'Transferencia #T566',
                'Almacén B → Tienda',
                '25 unidades',
                AppColors.infoBlue,
                Icons.swap_horiz,
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
    String value,
    Color color,
    IconData icon,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
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
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
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
