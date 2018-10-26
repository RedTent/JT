# Jaar en maand -----------------------------------------------------------

#' Jaar en maand toevoegen
#' 
#' Voeg kolommen toe met het jaar en/of de maand op basis van de datum. De datumkolom moet een datumformaat hebben.
#'
#' @param dataframe Een dataframe waar de kolommen aan toegevoegd moeten worden.
#' @param datum Een character-string met naam van de datum kolom. Default is \code{"datum"}
#'
#' @return De dataframe met een extra kolom \code{jaar} en/of \code{maand}. Beide kolommen zijn integers.
#' 
#' @importFrom lubridate year month
#' 
#' @export
#'
#' @describeIn add_jaar_maand Voeg twee kolommen toe met het jaar en de maand.
#'
#' @examples
#' 
#' \dontrun{
#' 
#' data %>% add_jaar_maand()
#' 
#' data %>% add_jaar()
#' 
#' data %>% add_maand()
#' }
add_jaar_maand <- function(dataframe, datum = "datum"){

  dataframe$jaar <- as.integer(lubridate::year(dataframe[[datum]]))
  dataframe$maand <- as.integer(lubridate::month(dataframe[[datum]]))
  dataframe

}

#' @describeIn add_jaar_maand Voeg een kolom toe met het jaar.
#' @export
add_jaar <- function(dataframe, datum = "datum"){
  
  dataframe$jaar <- as.integer(lubridate::year(dataframe[[datum]]))
  dataframe
  
}

#' @describeIn add_jaar_maand Voeg een kolom toe met de maand.
#' @export
add_maand <- function(dataframe, datum = "datum"){
  
  dataframe$maand <- as.integer(lubridate::month(dataframe[[datum]]))
  dataframe
  
}

#' Toevoegen van de maandnaam
#' 
#' Deze functie voegt de Nederlandse naam van een maand toe aan een dataframe op basis van de datum
#'
#' @param dataframe Dataframe waar een kolom maandnaam aan wordt toegevoegd
#' @param datum Character met de naam van de datum kolom. De default is `"datum"`
#' @param titlecase Logical. Maandnamen met hoofdletter of niet
#'
#' @return Een dataframe met de nieuwe kolom `maandnaam`
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' dataframe <- add_maandnaam(dataframe_orig)
#' dataframe %>% add_maandnaam()
#' dataframe %>% add_maandnaam(datum = "mijn_datumkolom", titlecase = FALSE)
#' }
add_maandnaam <- function(dataframe, datum = "datum", titlecase = TRUE){
  index_kol <- 2 + as.integer(titlecase)
  index_row <- lubridate::month(dataframe[[datum]])
  dataframe$maandnaam <- as.data.frame(JT::maand_namen)[index_row, index_kol]
  dataframe
  
}

# Opzoektabel -------------------------------------------------------------


#' Zoek een waarde op in een opzoektabel
#' 
#' Deze functie kan waarden opzoeken in een tabel. Het is het alternatief voor een hash table, die R helaas niet heeft.
#'
#' @param df Een dataframe die functioneert als opzoektabel
#' @param sleutel De sleutelwaarde, selecteert de rij
#' @param attribuut De kolom(index) waar de op te halen waarde staat
#' @param sleutelkolom Optioneel - de kolom(index) als character of integer. 
#' Standaard staat de eerste kolom als sleutelkolom ingesteld
#'
#' @return De waarde die te vinden is op de betreffende rij of kolom
#' @export
#' 
#' @import dplyr
#'
#' @examples
#' \dontrun{
#' 
#' meetpuntomschrijving <- ophalen_waarde(meetpuntendf, sleutel = "00016", attribuut = "mpomsch")
#' 
#' }
opzoeken_waarde <- function(df, sleutel, attribuut, sleutelkolom = 1){
  df[df[[sleutelkolom]] == sleutel, attribuut] %>% 
    c(use.names = FALSE, recursive = TRUE)
}


# Randomize ---------------------------------------------------------------


#' Randomize
#' 
#' Verandert de rijen in willekeurige volgorde
#'
#' @param data Een dataframe
#'
#' @return Hetzelfde dataframe als de input in willekeurige volgorde
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' randomize(mtcars)
#' }
randomize <- function(data){data[sample(nrow(data)),]}


# Latitude en longitude ---------------------------------------------------

#' Toevoegen van latidute en longitude
#' 
#' De functie voegt de latitude en longitude (WGS84) toe aan een dataframe op basis van RD-coordinaten
#'
#' @param data Dataframe waar latitude en longitude aan toegevoegd worden
#' @param x_coord Character. Kolomnaam van de x-coordinaat in RD-stelsel (EPSG:28992). Default is \code{"x"}
#' @param y_coord Character. Kolomnaam van de y-coordinaat in RD-stelsel (EPSG:28992). Default is \code{"y"}
#'
#' @return Het input dataframe met een kolom \code{long} en \code{lat} toegevoegd.
#' 
#' @export
#'
#' @examples
#' \dontrun{
#' 
#' meetpunten %>% add_lat_long(x_coord = "x", y_coord = "y")
#' }
#' 
add_lat_long <- function(data, x_coord = "x", y_coord = "y"){
  
  longlat <- 
    data %>% 
    dplyr::mutate(long = .[[x_coord]], lat = .[[y_coord]]) %>% 
    dplyr::filter(long != 0, long != 0)
  
  sp::coordinates(longlat) = ~long+lat
  sp::proj4string(longlat) <- sp::CRS("+init=EPSG:28992")
  longlat <- sp::spTransform(longlat,"+init=EPSG:4326")
  
  added_lat_long <- dplyr::left_join(data, select(dplyr::as_data_frame(longlat), mp, long, lat), by = "mp")
  
  added_lat_long
  
}
  
  
  