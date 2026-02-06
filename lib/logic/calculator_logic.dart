import 'dart:math' as math;

/// Clase que maneja toda la lógica de la calculadora
/// Separada de la UI para seguir el principio de separación de responsabilidades
class CalculatorLogic {
  String _expression = '';
  String _result = '';

  // Getters para acceder a la expresión y resultado
  String get expression => _expression;
  String get result => _result;

  /// Agrega un carácter a la expresión actual
  /// Valida que no se agreguen operadores consecutivos
  void addToExpression(String value) {
    // Si el resultado ya fue calculado y se presiona un número,
    // empezar una nueva expresión
    if (_result.isNotEmpty &&
        !_isOperator(value) &&
        value != '(' &&
        value != ')') {
      _expression = value;
      _result = '';
      return;
    }

    // Validar operadores consecutivos
    if (_isOperator(value) && _expression.isNotEmpty) {
      String lastChar = _expression[_expression.length - 1];

      // No permitir operadores consecutivos (excepto paréntesis)
      if (_isOperator(lastChar)) {
        // Reemplazar el último operador con el nuevo
        _expression = _expression.substring(0, _expression.length - 1) + value;
        return;
      }
    }

    // Validar que no se empiece con un operador (excepto - para números negativos)
    if (_expression.isEmpty && _isOperator(value) && value != '-') {
      return;
    }

    _expression += value;
    _result = '';
  }

  /// Limpia toda la expresión y el resultado
  void clear() {
    _expression = '';
    _result = '';
  }

  /// Borra el último carácter de la expresión
  void deleteLast() {
    if (_expression.isNotEmpty) {
      _expression = _expression.substring(0, _expression.length - 1);
      _result = '';
    }
  }

  /// Evalúa la expresión matemática actual
  /// Retorna true si la evaluación fue exitosa, false si hubo un error
  bool calculate() {
    if (_expression.isEmpty) {
      _result = '0';
      return true;
    }

    try {
      // Validar paréntesis balanceados
      if (!_areParenthesesBalanced(_expression)) {
        _result = 'Error: Paréntesis no balanceados';
        return false;
      }

      // Validar que la expresión no termine con un operador
      String lastChar = _expression[_expression.length - 1];
      if (_isOperator(lastChar)) {
        _result = 'Error: Expresión incompleta';
        return false;
      }

      // Evaluar la expresión
      double resultValue = _evaluateExpression(_expression);

      // Validar división entre cero
      if (resultValue.isInfinite || resultValue.isNaN) {
        _result = 'Error: División entre cero';
        return false;
      }

      // Formatear el resultado (eliminar decimales innecesarios)
      if (resultValue == resultValue.toInt()) {
        _result = resultValue.toInt().toString();
      } else {
        _result = resultValue
            .toStringAsFixed(8)
            .replaceAll(RegExp(r'0*$'), '')
            .replaceAll(RegExp(r'\.$'), '');
      }

      return true;
    } catch (e) {
      _result = 'Error: Expresión inválida';
      return false;
    }
  }

  /// Verifica si un carácter es un operador
  bool _isOperator(String char) {
    return char == '+' ||
        char == '-' ||
        char == '×' ||
        char == '÷' ||
        char == '*' ||
        char == '/';
  }

  /// Verifica si los paréntesis están balanceados
  bool _areParenthesesBalanced(String expr) {
    int count = 0;
    for (int i = 0; i < expr.length; i++) {
      if (expr[i] == '(') count++;
      if (expr[i] == ')') count--;
      if (count < 0) return false;
    }
    return count == 0;
  }

  /// Evalúa una expresión matemática usando el algoritmo Shunting Yard
  /// y evaluación de notación polaca inversa (RPN)
  double _evaluateExpression(String expr) {
    // Reemplazar símbolos de multiplicación y división
    expr = expr.replaceAll('×', '*').replaceAll('÷', '/');

    // Convertir a notación polaca inversa (RPN)
    List<String> rpn = _convertToRPN(expr);

    // Evaluar RPN
    return _evaluateRPN(rpn);
  }

  /// Convierte una expresión infija a notación polaca inversa (RPN)
  /// usando el algoritmo Shunting Yard
  List<String> _convertToRPN(String expr) {
    List<String> output = [];
    List<String> operators = [];
    String number = '';

    // Definir precedencia de operadores
    Map<String, int> precedence = {'+': 1, '-': 1, '*': 2, '/': 2};

    for (int i = 0; i < expr.length; i++) {
      String char = expr[i];

      // Si es un dígito o punto decimal, construir el número
      if (RegExp(r'[0-9.]').hasMatch(char)) {
        number += char;
      } else {
        // Si había un número siendo construido, agregarlo a la salida
        if (number.isNotEmpty) {
          output.add(number);
          number = '';
        }

        // Manejar operadores
        if (precedence.containsKey(char)) {
          // Manejar números negativos
          if (char == '-' &&
              (i == 0 || expr[i - 1] == '(' || _isOperator(expr[i - 1]))) {
            number = '-';
            continue;
          }

          while (operators.isNotEmpty &&
              operators.last != '(' &&
              precedence.containsKey(operators.last) &&
              precedence[operators.last]! >= precedence[char]!) {
            output.add(operators.removeLast());
          }
          operators.add(char);
        } else if (char == '(') {
          operators.add(char);
        } else if (char == ')') {
          while (operators.isNotEmpty && operators.last != '(') {
            output.add(operators.removeLast());
          }
          if (operators.isNotEmpty) operators.removeLast(); // Remover '('
        }
      }
    }

    // Agregar el último número si existe
    if (number.isNotEmpty) {
      output.add(number);
    }

    // Vaciar los operadores restantes
    while (operators.isNotEmpty) {
      output.add(operators.removeLast());
    }

    return output;
  }

  /// Evalúa una expresión en notación polaca inversa (RPN)
  double _evaluateRPN(List<String> rpn) {
    List<double> stack = [];

    for (String token in rpn) {
      if (token == '+' || token == '-' || token == '*' || token == '/') {
        // Operador: sacar dos números y aplicar la operación
        if (stack.length < 2) {
          throw Exception('Expresión inválida');
        }

        double b = stack.removeLast();
        double a = stack.removeLast();

        double result;
        switch (token) {
          case '+':
            result = a + b;
            break;
          case '-':
            result = a - b;
            break;
          case '*':
            result = a * b;
            break;
          case '/':
            if (b == 0) {
              return double.infinity; // División entre cero
            }
            result = a / b;
            break;
          default:
            throw Exception('Operador desconocido');
        }

        stack.add(result);
      } else {
        // Número: agregarlo a la pila
        stack.add(double.parse(token));
      }
    }

    if (stack.length != 1) {
      throw Exception('Expresión inválida');
    }

    return stack[0];
  }
}
