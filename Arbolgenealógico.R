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
}

# 2. Cargar los íconos generados
load_icons <- function() {
  square_fallen <- readPNG("square_fallen.png")
  circle_fallen <- readPNG("circle_fallen.png")
  square_healthy <- readPNG("square_healthy.png")
  circle_healthy <- readPNG("circle_healthy.png")
  circle_affected <- readPNG("circle_affected.png")
  square_affected <- readPNG("square_affected.png")
  
  return(list(
    square_fallen = square_fallen,
    circle_fallen = circle_fallen,
    square_healthy = square_healthy,
    circle_healthy = circle_healthy,
    circle_affected = circle_affected,
    square_affected = square_affected
  ))
}

# 3. Crear los datos familiares (pedigrí)
create_family_data <- function() {
  
  # Crear los datos familiares basados en family_ped
  family_ped <- data.frame(
    id = c(
      1, 2, # Suegro, Suegra
      3, 4, 5, 6, 7, # Elena, Yolanda, Manolo, Ernesto, Guillermo
      8, # Padre desconocido
      9, 10, 11, 12, # Hijo 1, Hijo 2, Hijo 3, Hijo 4 de Elena
      13, # Melody
      14, 15, 16, 17, # Hijo fallecido, Hija mayor, Segundo hijo, Tercera hija
      18, 19, 20, 21, 22 # Esposa de Guillermo, Hijo 1 Guillermo, Hijo 2 Guillermo, Gemela 1, Gemela 2
    ),
    father = c(
      NA, NA, # Fundadores no tienen padre
      1, 1, 1, 1, 1, # Padre de los hijos del Suegro
      NA, # Padre desconocido
      8, 8, 8, 8, # Padre de los hijos de Elena
      NA, # Melody no tiene padre definido
      5, 5, 5, 5, # Padre de los hijos de Manolo
      NA, 7, 7, 7, 7 # Padre de los hijos de Guillermo
    ),
    mother = c(
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
    ),
    status = c(
      1, 0, # Suegro fallecido, Suegra viva
      1, 0, 0, 0, 0, # Elena fallecida, los demás vivos
      0, # Padre de los hijos de Elena vivo
      0, 0, 0, 0, # Hijos de Elena vivos
      0, # Melody viva
      1, 0, 0, 0, # Hijo fallecido, los demás vivos
      0, 0, 0, 0, 0 # Familia de Guillermo viva
    ),
    name = c(
      "Suegro", "Suegra",
      "Elena", "Yolanda", "Manolo", "Ernesto", "Guillermo",
      "Padre desconocido",
      "Hijo 1", "Hijo 2", "Hijo 3", "Hijo 4",
      "Melody",
      "Hijo fallecido", "Hija mayor", "Segundo hijo", "Tercera hija",
      "Esposa Guillermo", "Hijo 1 Guillermo", "Hijo 2 Guillermo", "Gemela 1", "Gemela 2"
    ),
    condition = c(
      "Infarto", "Infección respiratoria", # Suegro y Suegra
      "Aneurisma", "Problemas de corazón", "Estrabismo", NA, NA, # Elena, Yolanda, Manolo, etc.
      NA, # Padre desconocido
      NA, NA, NA, NA, # Hijos de Elena
      NA, # Melody
      "Cardiomegalia", NA, NA, NA, # Hijo fallecido, demás hijos
      NA, NA, NA, NA, NA # Familia de Guillermo
    )
  )
  return(family_ped)
}

# 4. Crear el pedigrí usando la función 'kinship2'
create_pedigree <- function(family_ped) {
  pedigree_data <- pedigree(
    id = family_ped$id,
    dadid = family_ped$father,
    momid = family_ped$mother,
    sex = family_ped$sex,
    status = family_ped$status
  )
  
  return(pedigree_data)
}

