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
add_jaar_maand <- function(dataframe, datum="datum"){

  dataframe$jaar <- as.integer(lubridate::year(dataframe[[datum]]))
  dataframe$maand <- as.integer(lubridate::month(dataframe[[datum]]))
  dataframe

}

#' @describeIn add_jaar_maand Voeg een kolom toe met het jaar.
#' @export
add_jaar <- function(dataframe, datum="datum"){
  
  dataframe$jaar <- as.integer(lubridate::year(dataframe[[datum]]))
  dataframe
  
}

#' @describeIn add_jaar_maand Voeg een kolom toe met de maand.
#' @export
add_maand <- function(dataframe, datum="datum"){
  
  dataframe$maand <- as.integer(lubridate::month(dataframe[[datum]]))
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