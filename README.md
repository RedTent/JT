[![Build Status](https://travis-ci.org/RedTent/JT.svg?branch=master)](https://travis-ci.org/RedTent/JT)

# Package JT ![](data-raw/images/JTIP.png)

Bevat uiteenlopende functies voor gebruik door JT

## Dataframe Utilities

* `add_jaar_maand()` - voeg kolommen met jaar en/of maand toe aan een dataframe
* `add_jaar()`
* `add_maand()`

* `add_lat_long` - voeg kolommen met longitude en latitude toe o.b.v. RD-coordinaten

* `opzoeken_waarde()` - zoek een waarde op in een dataframe op basis van een key

* `randomize()` - verandert de rijen van een dataframe in willekeurige volgorde

* `my_c()` - de standaard `c()`-functie met aangepaste defaults

## Importfuncties

*DAWACO*

* `import_fys_chem()` - importeren fysisch-chemische data 
* `import_meetpunten()` - importeren van meetpunten 
* `import_parameters()` - importeren van parameters 
* `import_biologie()` - importeren van biologische waarnemingen 
* `import_biologie_stadia()` - importeren van biologische waarnemingen op stadium-niveau 
* `import_biologische_kenmerken()` - importeren van biologische monsterkenmerken

*RIVM*

* `import_normen_rivm()` - importeren van RIVM-normen zoals te downloaden van [RIVM Risico's van stoffen](https://rvszoeksysteem.rivm.nl/)

## Data-verwerking

* `toetsing_gbm()` - Toets de metingen van gewasbeschermingsmiddelen

## Grafieken

*Grafieken plotten*

* `grafiek_basis()` - ggplot-tijdreeksgrafiek van 1 meetpunt en parameter
* `boxplot_basis()` - ggplot-boxplots per jaar van 1 meetpunt en parameter
* `norm_lijnen()` - een object met normlijnen dat aan grafieken kan worden toegevoegd
* `add_norm_lijnen()` - voegt normlijnen toe aan een bestaande grafiek
* `titelpagina_internet()` - Titelpagina voor de grafieken op internet
* `grafieken_internet()` - Maakt van elke meetpunt een pdf met per parameter een grafiek

* `hhskthema()` - thema met HHSK kleuren voor ggplot

*Hulpobjecten*

* `hhskblauw` - Hexadecimale waarde voor HHSK-blauw
* `hhskgroen` - Hexadecimale waarde voor HHSK-groen
* `logo` - Het logo van HHSK 
* `schonevoeten` - Footer van HHSK met motto van HHSK en website

## Circle-packing

* `stat_packcircles()` - Stat voor ggplot om circlepacks te maken
* `StatPackCircles`

* `stat_packcircles_label()` - Stat voor ggplot om labels aan circlepacks toe te voegen
* `StatPackCirclesLabel`

## KNMI-dagwaarden

* `knmi_stations       ` - dataframe met locaties van KNMI-stations
* `toon_knmi_stations()` - weergave van KNMI-stations op leaflet-map

* `knmi_dag_ruw()      ` - Alle dagwaarden van een KNMI-station
* `knmi_neerslag_dag()` - Dagelijkse neerslagwaarden
* `knmi_temperatuur_dag()` - Dagelijkse temperatuurwaarden
* `knmi_zonneschijn_dag()` - Dagelijkse zonneschijnwaarden
* `knmi_straling_dag()` - Dagelijkse stralingswaarden