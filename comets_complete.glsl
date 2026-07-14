// "Starship" by @XorDev - Código completo para Shadertoy
// https://www.shadertoy.com/view/Xs33Dv

void mainImage( out vec4 O, vec2 I )
{
    // Resolución para escalado
    vec2 r = iResolution.xy,
    // Centro, rotación y escalado
    p = (I+I-r) / r.y * mat2(4,-3,3,4);
    
    // Tiempo, tiempo de estela y variables de iteración
    float t=iTime, T=t+.1*p.x, i;
    
    // Iterar a través de 50 partículas
    for(
        // Limpiar fragColor
        O *= i; i++<50.;
        
        /// Establecer color:
        // El seno nos da un índice de color entre -1 y +1.
        // Luego damos a cada canal una frecuencia separada.
        // El rojo es el más amplio, mientras que el azul se disipa rápidamente.
        // Sumamos uno para evitar valores negativos de color (0 a 2).
        O += (cos(sin(i)*vec4(1,2,3,0))+1.)
        
        /// Brillo parpadeante:
        // El brillo fluctúa exponencialmente entre 1/e y e.
        // Cada partícula tiene una frecuencia de destello según su índice.
        * exp(sin(i+.1*i*T))
        
        /// Partículas con estela de luz atenuada:
        // La idea básica es empezar con una caída de luz de punto.
        // Usamos max en las coordenadas para escalar las direcciones
        // positivas y negativas independientemente.
        // El eje x se reduce mucho para una estela larga.
        // Se añade ruido al factor de escala para profundidad nublada.
        // El eje y también se estira un poco para un efecto de resplandor.
        // Intenta un valor más alto como 4 para más claridad
        / length(max(p,
            p / vec2(texture(iChannel0, p/exp(sin(i)+5.)+vec2(t,i)/8.).r*40.,2))
        )
        
        /// Cambiar posición para cada partícula:
        // Frecuencias para distribuir partículas x e y independientemente
        // i*i es una forma rápida de ocultar los períodos de la onda seno
        // t para cambiar con el tiempo y p.x para dejar estelas al moverse
        p+=2.*cos(i*vec2(11,9)+i*i+T*.2);
    
    // Añadir fondo de cielo y tonemap "tanh"
    O = tanh(.01*p.y*vec4(0,1,2,3)+O*O/1e4);
}
