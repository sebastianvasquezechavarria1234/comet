/*
    "Comets" - Shader de Cometas
    Inspirado en "Starship" by @XorDev
    
    Modificado para crear efecto de cometas con colas brillantes
*/

void mainImage( out vec4 O, vec2 I )
{
    // Resolución para escalado
    vec2 r = iResolution.xy,
    
    // Centro, rotación y escalado
    p = (I + I - r) / r.y * mat2(3, 4, 4, -3) / 1e2;
    
    // Suma de colores, cambio de color RGB y onda
    vec4 S, C = vec4(1, 2, 3, 0), W;
    
    // Tiempo, tiempo de estela y variables de iteración
    // Iterar a través de 50 partículas
    for(float t = iTime, T = .1*t + p.y, i; i++ < 50.;)
    {
        /// Establecer color:
        // El seno nos da un índice de color entre -1 y +1.
        // Luego damos a cada canal una frecuencia separada.
        // El rojo es el más amplio, mientras que el azul se disipa rápidamente.
        // Sumamos uno para evitar valores negativos de color (0 a 2).
        S += (cos(W = sin(i) * C) + 1.)
        
        /// Brillo parpadeante:
        // El brillo fluctúa exponencialmente entre 1/e y e.
        // Cada partícula tiene una frecuencia de destello según su índice.
        * exp(sin(i + i*T))
        
        /// Partículas con estela de luz atenuada:
        // La idea básica es empezar con una caída de luz de punto.
        // Usamos max en las coordenadas para escalar las direcciones
        // positivas y negativas independientemente.
        // El eje x se reduce mucho para una estela larga.
        // Se añade ruido al factor de escala
        * .01 / (1. + 80.*length(max(abs(p - vec2(sin(W.y)*.8, fract(i/50. - t*.1))), 0.)));
        
        // Reiniciar la posición para la siguiente partícula
        p = (I + I - r) / r.y * mat2(3, 4, 4, -3) / 1e2;
    }
    
    // Aplicar tono y gamma
    O = pow(S/50., vec4(.8));
}
