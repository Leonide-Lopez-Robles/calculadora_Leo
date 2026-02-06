import 'package:flutter/material.dart';

/// Clase que contiene todos los colores utilizados en la aplicación
/// Siguiendo el esquema de color de la calculadora Android
class AppColors {
  // Color de fondo principal
  static const Color background = Colors.black;

  // Color para los botones numéricos (gris oscuro)
  static const Color numberButton = Color(0xFF2E2E2E);

  // Color para los botones de operadores (gris medio)
  static const Color operatorButton = Color(0xFF505050);

  // Color para el botón de igual (verde destacado)
  static const Color equalsButton = Color(0xFF4CAF50);

  // Color del texto en botones numéricos
  static const Color numberText = Colors.white;

  // Color del texto en botones de operadores
  static const Color operatorText = Colors.white;

  // Color del display
  static const Color displayText = Colors.white;

  // Color del resultado en el display
  static const Color resultText = Color(0xFF808080);
}
