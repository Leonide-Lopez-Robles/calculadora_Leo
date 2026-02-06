# 🧮 Calculadora Flutter

Una aplicación de calculadora moderna y funcional desarrollada en Flutter, inspirada en el diseño de la calculadora nativa de Android en modo oscuro.

![Flutter](https://img.shields.io/badge/Flutter-3.0+-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.0+-0175C2?logo=dart)
![License](https://img.shields.io/badge/License-MIT-green)

## ✨ Características

### Funcionalidades
- ✅ Operaciones básicas: suma (+), resta (-), multiplicación (×) y división (÷)
- ✅ Soporte para paréntesis para operaciones complejas
- ✅ Botón de borrado completo (C)
- ✅ Evaluación de expresiones matemáticas completas
- ✅ Validación de división entre cero
- ✅ Validación de expresiones inválidas
- ✅ Validación de paréntesis balanceados
- ✅ Prevención de operadores consecutivos
- ✅ Manejo robusto de errores (la app nunca crashea)

### Diseño UI
- 🎨 Diseño inspirado en la calculadora Android en modo oscuro
- ⚫ Botones circulares con colores diferenciados
- 🟢 Botón "=" destacado en verde
- 📱 Display superior con expresión y resultado
- 🔄 Layout completamente responsive
- 📐 Soporte para orientación vertical y horizontal

### Arquitectura
- 🏗️ Separación clara entre UI y lógica de negocio
- 📁 Organización de código por funcionalidad
- ♻️ Widgets reutilizables
- 💬 Código bien comentado y documentado
- 🧪 Preparado para testing

## 📂 Estructura del Proyecto

```
calculator_app/
│
├── lib/
│   ├── main.dart                       # Punto de entrada de la aplicación
│   ├── constants/
│   │   └── app_colors.dart             # Colores de la aplicación
│   ├── logic/
│   │   └── calculator_logic.dart       # Lógica de la calculadora
│   ├── screens/
│   │   └── calculator_screen.dart      # Pantalla principal
│   └── widgets/
│       ├── calculator_button.dart      # Widget de botón reutilizable
│       └── calculator_display.dart     # Widget del display
│
├── pubspec.yaml                        # Dependencias del proyecto
└── README.md                           # Este archivo
```

## 🚀 Instalación y Ejecución

### Requisitos Previos
- Flutter SDK 3.0 o superior
- Dart SDK 3.0 o superior
- Android Studio / VS Code con extensiones de Flutter

### Pasos de Instalación

1. **Clonar el repositorio**
```bash
git clone https://github.com/Leonide-Lopez-Robles/calculadora_Leo
cd calculator_Leo
```

2. **Instalar dependencias**
```bash
flutter pub get
```

3. **Ejecutar la aplicación**
```bash
flutter run
```

4. **Compilar para producción**
```bash
# Android
flutter build apk --release

# iOS
flutter build ios --release
```

## 🎯 Uso de la Aplicación

### Operaciones Básicas
1. Toca los números para construir tu expresión
2. Usa los operadores (+, -, ×, ÷) para operaciones
3. Usa paréntesis ( ) para operaciones complejas
4. Presiona "=" para calcular el resultado
5. Presiona "C" para limpiar todo

### Ejemplos de Expresiones Válidas
- `5 + 3` → 8
- `10 × (2 + 3)` → 50
- `100 ÷ 4` → 25
- `(8 - 3) × 2` → 10

### Manejo de Errores
La aplicación detecta y muestra mensajes claros para:
- División entre cero
- Paréntesis no balanceados
- Expresiones incompletas
- Operadores mal colocados

## 🏗️ Arquitectura y Diseño

### Principios Aplicados
- **Separación de Responsabilidades**: La lógica está completamente separada de la UI
- **Reutilización de Código**: Widgets modulares y reutilizables
- **Clean Code**: Código legible con nombres descriptivos
- **Documentación**: Comentarios claros en todo el código

### Algoritmos Implementados
- **Shunting Yard Algorithm**: Para convertir expresiones infijas a notación polaca inversa (RPN)
- **RPN Evaluation**: Para evaluar expresiones matemáticas de forma segura

### Orientación Adaptativa
La app usa `OrientationBuilder` para adaptar el layout:
- **Vertical**: Layout tipo calculadora clásica
- **Horizontal**: Display más grande con botones reorganizados

## 🎨 Personalización

### Colores
Los colores se pueden modificar en `lib/constants/app_colors.dart`:
```dart
static const Color equalsButton = Color(0xFF4CAF50); // Verde
static const Color operatorButton = Color(0xFF505050); // Gris medio
static const Color numberButton = Color(0xFF2E2E2E); // Gris oscuro
```

### Tamaño de Botones
Se puede ajustar en `lib/widgets/calculator_button.dart`:
```dart
double buttonSize = isLandscape ? 60.0 : 75.0;
```

## 📱 Capturas de Pantalla

### Modo Vertical
### Modo Horizontal
<p align="center">

  <img src="modo_vertical.jpeg" width="450"/>
</p>


### Modo Horizontal
<p align="center">
  <img src="modo_horizontal.jpeg" width="450"/>
</p>


## 🧪 Testing

Para ejecutar tests (cuando se implementen):
```bash
flutter test
```

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:
1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📝 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autor

**Tu Nombre**
- GitHub: [@tu-usuario](https://github.com/Leonide-Lopez-Robles)

## 🙏 Agradecimientos

- Inspirado en la calculadora nativa de Android
- Desarrollado como proyecto educativo de Flutter

---

⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub
