# clean_vector ####
#' Create a single clean vector
#'
#'@description A helper function for the basic \code{c()} function to remove names and create a singular vector.
#' This can be useful if you select a single column from a dataframe.
#'
#' @param vector A vector that needs 'cleaning'
#'
#' @return Returns a single clean vector without names
#'
#' @export
#'
clean_vector <- function(vector){
  c(vector, use.names = FALSE, recursive = TRUE)
}

# df_to_named_list ####

#' Create a named list
#'
#' @description This function creates a named list from two dataframe columns
#'
#' @param df A dataframe
#' @param items A string or index number which indicates the column with the items for the named list
#' @param names A string or index number which indicates the column with the names for the named list
#'
#' @return Returns a named list
#'
#' @import dplyr
#'
#' @export
#'
df_to_named_list <- function(df, items = 1, names = 2){
  values <- dplyr::select(df, items) %>% clean_vector()
  names(values) <- dplyr::select(df, names) %>% clean_vector()
  values
}


# KNMI GEGEVENS -----------------------------------------------------------

#' KNMI Daggegevens (Rotterdam)
#'
#' De functie haalt de daggegevens van KNMI-station Rotterdam op van de website van het KNMI 
#' (\url{https://www.knmi.nl/nederland-nu/klimatologie/daggegevens}). De default is het KNMI-station Rotterdam.
#'
#' @return Een dataframe met de daggegevens van een KNMI-station (Rotterdam als default)
#' 
#' @import readr
#' @import dplyr
#' 
#' @param knmistation Het nummer van het KNMI-station. Via de website zijn de nummers te vinden
#' 
#' @export
#'
#' @section Verklaring kolommen:
#' 
#' \itemize{
#' 
#' \item YYYYMMDD  = Datum (YYYY=jaar MM=maand DD=dag) / Date (YYYY=year MM=month DD=day)
#' \item DDVEC     = Vectorgemiddelde windrichting in graden (360=noord, 90=oost, 180=zuid, 270=west, 0=windstil/variabel). Zie \url{http://www.knmi.nl/kennis-en-datacentrum/achtergrond/klimatologische-brochures-en-boeken} / Vector mean wind direction in degrees (360=north, 90=east, 180=south, 270=west, 0=calm/variable)
#' \item FHVEC     = Vectorgemiddelde windsnelheid (in 0.1 m/s). Zie \url{http://www.knmi.nl/kennis-en-datacentrum/achtergrond/klimatologische-brochures-en-boeken} / Vector mean windspeed (in 0.1 m/s)
#' \item FG        = Etmaalgemiddelde windsnelheid (in 0.1 m/s) / Daily mean windspeed (in 0.1 m/s) 
#' \item FHX       = Hoogste uurgemiddelde windsnelheid (in 0.1 m/s) / Maximum hourly mean windspeed (in 0.1 m/s)
#' \item FHXH      = Uurvak waarin FHX is gemeten / Hourly division in which FHX was measured
#' \item FHN       = Laagste uurgemiddelde windsnelheid (in 0.1 m/s) / Minimum hourly mean windspeed (in 0.1 m/s)
#' \item FHNH      = Uurvak waarin FHN is gemeten / Hourly division in which FHN was measured
#' \item FXX       = Hoogste windstoot (in 0.1 m/s) / Maximum wind gust (in 0.1 m/s)
#' \item FXXH      = Uurvak waarin FXX is gemeten / Hourly division in which FXX was measured
#' \item TG        = Etmaalgemiddelde temperatuur (in 0.1 graden Celsius) / Daily mean temperature in (0.1 degrees Celsius)
#' \item TN        = Minimum temperatuur (in 0.1 graden Celsius) / Minimum temperature (in 0.1 degrees Celsius)
#' \item TNH       = Uurvak waarin TN is gemeten / Hourly division in which TN was measured
#' \item TX        = Maximum temperatuur (in 0.1 graden Celsius) / Maximum temperature (in 0.1 degrees Celsius)
#' \item TXH       = Uurvak waarin TX is gemeten / Hourly division in which TX was measured
#' \item T10N      = Minimum temperatuur op 10 cm hoogte (in 0.1 graden Celsius) / Minimum temperature at 10 cm above surface (in 0.1 degrees Celsius)
#' \item T10NH     = 6-uurs tijdvak waarin T10N is gemeten / 6-hourly division in which T10N was measured; 6=0-6 UT, 12=6-12 UT, 18=12-18 UT, 24=18-24 UT 
#' \item SQ        = Zonneschijnduur (in 0.1 uur) berekend uit de globale straling (-1 voor <0.05 uur) / Sunshine duration (in 0.1 hour) calculated from global radiation (-1 for <0.05 hour)
#' \item SP        = Percentage van de langst mogelijke zonneschijnduur / Percentage of maximum potential sunshine duration
#' \item Q         = Globale straling (in J/cm2) / Global radiation (in J/cm2)
#' \item DR        = Duur van de neerslag (in 0.1 uur) / Precipitation duration (in 0.1 hour)
#' \item RH        = Etmaalsom van de neerslag (in 0.1 mm) (-1 voor <0.05 mm) / Daily precipitation amount (in 0.1 mm) (-1 for <0.05 mm)
#' \item RHX       = Hoogste uursom van de neerslag (in 0.1 mm) (-1 voor <0.05 mm) / Maximum hourly precipitation amount (in 0.1 mm) (-1 for <0.05 mm)
#' \item RHXH      = Uurvak waarin RHX is gemeten / Hourly division in which RHX was measured
#' \item PG        = Etmaalgemiddelde luchtdruk herleid tot zeeniveau (in 0.1 hPa) berekend uit 24 uurwaarden / Daily mean sea level pressure (in 0.1 hPa) calculated from 24 hourly values
#' \item PX        = Hoogste uurwaarde van de luchtdruk herleid tot zeeniveau (in 0.1 hPa) / Maximum hourly sea level pressure (in 0.1 hPa)
#' \item PXH       = Uurvak waarin PX is gemeten / Hourly division in which PX was measured
#' \item PN        = Laagste uurwaarde van de luchtdruk herleid tot zeeniveau (in 0.1 hPa) / Minimum hourly sea level pressure (in 0.1 hPa)
#' \item PNH       = Uurvak waarin PN is gemeten / Hourly division in which PN was measured
#' \item VVN       = Minimum opgetreden zicht / Minimum visibility; 0: <100 m, 1:100-200 m, 2:200-300 m,..., 49:4900-5000 m, 50:5-6 km, 56:6-7 km, 57:7-8 km,..., 79:29-30 km, 80:30-35 km, 81:35-40 km,..., 89: >70 km)
#' \item VVNH      = Uurvak waarin VVN is gemeten / Hourly division in which VVN was measured
#' \item VVX       = Maximum opgetreden zicht / Maximum visibility; 0: <100 m, 1:100-200 m, 2:200-300 m,..., 49:4900-5000 m, 50:5-6 km, 56:6-7 km, 57:7-8 km,..., 79:29-30 km, 80:30-35 km, 81:35-40 km,..., 89: >70 km)
#' \item VVXH      = Uurvak waarin VVX is gemeten / Hourly division in which VVX was measured
#' \item NG        = Etmaalgemiddelde bewolking (bedekkingsgraad van de bovenlucht in achtsten, 9=bovenlucht onzichtbaar) / Mean daily cloud cover (in octants, 9=sky invisible)
#' \item UG        = Etmaalgemiddelde relatieve vochtigheid (in procenten) / Daily mean relative atmospheric humidity (in percents)
#' \item UX        = Maximale relatieve vochtigheid (in procenten) / Maximum relative atmospheric humidity (in percents)
#' \item UXH       = Uurvak waarin UX is gemeten / Hourly division in which UX was measured
#' \item UN        = Minimale relatieve vochtigheid (in procenten) / Minimum relative atmospheric humidity (in percents)
#' \item UNH       = Uurvak waarin UN is gemeten / Hourly division in which UN was measured
#' \item EV24      = Referentiegewasverdamping (Makkink) (in 0.1 mm) / Potential evapotranspiration (Makkink) (in 0.1 mm)
#' 
#' }
#'
#' @examples
#' \dontrun{
#' 
#' #Rotterdam
#' ruwe_data <- knmi_dag_ruw()
#' 
#' # Vlissingen
#' ruwe_data <- knmi_dag_ruw(310)
#' 
#' }
knmi_dag_ruw <- function(knmistation = "344"){
  require(readr)
  
  url <- paste0("https://cdn.knmi.nl/knmi/map/page/klimatologie/gegevens/daggegevens/etmgeg_",knmistation,".zip")
  bestandsnaam <- paste0("etmgeg_",knmistation,".txt")
  
  temp <- tempfile()
  download.file(url,temp)
  data <- readr::read_csv(unz(temp, bestandsnaam), skip = 47, trim_ws = TRUE, col_types = cols(.default = col_number(), YYYYMMDD = col_date(format = "%Y%m%d")))
  unlink(temp)
  
  data <- data %>% dplyr::mutate_if(is.numeric, funs(ifelse(. == -1,0,.))) # vervang in alle numerieke kolommen -1 voor 0 anders waarde behouden
  
  data
}

