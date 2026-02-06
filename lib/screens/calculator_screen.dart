import 'package:flutter/material.dart';
import '../logic/calculator_logic.dart';
import '../widgets/calculator_button.dart';
import '../widgets/calculator_display.dart';
import '../constants/app_colors.dart'; // <--- Importante para usar tus colores

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _calculator = CalculatorLogic();

  final List<List<String>> _buttonLayout = [
    ['C', '(', ')', '÷'],
    ['7', '8', '9', '×'],
    ['4', '5', '6', '-'],
    ['1', '2', '3', '+'],
    ['0', '.', '⌫', '='],
  ];

  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        _calculator.clear();
      } else if (value == '=') {
        _calculator.calculate();
      } else if (value == '⌫') {
        _calculator.deleteLast();
      } else {
        _calculator.addToExpression(value);
      }
    });
  }

  /// Helper para determinar el color del botón según tu archivo AppColors
  Color _getButtonColor(String text, bool isOp, bool isEq) {
    if (isEq) return AppColors.equalsButton;
    if (isOp) return AppColors.operatorButton;
    // Para C, ( y ) también solemos usar el color de operador o uno especial.
    // Aquí asumo que quieres que sean como operadores visualmente:
    if (['C', '(', ')', '⌫'].contains(text)) return AppColors.operatorButton;
    return AppColors.numberButton;
  }

  /// Helper para determinar el color del texto
  Color _getTextColor(String text, bool isOp, bool isEq) {
    if (isOp || isEq || ['C', '(', ')', '⌫'].contains(text)) {
      return AppColors.operatorText;
    }
    return AppColors.numberText;
  }

  Widget _buildKeypad({required bool isLandscape}) {
    return Column(
      children: _buttonLayout.map((row) {
        return Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: row.map((text) {
              final bool isOp = ['+', '-', '×', '÷', '(', ')'].contains(text);
              final bool isEq = text == '=';

              // Obtenemos los colores
              final Color btnColor = _getButtonColor(text, isOp, isEq);
              final Color txtColor = _getTextColor(text, isOp, isEq);

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: CalculatorButton(
                    text: text,
                    onPressed: () => _onButtonPressed(text),
                    // Pasamos las banderas lógicas
                    isOperator: isOp,
                    isEquals: isEq,
                    isLandscape: isLandscape,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPortraitLayout() {
    return Column(
      children: [
        CalculatorDisplay(
          expression: _calculator.expression,
          result: _calculator.result,
          isLandscape: false,
        ),
        // Línea divisoria sutil, usando un gris de tus colores si es posible
        const Divider(color: AppColors.operatorButton, height: 1),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildKeypad(isLandscape: false),
          ),
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: CalculatorDisplay(
              expression: _calculator.expression,
              result: _calculator.result,
              isLandscape: true,
            ),
          ),
        ),
        const VerticalDivider(color: AppColors.operatorButton, width: 1),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildKeypad(isLandscape: true),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Leo'),
        centerTitle: false,
        backgroundColor: AppColors.background, // para que combine
        elevation: 0, // sin sombra
      ),
      // AQUI: Usamos estrictamente tu color de fondo
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? _buildPortraitLayout()
                : _buildLandscapeLayout();
          },
        ),
      ),
    );
  }
}
