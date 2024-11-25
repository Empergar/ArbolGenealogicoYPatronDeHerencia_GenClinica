# Función para verificar e instalar paquetes
check_and_install <- function(packages) {
  for (pkg in packages) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      cat(sprintf("El paquete '%s' no está instalado. Instalándolo ahora...\n", pkg))
      install.packages(pkg)
    } else {
      cat(sprintf("El paquete '%s' ya está instalado.\n", pkg))
    }
  }
}

# 1. Generación de íconos (imágenes) para el árbol genealógico
generate_icons <- function() {
  # Cuadrado con diagonal tachada (hombre fallecido)
  png("square_fallen.png", width = 400, height = 400)
  grid.newpage()
  grid.rect(x = 0.5, y = 0.5, width = 0.4, height = 0.4, gp = gpar(col = "black", fill = "white", lwd = 8))
  grid.lines(x = c(0.2, 0.8), y = c(0.2, 0.8), gp = gpar(col = "black", lwd = 8)) # Diagonal tachada
  dev.off()
  
  # Círculo con diagonal tachada (mujer fallecida)
  png("circle_fallen.png", width = 400, height = 400)
  grid.newpage()
  grid.circle(x = 0.5, y = 0.5, r = 0.2, gp = gpar(col = "black", fill = "white", lwd = 8))
  grid.lines(x = c(0.2, 0.8), y = c(0.2, 0.8), gp = gpar(col = "black", lwd = 8)) # Diagonal tachada
  dev.off()
  
  # Cuadrado relleno (hombre sano)
  png("square_healthy.png", width = 400, height = 400)
  grid.newpage()
  grid.rect(x = 0.5, y = 0.5, width = 0.4, height = 0.4, gp = gpar(col = "black", fill = "white", lwd = 8))
  dev.off()
  
  # Círculo relleno (mujer sana)
  png("circle_healthy.png", width = 400, height = 400)
  grid.newpage()
  grid.circle(x = 0.5, y = 0.5, r = 0.2, gp = gpar(col = "black", fill = "white", lwd = 8))
  dev.off()
  
  # Círculo relleno (mujer afectada)
  png("circle_affected.png", width = 400, height = 400)
  grid.newpage()
  grid.circle(x = 0.5, y = 0.5, r = 0.2, gp = gpar(col = "black", fill = "black", lwd = 8))
  dev.off()
  
  # Cuadrado relleno (hombre afectado)
  png("square_affected.png", width = 400, height = 400)
  grid.newpage()
  grid.rect(x = 0.5, y = 0.5, width = 0.4, height = 0.4, gp = gpar(col = "black", fill = "black", lwd = 8))
  dev.off()
  
  # Concultante
  png("circle_with_arrow.png", width = 400, height = 400)
  grid.newpage()
  grid.circle(x = 0.5, y = 0.5, r = 0.2, gp = gpar(col = "black", fill = "white"))
  grid.lines(x = c(0.2, 0.4), y = c(0.15, 0.35), gp = gpar(col = "black", lwd = 8), 
             arrow = arrow(type = "closed", length = unit(0.5, "inches")))
  dev.off()
  
  # Probando
  png("squad_with_arrow.png", width = 400, height = 400)
  grid.newpage()
  grid.rect(x = 0.5, y = 0.5, width = 0.4, height = 0.4, gp = gpar(col = "black", fill = "black", lwd = 8))
  grid.lines(x = c(0.08, 0.30), y = c(0.15, 0.3), gp = gpar(col = "black", lwd = 2), 
             arrow = arrow(type = "closed", length = unit(0.5, "inches")))
  dev.off()
}

