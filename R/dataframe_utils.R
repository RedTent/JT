#' Jaar en maand toevoegen
#' 
#' Voeg kolommen toe met het jaar en/of de maand op basis van de datum.
#'
#' @param dataframe Een dataframe waar de kolommen aan toegevoegd moeten worden.
#' @param datum Een characterstring met naam van de datum kolom. Default is \code{"datum"}
#'
#' @return De dataframe met een extra kolom \code{jaar} en/of \code{maand}. Beide kolommen zijn integers
#' 
#' @import lubridate
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
#' }
add_jaar_maand <- function(dataframe, datum="datum"){

  dataframe$jaar <- as.integer(year(dataframe[[datum]]))
  dataframe$maand <- as.integer(month(dataframe[[datum]]))
  dataframe

}

#' @describeIn add_jaar_maand Voeg een kolom toe met het jaar.
#' @export
add_jaar <- function(dataframe, datum="datum"){
  
  dataframe$jaar <- as.integer(year(dataframe[[datum]]))
  dataframe
  
}

#' @describeIn add_jaar_maand Voeg een kolom toe met de maand.
#' @export
add_maand <- function(dataframe, datum="datum"){
  
  dataframe$maand <- as.integer(month(dataframe[[datum]]))
  dataframe
  
}

