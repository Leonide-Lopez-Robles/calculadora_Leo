import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// Widget que muestra la expresión y el resultado en la calculadora
class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;
  final bool isLandscape;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
    this.isLandscape = false,
  });

  @override
  Widget build(BuildContext context) {
    // Altura del display según la orientación
    double displayHeight =
        isLandscape ? MediaQuery.of(context).size.height * 0.9 : 200.0;

    return Container(
      width: double.infinity,
      height: isLandscape ? null : displayHeight,
      padding: EdgeInsets.all(isLandscape ? 16 : 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: isLandscape ? MainAxisSize.min : MainAxisSize.max,
        children: [
          // Expresión matemática
          Flexible(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              reverse: true, // Para que se desplace al final
              child: Text(
                expression.isEmpty ? '0' : expression,
                style: TextStyle(
                  fontSize: isLandscape ? 32 : 36,
                  color: AppColors.displayText,
                  fontWeight: FontWeight.w300,
                ),
                maxLines: 1,
              ),
            ),
          ),

          SizedBox(height: isLandscape ? 4 : 8),

          // Resultado
          if (result.isNotEmpty)
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                reverse: true,
                child: Text(
                  result,
                  style: TextStyle(
                    fontSize: isLandscape ? 24 : 24,
                    color: result.startsWith('Error')
                        ? Colors.redAccent
                        : AppColors.resultText,
                    fontWeight: FontWeight.w300,
                  ),
                  maxLines: 1,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