# 2. Cargar los íconos generados
load_icons <- function() {
  square_fallen <- readPNG("square_fallen.png")
  circle_fallen <- readPNG("circle_fallen.png")
  square_healthy <- readPNG("square_healthy.png")
  circle_healthy <- readPNG("circle_healthy.png")
  circle_affected <- readPNG("circle_affected.png")
  square_affected <- readPNG("square_affected.png")
  circle_with_arrow <- readPNG("circle_with_arrow.png")
  squad_with_arrow <- readPNG("squad_with_arrow.png")
  
  return(list(
    square_fallen = square_fallen,
    circle_fallen = circle_fallen,
    square_healthy = square_healthy,
    circle_healthy = circle_healthy,
    circle_affected = circle_affected,
    square_affected = square_affected,
    circle_with_arrow = circle_with_arrow,
    squad_with_arrow = squad_with_arrow
    
  ))
}

# 3. Crear los datos familiares (pedigrí)
create_family_data <- function() {
  x1 = ped(id = c(
                  1, 2, # Suegro, Suegra
                  3, 4, 5, 6, 7, # Elena, Yolanda, Manolo, Ernesto, Guillermo
                  8, # Padre desconocido
                  9, 10, 11, 12, # Hijo 1, Hijo 2, Hijo 3, Hijo 4 de Elena
                  13, # Melody
                  14, 15, 16, 17, # Hijo fallecido, Hija mayor, Segundo hijo, Tercera hija
                  18, 19, 20, 21, 22 # Esposa de Guillermo, Hijo 1 Guillermo, Hijo 2 Guillermo, Gemela 1, Gemela 2
                ),
          fid = c(
                  NA, NA, # Fundadores no tienen padre
                  1, 1, 1, 1, 1, # Padre de los hijos del Suegro
                  NA, # Padre desconocido
                  8, 8, 8, 8, # Padre de los hijos de Elena
                  NA, # Melody no tiene padre definido
                  5, 5, 5, 5, # Padre de los hijos de Manolo
                  NA, 7, 7, 7, 7 # Padre de los hijos de Guillermo
                ),
          mid = c(
                  NA, NA, # Fundadores no tienen madre
                  2, 2, 2, 2, 2, # Madre de los hijos del Suegro
                  NA, # Madre desconocida
                  3, 3, 3, 3, # Madre de los hijos de Elena
                  NA, # Melody no tiene madre definida
                  13, 13, 13, 13, # Madre de los hijos de Manolo
                  NA, 18, 18, 18, 18 # Madre de los hijos de Guillermo
                ),
          sex = c(
                  1, 2, # Fundadores
                  2, 2, 1, 1, 1, # Hijos del Suegro y Suegra
                  1, # Padre de los hijos de Elena
                  1, 2, 1, 2, # Hijos de Elena
                  2, # Sexo de Melody
                  1, 2, 1, 2, # Hijos de Manolo
                  2, 1, 1, 2, 2 # Familia de Guillermo
                )
  )
  return(x1)
}

