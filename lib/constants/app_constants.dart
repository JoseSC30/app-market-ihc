// Este archivo contiene constantes de colores y estilos para mantener consistencia en toda la app

import 'package:flutter/material.dart';

class AppColors {
  // Colores principales
  static final Color primary = Colors.green.shade700;
  static final Color primaryLight = Colors.green.shade50;
  static final Color primaryDark = Colors.green.shade800;
  
  // Colores secundarios
  static const Color accent = Colors.orange;
  static final Color rating = Colors.amber.shade700;
  
  // Colores de texto
  static final Color textPrimary = Colors.grey.shade800;
  static final Color textSecondary = Colors.grey.shade600;
  static const Color textWhite = Colors.white;
  
  // Colores de fondo
  static final Color background = Colors.grey.shade50;
  static const Color cardBackground = Colors.white;
  
  // Colores de borde
  static final Color border = Colors.green.shade200;
}

class AppTextStyles {
  // Títulos
  static const TextStyle title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );
  
  static const TextStyle subtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );
  
  // Precios
  static TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  
  static TextStyle priceSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
  
  // Textos normales
  static TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );
  
  static TextStyle bodySmall = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 20.0;
  static const double xxl = 24.0;
}

class AppBorderRadius {
  static const double small = 8.0;
  static const double medium = 12.0;
  static const double large = 16.0;
  static const double circular = 50.0;
}