# 5. Generar el gráfico del pedigrí
plot_pedigree <- function(pedigree_data, family_ped, icons) {
  # Crear etiquetas con nombres y condiciones
  node_labels <- ifelse(
    is.na(family_ped$condition),
    family_ped$name,
    paste(family_ped$name, family_ped$condition, sep = "\n")
  )
  
  # Crear la matriz de afectación (1 = afectado, 0 = no afectado)
  affected_matrix <- sapply(family_ped$condition, function(condition) {
    if (is.na(condition)) {
      return(0)  # No afectado si no tiene afección
    } else {
      return(1)  # Afectado si tiene afección
    }
  })
  
  # Crear el gráfico del pedigrí
  par(mar = c(3, 3, 2, 2))  # Aumentar los márgenes
  plot(
    pedigree_data,
    id = node_labels,
    symbolsize = 1.5,
    cex = 0.6,
    affected = affected_matrix,
    col = "black",
    density = c(-1, 35),
    angle = c(90, 45)
  )
  
  generation_y_coords <- c(
    "I" = 0.93,  # Generación 1 en y = 0.95
    "II" = 0.55,  # Generación 2 en y = 0.6
    "III" = 0.2   # Generación 3 en y = 0.3
  )
  
  # Colocar las etiquetas de generación manualmente (solo una por generación)
  # Colocamos la etiqueta de cada generación una sola vez, en el centro del gráfico.
  
  # Generación I
  grid.text("I", x = 0.02, y = generation_y_coords["I"], 
            just = "left", gp = gpar(fontsize = 10, fontface = "bold", col = "black"))
  
  # Generación II
  grid.text("II", x = 0.02, y = generation_y_coords["II"], 
            just = "left", gp = gpar(fontsize = 10, fontface = "bold", col = "black"))
  
  # Generación III
  grid.text("III", x = 0.02, y = generation_y_coords["III"], 
            just = "left", gp = gpar(fontsize = 10, fontface = "bold", col = "black"))
  
  
  # Colocar las imágenes usando 'grid.raster' para cada uno de los íconos
  image_size <- 0.05
  image_size2 <- 0.03
  
  # Colocar las imágenes en la gráfica
  grid.raster(icons$square_fallen, x = 0.85, y = 0.90, width = image_size2, height = image_size)
  grid.raster(icons$circle_fallen, x = 0.85, y = 0.85, width = image_size2, height = image_size)
  grid.raster(icons$square_affected, x = 0.85, y = 0.80, width = image_size2, height = image_size)
  grid.raster(icons$circle_affected, x = 0.85, y = 0.75, width = image_size2, height = image_size)
  grid.raster(icons$square_healthy, x = 0.85, y = 0.70, width = image_size2, height = image_size)
  grid.raster(icons$circle_healthy, x = 0.85, y = 0.65, width = image_size2, height = image_size)
  
  # Ajustar el texto para que se alinee con las imágenes y ocupe menos espacio
  grid.text("Leyenda", x = 0.84, y = 0.95, just = "left", gp = gpar(fontsize = 5, fontface = "bold.italic", col = "black"))
  grid.text("Hombre fallecido", x = 0.9, y = 0.9, just = "left", gp = gpar(fontsize = 6))
  grid.text("Mujer fallecida", x = 0.9, y = 0.85, just = "left", gp = gpar(fontsize = 6))
  grid.text("Hombre afectado", x = 0.9, y = 0.80, just = "left", gp = gpar(fontsize = 6))
  grid.text("Mujer afectada", x = 0.9, y = 0.75, just = "left", gp = gpar(fontsize = 6))
  grid.text("Hombre sano", x = 0.9, y = 0.70, just = "left", gp = gpar(fontsize = 6))
  grid.text("Mujer sana", x = 0.9, y = 0.65, just = "left", gp = gpar(fontsize = 6))
}

# 6. Ejecutar todo el proceso

# Lista de paquetes a verificar
packages_to_check <- c("grid", "png", "pedsuite", "kinship2")

# Verificar e instalar si es necesario
check_and_install(packages_to_check)

generate_icons()  # Paso 1: Generar íconos
icons <- load_icons()  # Paso 2: Cargar íconos
family_ped <- create_family_data()  # Paso 3: Crear datos familiares
pedigree_data <- create_pedigree(family_ped)  # Paso 4: Crear el pedigrí
plot_pedigree(pedigree_data, family_ped, icons)  # Paso 5: Generar el gráfico
