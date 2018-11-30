#KNMI functies

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
#' @param knmistation Het nummer van het KNMI-station. Via de website zijn de nummers te vinden of via de 
#' functie \code{toon_knmi_stations}.
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
  
  url <- paste0("https://cdn.knmi.nl/knmi/map/page/klimatologie/gegevens/daggegevens/etmgeg_",knmistation,".zip")
  bestandsnaam <- paste0("etmgeg_",knmistation,".txt")
  
  temp <- tempfile()
  utils::download.file(url,temp)
  data <- readr::read_csv(unz(temp, bestandsnaam), skip = 47, trim_ws = TRUE, col_types = readr::cols(.default = readr::col_number(), YYYYMMDD = readr::col_date(format = "%Y%m%d")))
  unlink(temp)
  
  data <- data %>% dplyr::mutate_if(is.numeric, funs(ifelse(. == -1,0,.))) # vervang in alle numerieke kolommen -1 voor 0 anders waarde behouden
  
  naam_station <- dplyr::filter(knmi_stations, knmi_station == knmistation) %>% dplyr::select(knmi_station_naam) %>% as.character()
  
  print(paste("Gegevens van KNMI-station", naam_station))
  
  data
}

#' Opschonen knmi data
#'
#' Deze functie schoont de KNMI-data die worden verkregen met [knmi_dag_ruw()] op en geeft ze 
#' begrijpelijke Nederlandse namen
#'
#' @param ruwe_data Een dataframe met ruwe knmi dag data zoals gecreeerd door [knmi_dag_ruw()]
#'
#' @return Een dataframe met begrijpelijke Nederlandse namen en logische eenheden
#' @export
#'
#' @section Eenheden:
#' 
#' - Windsnelheden zijn gemeten in m/s
#' - Temperatuur is gemeten in graden Celsius
#' - Straling is gemeten in J/cm2
#' - Neerslag is gemeten is gemeten in mm
#' - Luchtdruk is gemeten in hPa
#' - Vochtigheid is gemeten in relatieve luchtvochtigheid
#' - Verdamping is gemeten in mm
#' 
#' @examples
#' \dontrun{
#' 
#' knmi_dag_ruw() %>% opschonen_knmi()
#' }
opschonen_knmi <- function(ruwe_data){
  
  ruwe_data %>% 
    dplyr::transmute(
      datum = YYYYMMDD,
      wind_gem_vector = DDVEC,
      wind_gem_snelheid_vector = FHVEC / 10,
      wind_gem_snelheid = FG / 10,
      wind_max_snelheid = FHX / 10,
      wind_max_uur = FHXH,
      wind_min_snelheid = FHN / 10,
      wind_min_uur = FHNH,
      windstoot_max = FXX / 10,
      windstoot_uur = FXXH,
      temp_gem = TG / 10,
      temp_min = TN / 10,
      temp_min_uur = TNH,
      temp_max = TX / 10,
      temp_max_uur = TXH,
      temp_min_10cm = T10N / 10,
      temp_min_10cm_tijdvak = T10NH,
      zonneschijn = SQ / 10,
      zonneschijn_perc = SP,
      straling = Q,
      neerslag_duur = DR / 10,
      neerslag_som = RH / 10,
      neerslag_max_uursom = RHX / 10,
      neerslag_max_uur = RHXH,
      luchtdruk_gem = PG / 10,
      luchtdruk_max = PX / 10,
      luchtdruk_max_uur = PXH,
      luchtdruk_min = PN / 10,
      luchtdruk_min_uur = PNH,
      bewolkingsgraad = if_else(NG == 9, 1, NG / 8),
      vochtigheid_gem = UG,
      vochtigheid_max = UX,
      vochtigheid_max_uur = UXH,
      vochtigheid_min = UN,
      vochtigheid_min_uur = UNH,
      verdamping = EV24 / 10
    )
}

#' KNMI-gegevens van neerslag, zonneschijn, straling en temperatuur
#' 
#' Deze functie haalt de gegevens op, van een specifiek KNMI-station. De functie maakt gebruik van \code{knmi_dag_ruw}.
#' Voor meer toelichting kan die functie worden geraadpleegd. 
#'
#'
#'
#' @return Een dataframe met een kolom datum en neerslag in mm
#' 
#' @inheritParams knmi_dag_ruw
#' 
#' @export
#' 
#' @import dplyr
#' @import tidyr
#'
#' @describeIn knmi_neerslag_dag Neerslag per dag in mm
#'
#' @examples
#' 
#' \dontrun{
#' neerslag_data <- knmi_neerslag_dag()
#' neerslag_data <- knmi_neerslag_dag(310)
#' 
#' temperatuur_data <- knmi_temperatuur_dag()
#' 
#' zonuren_data <- knmi_zonuren_dag()
#' 
#' straling_data <- knmi_straling_dag()
#' 
#' }
knmi_neerslag_dag <- function(knmistation="344"){
  
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,RH) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(RH = RH/10) %>%
    dplyr::rename(datum = YYYYMMDD, neerslag_in_mm = RH)
  
  data
  
}

#' @describeIn knmi_neerslag_dag Gemiddelde temperatuur in oC per dag
#' @export
knmi_temperatuur_dag <- function(knmistation="344"){
  # in graden Celsius
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,TG) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(TG = TG/10) %>%
    dplyr::rename(datum = YYYYMMDD, gem_temp = TG)
  
  data
}

#' @describeIn knmi_neerslag_dag Zonuren en relatieve zonuren per dag
#' @export
knmi_zonuren_dag <- function(knmistation="344"){
  
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,SQ,SP) %>%
    tidyr::drop_na() %>%
    dplyr::mutate(SQ = SQ/10) %>%
    dplyr::rename(datum = YYYYMMDD, zon_uren = SQ, rel_zon_uren = SP)
  
  data
}

#' @describeIn knmi_neerslag_dag Totale straling per dag in J/cm2
#' @export
knmi_straling_dag <- function(knmistation="344"){
  #straling in J/cm2
  data <- knmi_dag_ruw(knmistation) %>%
    dplyr::select(YYYYMMDD,Q) %>%
    tidyr::drop_na() %>%
    dplyr::rename(datum = YYYYMMDD, straling = Q)
  
  data
}

#' Toon KNMI-stations op kaart
#'
#' De functie maakt een interactieve leafletkaart van alle KNMI-station met labels
#'
#' @return Een intractieve leaflet kaart met KNMI-stations
#'
#' @import leaflet
#' @import dplyr
#' 
#' @export
#'
#' @examples
#' 
#' toon_knmi_stations()
#' 
toon_knmi_stations <- function(){
  knmi_stations_label <- JT::knmi_stations %>% dplyr::mutate(label = paste(knmi_station, knmi_station_naam))
  leaflet::leaflet(knmi_stations_label) %>% leaflet::addTiles() %>% leaflet::addCircleMarkers(label = ~label)
  
}

