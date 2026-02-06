import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Widget reutilizable para los botones de la calculadora
/// Maneja diferentes estilos según el tipo de botón
class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOperator;
  final bool isEquals;
  final bool isLandscape;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOperator = false,
    this.isEquals = false,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    // Determinar el color del botón según su tipo
    Color buttonColor;
    if (isEquals) {
      buttonColor = AppColors.equalsButton;
    } else if (isOperator) {
      buttonColor = AppColors.operatorButton;
    } else {
      buttonColor = AppColors.numberButton;
    }

    // Determinar el tamaño del botón según la orientación
    double buttonSize = isLandscape ? 60.0 : 75.0;

    return SizedBox(
      width: buttonSize,
      height: buttonSize,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(),
          padding: EdgeInsets.zero,
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isLandscape ? 20 : 24,
            fontWeight: FontWeight.w400,
            color: AppColors.numberText,
          ),
        ),
      ),
    );
  }
}
