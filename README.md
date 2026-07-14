<div align="center">

# ☄️ Comets

### *Cincuenta luciérnagas digitales cayendo por un cielo de código*

<br/>

Un shader GLSL que simula cometas con colas brillantes,
movimiento orgánico y una profundidad que invita a detenerse a mirar.

*Inspirado en los residuos del séptimo vuelo de Starship.*

<br/>

[![WebGL][webgl-badge]][webgl-url]
[![License: MIT][license-badge]][license-url]

</div>

---

## ¿Qué es esto?

**Comets** es un único archivo HTML que contiene un shader completo: cincuenta partículas coloreadas caen por pantalla con colas de luz que se atenúan, parpadean y se entrelazan.

No hay frameworks. No hay dependencias. No hay build tools.

Solo un navegador, un canvas y cien líneas de GLSL haciendo magia.

El shader original — [*Starship*][shadertoy-url] de **@XorDev** — fue creado para Shadertoy. Esta versión lo libera de ese entorno y lo hace funcionar autonomamente, con una textura de ruido generada en tiempo real y un pipeline de renderizado WebGL puro.

---

## Características

| | Detalle |
|---|---|
| **Partículas** | 50 cometas con posiciones independientes |
| **Color** | RGB con frecuencias separadas por canal — el rojo perdura, el azul se disipa |
| **Brillo** | Fluctuación exponencial entre *1/e* y *e* por partícula |
| **Textura** | Ruido procedural generado en Canvas 2D — sin archivos externos |
| **Tonemap** | `tanh` para un rango dinámico suave y controlado |
| **Aspect ratio** | Se mantiene estable al redimensionar la ventana |
| **Dependencias** | Cero |

---

## Cómo se ve

```
    *       . ·  *
  ·    *  .    ·
    .  *  ·  *
  *    .    ·   *
    ·   *    .
```

*(Abre `index.html` en tu navegador para ver la versión real. No sabemos ASCII art.)*

---

## Inicio rápido

### Opción A — Doble clic

1. Clona el repositorio
2. Abre `index.html` en cualquier navegador moderno
3. Listo

```bash
git clone https://github.com/sebastianvasquezechavarria1234/comet.git
cd comet
# Abrir index.html
```

### Opción B — Servidor local

Si prefieres usar un servidor (por CORS o cualquier otra razón):

```bash
# Python
python -m http.server 3000

# Node.js
npx serve .
```

Luego abre `http://localhost:3000`.

---

## Estructura

```
comet/
├── index.html              ← El proyecto. Ábrelo.
├── comets.glsl             ← Shader base (referencia)
├── comets_complete.glsl    ← Variante con textura externa
└── README.md               ← Lo que estás leyendo
```

**`index.html`** es el corazón. Contiene la inicialización de WebGL, la generación de la textura de ruido y el shader completo. No necesitas nada más.

Los archivos `.glsl` existen como referencia para quien quiera llevar el shader a Shadertoy u otros editores.

---

## Bajo el capó

### El viaje de un píxel

```
Coordenadas del fragmento
        │
        ▼
   Centro + rotación
        │
        ▼
   ┌─── Loop de 50 partículas ───┐
   │                              │
   │  Posición (seno + tiempo)    │
   │  Color (RGB por índice)      │
   │  Brillo (exponencial)        │
   │  Cola (caída de luz + ruido) │
   │                              │
   └──────────────────────────────┘
        │
        ▼
    Tonemap → Pantalla
```

### La posición de cada cometa

Cada partícula tiene un centro calculado con funciones trigonométricas. La componente Y incluye una dependencia lineal del tiempo, lo que crea la caída constante:

```glsl
vec3 center = vec3(
    cos(i*11.0 + i*i + T*0.2),
    sin(i*9.0  + i*i + T*0.2) - t*0.5 - i*0.15,
    0.0
);
```

- `i` — índice de la partícula (0 a 49)
- `t` — tiempo en segundos
- `T` — tiempo modificado con componente espacial

El término `- i*0.15` distribuye las partículas verticalmente para que no aparezcan todas en el mismo punto.

---

## Ajustes

| Parámetro | Línea | Efecto |
|-----------|-------|--------|
| Velocidad de caída | `- t*0.5` | Aumentar para caer más rápido |
| Separación vertical | `- i*0.15` | Aumentar para mayor dispersión |
| Número de partículas | `n < 50` | Más partículas = más densidad |
| Intensidad del brillo | `exp(sin(...))` | Factor multiplicativo directo |

---

## Créditos

Este proyecto no existiría sin el trabajo de **[@XorDev][xordev-url]**, cuyo shader *Starship* sirvió como base y referencia.

La inspiración visual viene del [vuelo de prueba número 7 de SpaceX Starship][inspiration-url] — los residuos luminosos que dejó en el cielo.

---

## Licencia

Distribuido bajo la licencia **MIT**. Usa este código como quieras.

---

<div align="center">

*Hecho con WebGL y curiosidad.*

</div>

<!-- Badges -->
[webgl-badge]: https://img.shields.io/badge/WebGL-1.0-990000?style=flat-square&logo=webgl&logoColor=white
[webgl-url]: https://www.khronos.org/webgl/
[license-badge]: https://img.shields.io/badge/License-MIT-blue.svg?style=flat-square
[license-url]: https://opensource.org/licenses/MIT
[shadertoy-url]: https://www.shadertoy.com/view/Xs33Dv
[xordev-url]: https://x.com/XorDev
[inspiration-url]: https://x.com/elonmusk/status/1880040599761596689
