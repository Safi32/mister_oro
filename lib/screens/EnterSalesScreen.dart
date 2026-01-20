import 'package:flutter/material.dart';
import '../widgets/AppAppBar.dart';
import '../widgets/AppTextField.dart';
import '../widgets/AppButton.dart';
import '../widgets/AppCard.dart';
import '../utils/AppColors.dart';

class EnterSalesScreen extends StatefulWidget {
  const EnterSalesScreen({super.key});

  @override
  State<EnterSalesScreen> createState() => _EnterSalesScreenState();
}

class _EnterSalesScreenState extends State<EnterSalesScreen> {
  final _formKey = GlobalKey<FormState>();
  final _receiptController = TextEditingController();
  final _quantityController = TextEditingController();
  final _unitPriceController = TextEditingController();
  final _countryController = TextEditingController();
  
  String _selectedCountry = 'México';
  double _calculatedAmount = 0.0;
  bool _showCalculator = false;

  final List<String> _countries = [
    'México',
    'España',
    'Argentina',
    'Colombia',
    'Perú',
    'Chile',
    'Venezuela',
    'Ecuador',
    'Guatemala',
    'Cuba',
  ];

  final Map<String, double> _countryMultipliers = {
    'México': 1.0,
    'España': 0.85,
    'Argentina': 0.90,
    'Colombia': 0.95,
    'Perú': 0.92,
    'Chile': 0.88,
    'Venezuela': 1.05,
    'Ecuador': 0.93,
    'Guatemala': 0.97,
    'Cuba': 1.10,
  };

  @override
  void dispose() {
    _receiptController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppAppBar(
        title: 'Nueva Venta',
        onBackPressed: () => Navigator.pop(context),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSalesForm(),
              const SizedBox(height: 24),
              _buildCalculatorSection(),
              const SizedBox(height: 24),
              _buildAmountSummary(),
              const SizedBox(height: 24),
              _buildActionButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSalesForm() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Información de Venta',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          AppTextField(
            controller: _receiptController,
            labelText: 'Referencia de Recibo',
            hintText: 'REC-001',
            prefixIcon: Icons.receipt_long,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor ingrese la referencia del recibo';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedCountry,
            decoration: InputDecoration(
              labelText: 'País',
              prefixIcon: const Icon(Icons.public, color: AppColors.primaryGold),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.divider),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: AppColors.primaryGold, width: 2),
              ),
              filled: true,
              fillColor: AppColors.surfaceWhite,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
            items: _countries.map((String country) {
              return DropdownMenuItem<String>(
                value: country,
                child: Text(country),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedCountry = newValue!;
                _calculateAmount();
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorSection() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Calculadora de Ventas',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              TextButton.icon(
                onPressed: () {
                  setState(() {
                    _showCalculator = !_showCalculator;
                  });
                },
                icon: Icon(
                  _showCalculator ? Icons.expand_less : Icons.expand_more,
                ),
                label: Text(_showCalculator ? 'Ocultar' : 'Mostrar'),
              ),
            ],
          ),
          if (_showCalculator) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: AppTextField(
                    controller: _quantityController,
                    labelText: 'Cantidad',
                    hintText: '0',
                    prefixIcon: Icons.inventory_2,
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _calculateAmount(),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppTextField(
                    controller: _unitPriceController,
                    labelText: 'Precio Unitario',
                    hintText: '0.00',
                    prefixIcon: Icons.attach_money,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    onChanged: (value) => _calculateAmount(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _buildCalculatorButtons(),
          ],
        ],
      ),
    );
  }

  Widget _buildCalculatorButtons() {
    return Column(
      children: [
        const Text(
          'Acciones Rápidas',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            _buildQuickCalcButton('+10', () {
              final current = int.tryParse(_quantityController.text) ?? 0;
              _quantityController.text = (current + 10).toString();
              _calculateAmount();
            }),
            _buildQuickCalcButton('+50', () {
              final current = int.tryParse(_quantityController.text) ?? 0;
              _quantityController.text = (current + 50).toString();
              _calculateAmount();
            }),
            _buildQuickCalcButton('+100', () {
              final current = int.tryParse(_quantityController.text) ?? 0;
              _quantityController.text = (current + 100).toString();
              _calculateAmount();
            }),
            _buildQuickCalcButton('Limpiar', () {
              _quantityController.clear();
              _unitPriceController.clear();
              _calculateAmount();
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickCalcButton(String label, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryGold,
        foregroundColor: AppColors.surfaceWhite,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Text(label),
    );
  }

  Widget _buildAmountSummary() {
    return AppCard(
      backgroundColor: AppColors.successGreen.withOpacity(0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.calculate,
                color: AppColors.successGreen,
                size: 24,
              ),
              const SizedBox(width: 12),
              const Text(
                'Resumen de Cálculo',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow('Cantidad:', _quantityController.text.isEmpty ? '0' : _quantityController.text),
          _buildSummaryRow('Precio Unitario:', _unitPriceController.text.isEmpty ? '\$0.00' : '\$${_unitPriceController.text}'),
          _buildSummaryRow('Multiplicador País:', '${_countryMultipliers[_selectedCountry] ?? 1.0}'),
          const Divider(),
          _buildSummaryRow(
            'Total Calculado:',
            '\$${_calculatedAmount.toStringAsFixed(2)}',
            isTotal: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.textPrimary : AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? AppColors.successGreen : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Row(
      children: [
        Expanded(
          child: AppButton(
            text: 'Cancelar',
            onPressed: () => Navigator.pop(context),
            isOutlined: true,
            backgroundColor: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: AppButton(
            text: 'Guardar Venta',
            onPressed: _saveSale,
            backgroundColor: AppColors.successGreen,
          ),
        ),
      ],
    );
  }

  void _calculateAmount() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final unitPrice = double.tryParse(_unitPriceController.text) ?? 0.0;
    final multiplier = _countryMultipliers[_selectedCountry] ?? 1.0;
    
    setState(() {
      _calculatedAmount = quantity * unitPrice * multiplier;
    });
  }

  void _saveSale() {
    if (_formKey.currentState!.validate()) {
      if (_calculatedAmount <= 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Por favor calcule un monto válido'),
            backgroundColor: AppColors.errorRed,
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Venta guardada exitosamente'),
          backgroundColor: AppColors.successGreen,
        ),
      );
      
      Navigator.pop(context);
    }
  }
}
