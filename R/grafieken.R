# hhskthema ---------------------------------------------------------------


#' HHSK thema
#' 
#' Dit is een HHSK-thema voor ggplot met de kleuren van HHSK
#'
#'
#' @return Een thema voor ggplot
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' my_ggplot + hhskthema()
#' 
#' }
hhskthema <- function(){
  #require(ggplot2)
  hhskthema <- ggplot2::theme_light() + ggplot2::theme(
        
        plot.title =    ggplot2::element_text(color = hhskgroen, face = "bold", hjust = 0.5),
        plot.subtitle = ggplot2::element_text(color = hhskgroen, face = "bold", hjust = 0.5, size = ggplot2::rel(1.1)),
        plot.caption =  ggplot2::element_text(color = hhskgroen, face = "italic"),
          
        axis.title =  ggplot2::element_text(color = hhskblauw, face = "bold"),
        axis.text =   ggplot2::element_text(color = hhskblauw),
        axis.ticks =  ggplot2::element_line(color = hhskblauw),
        axis.line.x = ggplot2::element_line(color = hhskblauw, size = 0.5),
        
        panel.border =     ggplot2::element_rect(color = hhskblauw, size = 1),
        panel.grid.major = ggplot2::element_line(color = hhskgroen, linetype = "dotted", size = 0.5),
        panel.grid.minor = ggplot2::element_line(color = hhskgroen, linetype = "dotted", size = 0.5),
        
        legend.title = ggplot2::element_text(color = hhskgroen, face = "bold", hjust = 0.5),
        legend.text =  ggplot2::element_text(color = hhskblauw),
        
        strip.background = ggplot2::element_blank(),
        strip.text =       ggplot2::element_text(face = "bold", color = hhskblauw)
    )
  hhskthema
}


# grafiek_basis -----------------------------------------------------------


#' Tijdreeksgrafiek
#'
#' Deze functie plot een tijdreeksgrafiek van 1 meetpunt van 1 parameter.
#'
#' @param data Een dataframe met de gegevens van 1 tijdreeks, dus van 1 meetpunt en 1 parameter. Kolommen zoals beschreven in [import_fys_chem()].
#' 
#' @param mp character. Meetpuntcode van het betreffende meetpunt. Neemt als default het eerste meetpunt uit `data`
#' 
#' @param parnr character. Parameternummer van het betrffende meetpunt. Neemt als default het eerste parameternummer uit `data`
#' 
#' @param parameterdf dataframe. Een opzoektabel voor de uitgebreide parameternaam en eenheid. Kolommen zoals beschreven in [import_parameters()].
#' Probeert default ook met deze functie een parameterdf te maken.
#' 
#' @param meetpuntendf dataframe. Een opzoektabel voor de locatie-omschrijving. Kolommen zoals beschreven in [import_meetpunten()].
#' Probeert default ook met deze functie een meetpuntendf te maken.
#' 
#' @param plot_loess logical. Wel of niet plotten van een LOESS-curve. Default is TRUE
#' 
#' @import dplyr
#' @importFrom lubridate year
#' @importFrom  scales rescale_none
#'
#' @return Een ggplot grafiek. Het is mogelijk om achteraf andere ggplot objecten toe te voegen met `+`
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' basisgrafiek <- grafiek_basis(data = chloride_myplace, 
#'                     parameterdf, meetpuntendf, plot_loess = FALSE) 
#' }
grafiek_basis <- function(data, 
                          mp = data[[1, "mp"]],
                          parnr = data[[1, "parnr"]],
                          meetpuntendf = import_meetpunten(),
                          parameterdf = import_parameters(),
                          plot_loess = TRUE){
  # het is de vraag of de grafiektitel, subtitel en astitels intern gedefinieerd moeten worden of toch liever daarbuiten

  #mp <- data[[1,"mp"]]
  mpomsch <- opzoeken_waarde(meetpuntendf, sleutel = mp, attribuut =  "mpomsch", sleutelkolom = "mp")

  #parnr <- data[[1,"parnr"]]
  parameternaam <- opzoeken_waarde(parameterdf, sleutel = parnr, attribuut = "parnaamlang", sleutelkolom = "parnr")
  eenheid <- opzoeken_waarde(parameterdf, parnr, "eenheid")

  min_y <- min(data$waarde)
  max_y <- max(data$waarde)
  if (min_y == max_y) { ylimieten <- c(0, max_y * 1.1)} else if (min_y / (max_y - min_y) > 1) {ylimieten <- c(min_y * 0.95, max_y * 1.05)} else {ylimieten <- c(0, max_y * 1.1)}
  
  grafiek <- ggplot2::ggplot(data, ggplot2::aes(x = datum, y = waarde)) +
    ggplot2::geom_line(col = hhskblauw) +
    ggplot2::geom_point(col = hhskblauw) +
    ggplot2::geom_point(data = dplyr::filter(data, detectiegrens == "<"), pch = 21, col = hhskblauw, fill = "white") + # detectiegrenswaarden
    
    ggplot2::labs(title = paste("Meetpunt:", mp,"-", mpomsch), subtitle = paste("Parameter:", parameternaam)) +
    ggplot2::ylab(eenheid) +
    ggplot2::scale_y_continuous(limits = ylimieten, expand = c(0,0), oob = scales::rescale_none ) +
    ggplot2::xlab("") +
    ggplot2::scale_x_date(date_breaks = "years", labels = lubridate::year) + 
    hhskthema()
  
  if (plot_loess) {
    grafiek <- grafiek + 
    ggplot2::geom_smooth(se = TRUE, col = hhskgroen, linetype = "dashed", fill = hhskblauw, alpha = 0.08, fullrange = TRUE)
    }
  
  grafiek
  
}# end of function