#' Neerslaggegevens
#' 
#' Deze functie haalt de neerslaggegevens op van een specifiek KNMI-station. De functie maakt gebruik van \code{\link{knmi_dag_ruw}}.
#' Voor meer toelichting kan die functie worden geraadpleegd. 
#'
#' @return Een dataframe met twee kolommen datum en neerslag in mm
#' 
#' @inheritParams knmi_dag_ruw
#' 
#' @export
#' 
#' @import dplyr
#' @import tidyr
#'
#' @examples
knmi_neerslag_dag <- function(knmistation="344"){
  
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,RH) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(RH = RH/10) %>%
    dplyr::rename(datum = YYYYMMDD, neerslag_in_mm = RH)
  
  data
  
}

knmi_temperatuur_dag <- function(knmistation="344"){
  # in graden Celsius
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,TG) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(TG = TG/10) %>%
    dplyr::rename(datum = YYYYMMDD, gem_temp = TG)
  
  data
}

knmi_zonneschijn_dag <- function(knmistation="344"){
  
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,SQ,SP,Q) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(SQ = SQ/10) %>%
    dplyr::rename(datum = YYYYMMDD, zon_uren = SQ, rel_zon_uren = SP, straling = Q)
  
  data
}


#   #####

#   #####

#   #####

#   #####



