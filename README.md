# Árbol Genealógico y Patrón de Herencia

Este repositorio contiene el código y los resultados para crear un **árbol genealógico** con base en un conjunto de datos familiares ficticios. El objetivo de este análisis es representar las enfermedades hereditarias y su transmisión entre generaciones, visualizando los patrones de herencia mediante un diagrama de pedigrí.

## Descripción

El código en R genera un árbol genealógico utilizando las bibliotecas `kinship2` y `grid`, y emplea imágenes personalizadas para representar las afecciones de los miembros de la familia. Las afecciones se visualizan mediante íconos que representan a individuos **sanos**, **afectados** o **fallecidos**. Además, las etiquetas indican la condición de cada persona, como aneurisma, infarto, estrabismo, entre otros.

### Características

- **Generación del árbol genealógico** con las relaciones familiares y enfermedades.
- **Visualización personalizada** de los miembros utilizando imágenes (cuadrado y círculo con colores de acuerdo a la condición).
- **Leyenda** explicativa de las diferentes categorías de afección.

## Estructura del Código

1. **Generación de iconos**: El código crea imágenes de figuras (cuadrados y círculos) que representan a los individuos y sus condiciones (sano, afectado, fallecido).
2. **Datos familiares**: Los datos familiares están estructurados en un dataframe que incluye identificadores, relaciones padre-madre, sexo, estado (vivo o fallecido), y afección de cada miembro.
3. **Construcción del pedigrí**: Utilizando la biblioteca `kinship2`, se construye un pedigrí que muestra cómo se transmiten las afecciones a lo largo de las generaciones.
4. **Visualización**: Se utiliza la función `plot` para representar el árbol genealógico y la función `grid.raster` para posicionar las imágenes dentro del gráfico.

## Requisitos

Para ejecutar este código, asegúrate de tener instaladas las siguientes bibliotecas en R:

- `kinship2`
- `grid`
- `png`

Puedes instalar las bibliotecas necesarias utilizando los siguientes comandos:

```r
install.packages("kinship2")
install.packages("grid")
install.packages("png")
```

## Uso

1. **Ejecutar el código en R**: El código genera el árbol genealógico y las imágenes asociadas.
2. **Personalización**: Puedes modificar los datos familiares en el dataframe `family_ped` para adaptar el árbol genealógico a tu caso.
3. **Guardar las imágenes**: Las figuras generadas (cuadrados y círculos) se guardan como archivos PNG que se pueden utilizar para personalizar aún más la visualización.

## Ejemplo de salida

Al ejecutar el código, se genera un gráfico con el árbol genealógico, donde cada individuo está representado por un ícono (cuadrado o círculo) que indica su condición (sano, afectado, fallecido). La leyenda explica el significado de cada tipo de ícono.