# 4. Generar el gráfico 
plot_pedigree <- function(x1) {

  # Twins
  twins = data.frame(id1 = "21", id2 = "22", code = 3)
  
  # Crear las anotaciones de texto
  textAnnot = list(
    bottom = list(
      c(`1`="Infarto", `2`="Infección\n respiratoria", `3` = "Aneurisma",`4`="Problemas de\n corazón" , `5` = "Estrabismo", `14`="Cardiomegalia", `15`= "Escoliosis", `10`="Dientes apiñados\n, protusión dental\n y paladar ojival", `11`="Brazos largos,\n espalda encorvada"), 
      cex = 0.5, font = 2, col = "black", offset = 1.5
    )
  )
  
  par(mar = c(1, 1, 1, 1))  # Aumentar los márgenes
  # Plot
  plot(x1, cex = 0.8, symbolsize = 1, margins = 3,
       deceased = c("1", "2", "3", "14"),
       fill = c(`1` = "1", `14` = "1", `2` = "1", `5` = "1", `4` = "1", `3`="1", `10`="1", `11`="1", `15`="1"),
       twins = twins,
       textAnnot = textAnnot)
  
  # Añadir flechas y texto para "Consultante" y "Proband"
  arrows(x0 = 5.6, y0 = 2.2, x1 = 5.8, y1 = 2.15, col = "black", lwd = 2, length = 0.05) # Flecha para Consultante
  arrows(x0 = 3.4, y0 = 3.2, x1 = 3.6, y1 = 3.15, col = "black", lwd = 2, length = 0.05) # Flecha para Consultante
  
  # Cargar los íconos
  icons <- load_icons()
  
  # Definir el tamaño de las imágenes
  image_size <- 0.05
  image_size2 <- 0.03
  
  # Colocar las imágenes en la gráfica
  grid.raster(icons$square_fallen, x = 0.85, y = 0.90, width = image_size2, height = image_size)
  grid.raster(icons$circle_fallen, x = 0.85, y = 0.85, width = image_size2, height = image_size)
  grid.raster(icons$square_affected, x = 0.85, y = 0.80, width = image_size2, height = image_size)
  grid.raster(icons$circle_affected, x = 0.85, y = 0.75, width = image_size2, height = image_size)
  grid.raster(icons$square_healthy, x = 0.85, y = 0.70, width = image_size2, height = image_size)
  grid.raster(icons$circle_healthy, x = 0.85, y = 0.65, width = image_size2, height = image_size)
  grid.raster(icons$circle_with_arrow, x = 0.85, y = 0.6, width = image_size2, height = image_size)
  grid.raster(icons$squad_with_arrow, x = 0.85, y = 0.55, width = image_size2, height = image_size)
  
  
  # Ajustar el texto para la leyenda
  grid.text("Leyenda", x = 0.84, y = 0.95, just = "left", gp = gpar(fontsize = 5, fontface = "bold.italic", col = "black"))
  grid.text("Hombre fallecido", x = 0.9, y = 0.9, just = "left", gp = gpar(fontsize = 6))
  grid.text("Mujer fallecida", x = 0.9, y = 0.85, just = "left", gp = gpar(fontsize = 6))
  grid.text("Hombre afectado", x = 0.9, y = 0.80, just = "left", gp = gpar(fontsize = 6))
  grid.text("Mujer afectada", x = 0.9, y = 0.75, just = "left", gp = gpar(fontsize = 6))
  grid.text("Hombre sano", x = 0.9, y = 0.70, just = "left", gp = gpar(fontsize = 6))
  grid.text("Mujer sana", x = 0.9, y = 0.65, just = "left", gp = gpar(fontsize = 6))
  grid.text("Consultante", x = 0.9, y = 0.60, just = "left", gp = gpar(fontsize = 6))
  grid.text("Probando", x = 0.9, y = 0.55, just = "left", gp = gpar(fontsize = 6))
  
  # Crear los nombres para la leyenda
  names_legend <- c(
    "1 = Suegro", "2 = Suegra", "3 = Elena", "4 = Yolanda", "5 = Manolo", "6 = Ernesto", "7 = Guillermo",
    "8 = Padre desconocido", "9 = Hijo 1", "10 = Hijo 2", "11 = Hijo 3", "12 = Hijo 4",
    "13 = Melody", "14 = Hijo fallecido", "15 = Hija mayor", "16 = Segundo hijo", "17 = Tercera hija",
    "18 = Esposa de Guillermo", "19 = Hijo 1 Guillermo", "20 = Hijo 2 Guillermo", "21 = Gemela 1", "22 = Gemela 2"
  )
  
  grid.text("Leyenda de nombres", x = 0.05, y = 0.95, just = "left", gp = gpar(fontsize = 7, fontface = "bold.italic", col = "black"))
  
  # Convertir la leyenda a una sola línea horizontal
  legend_text <- paste(names_legend, collapse = "\n")
  
  # Añadir la leyenda centrada y en formato horizontal
  grid.text(legend_text, 
            x = 0.05, y = 0.75, just = "left", gp = gpar(fontsize = 7, fontface = "italic"))
}

# Lista de paquetes a verificar
packages_to_check <- c("grid", "png", "pedtools")

# Verificar e instalar si es necesario
check_and_install(packages_to_check)

generate_icons()  # Paso 1: Generar íconos
icons <- load_icons()  # Paso 2: Cargar íconos
x1 <- create_family_data()  # Paso 3: Crear datos familiares
plot_pedigree(x1)  # Paso 4: Generar el gráfico
