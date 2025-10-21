# Market App - Aplicación de Compras

## 📱 Descripción
Aplicación móvil de compras de productos esenciales desarrollada en Flutter, con un diseño moderno inspirado en plataformas como Amazon, Mercado Libre y PedidosYa.

## 🎨 Características del Diseño
- **Color primario**: Verde (#4CAF50)
- **Interfaz moderna y limpia**
- **Diseño responsive**
- **Navegación intuitiva**

## 📂 Estructura del Proyecto

```
lib/
├── main.dart                   # Punto de entrada de la aplicación
├── models/                     # Modelos de datos
│   ├── product.dart           # Modelo de producto
│   └── category.dart          # Modelo de categoría
├── screens/                    # Pantallas de la aplicación
│   └── home_screen.dart       # Pantalla principal
├── widgets/                    # Widgets reutilizables
│   ├── product_card.dart      # Tarjeta de producto
│   ├── category_card.dart     # Tarjeta de categoría
│   └── featured_banner.dart   # Banner de ofertas
└── data/                       # Datos de ejemplo
    └── sample_data.dart       # Productos y categorías de muestra
```

## 🚀 Componentes Principales

### 1. **HomeScreen** (`screens/home_screen.dart`)
Pantalla principal que incluye:
- Barra de búsqueda
- Banner de ofertas destacadas
- Lista horizontal de categorías
- Productos destacados
- Grid de todos los productos
- Barra de navegación inferior

### 2. **ProductCard** (`widgets/product_card.dart`)
Tarjeta de producto que muestra:
- Imagen del producto
- Nombre y descripción
- Calificación y reseñas
- Precio
- Botón para agregar al carrito
- Badge de "Destacado" para productos especiales

### 3. **CategoryCard** (`widgets/category_card.dart`)
Tarjeta de categoría con:
- Icono representativo
- Nombre de la categoría
- Diseño circular con bordes verdes

### 4. **FeaturedBanner** (`widgets/featured_banner.dart`)
Banner promocional con:
- Gradiente verde
- Mensaje de ofertas
- Botón de acción
- Diseño llamativo

## 🎯 Funcionalidades Implementadas

✅ Vista principal con diseño atractivo
✅ Navegación por categorías
✅ Visualización de productos destacados
✅ Grid de productos con scroll
✅ Barra de búsqueda
✅ Carrito de compras (indicador)
✅ Notificaciones (indicador)
✅ Navegación inferior con 4 secciones

## 🎨 Paleta de Colores

- **Verde Principal**: `Colors.green.shade700` (#388E3C)
- **Verde Claro**: `Colors.green.shade50`
- **Naranja (Destacados)**: `Colors.orange`
- **Amarillo (Estrellas)**: `Colors.amber.shade700`
- **Gris (Texto secundario)**: `Colors.grey.shade600`
- **Blanco**: Para tarjetas y fondos

## 📦 Dependencias

Este proyecto utiliza las dependencias estándar de Flutter. No requiere paquetes adicionales para la versión actual.

## 🔧 Cómo Ejecutar

1. Asegúrate de tener Flutter instalado
2. Navega al directorio del proyecto
3. Ejecuta:
```bash
flutter pub get
flutter run
```

## 📱 Capturas de Pantalla

La aplicación incluye:
- **AppBar**: Con logo, ubicación, notificaciones y carrito
- **Barra de búsqueda**: Para encontrar productos rápidamente
- **Banner de ofertas**: Promociones destacadas
- **Categorías**: Desplazamiento horizontal de categorías
- **Productos destacados**: Carrusel horizontal
- **Todos los productos**: Grid de 2 columnas
- **Bottom Navigation**: 4 tabs (Inicio, Buscar, Favoritos, Perfil)

## 🛠️ Próximas Mejoras

- [ ] Implementar funcionalidad del carrito de compras
- [ ] Agregar pantalla de detalles del producto
- [ ] Implementar filtros y búsqueda
- [ ] Agregar favoritos
- [ ] Crear pantalla de perfil
- [ ] Integrar con API real
- [ ] Agregar animaciones
- [ ] Implementar sistema de autenticación

## 👨‍💻 Desarrollo

Desarrollado con Flutter para la materia de IHC (Interacción Humano-Computador)

---

**Nota**: Los datos actuales son de ejemplo. Las imágenes utilizan placeholders que pueden ser reemplazadas con imágenes reales de productos.