# titelpagina_internet ----------------------------------------------------

#' Titelpagina voor de grafieken op internet
#'
#' Creeert een titelpagina voor grafieken zoals deze worden geproduceerd met [grafiek_basis]. Dient gebruikt te worden binnen een graphic device (bijvoorbeeld `pdf()`).
#'
#' @param inclusief_normen logical Bepaald of de lijnen met normen op de titelpagina worden weergegeven. Default is `TRUE`
#'
#' @import grid
#'
#' @return Een titelpagina voor de grafieken
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' pdf("mijntest.pdf", width = 16, height = 8)
#' titelpagina_internet()
#' print(basisgrafiek)
#' dev.off()
#' }
titelpagina_internet <- function(inclusief_normen = TRUE){

  # Plaatjes ----
  grid.raster(image = logo, x = 0.05, y = 0.87, width =0.3, just = "left")
  grid.raster(image = schonevoeten, x = 0.5, y = 0.08, width = 0.2)
  
  # Intro ----
  grid.text("Dit document bevat grafieken van de chemische metingen van een meetpunt in het beheergebied van HHSK. \nIn de grafieken zijn de metingen van de afgelopen  10 jaar opgenomen, mits er voldoende metingen beschikbaar waren.\n\nLegenda bij de grafieken:",
            x = 0.1, y = 0.75, just = c("left","top"), gp = gpar())
  
  # Meetwaarden ----
  grid.lines(x = c(0.1,0.2),y = c(0.6,0.6), gp = gpar(lty = 1, col = hhskblauw, lwd = 2))
  grid.points(x = unit(c(0.125, 0.15, 0.175),"npc"), y = unit(c(0.6,0.6, 0.6),"npc"), gp = gpar(col = hhskblauw), pch = 20, size = unit(10, "pt"))
  grid.text("Meetwaarden", x = 0.22, y = 0.6, just = "left")
  
  # Meetwaarden onder rapportagegrens ----
  grid.lines(x = c(0.1,0.2),y = c(0.55,0.55), gp = gpar(lty = 1, col = hhskblauw, lwd = 2))
  grid.points(x = unit(c(0.125, 0.15, 0.175),"npc"), y = unit(c(0.55,0.55, 0.55),"npc"), gp = gpar(col = hhskblauw, fill = "white"), pch = 21, size = unit(8, "pt"))
  grid.text("Meetwaarde onder rapportagegrens", x = 0.22, y = 0.55, just = "left")
  
  # Trendlijn ----
  grid.lines(x = c(0.1,0.2),y = c(0.49,0.49), gp = gpar(lty = 2, col = hhskgroen, lwd = 3))
  grid.polygon(x = c(0.1,0.2,0.2,0.1), y = c(0.47,0.47,0.51,0.51), gp = gpar(fill =hhskblauw, alpha = 0.08))
  grid.text("Trendlijn d.m.v. locale regressie (LOESS). De blauwe band geeft de onzekerheid van de trendlijn weer.\nN.B. De trendlijn geeft het algemene verloop van de getoonde periode weer. De trendlijn heeft geen voorspellende waarde.", x = 0.22, y = 0.49, just = c("left"))
  #grid.text("N.B. De trendlijn geeft het algemene verloop van de getoonde periode weer.De trendlijn heeft geen voorspellende waarde.", x = 0.22, y = 0.47, just = c("left"))
  
  # Normen ----
  if (inclusief_normen) {
  
  grid.text(x = 0.1, y = 0.40, just = "left", "Normering gewasbeschermingsmiddelen  -  Bron: www.rivm.nl/rvs")
  
  # MAC-norm ----
  grid.lines(x = c(0.1,0.2),y = c(0.36,0.36), gp = gpar(lty = 1, col = "red", lwd = 2, alpha =0.5))
  grid.text("Normwaarde - Maximaal aanvaardbare concentratie", x = 0.22, y = 0.36, just = c("left"))
  
  # P90 norm ----
  grid.lines(x = c(0.1,0.2),y = c(0.32,0.32), gp = gpar(lty = 5, col = "red", lwd = 2, alpha =0.5))
  grid.text("Normwaarde - 90-percentielwaarde", x = 0.22, y = 0.32, just = c("left"))
  
  # JGM norm ----
  grid.lines(x = c(0.1,0.2),y = c(0.28,0.28), gp = gpar(lty = 2, col = "red", lwd = 2, alpha =0.5))
  grid.text("Normwaarde - Jaargemiddelde waarde", x = 0.22, y = 0.28, just = c("left"))
  
  
  grid.text("N.B. Soms valt de normwaarde buiten het bereik van de grafiek of is er geen normwaarde beschikbaar.", x = 0.1, y = 0.24, just = c("left"))
  }
}



