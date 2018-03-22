#Kladblok
library(rgdal)
library(gdalUtils)
library(leaflet)
library(dplyr)

link <- "https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wms"
lufo <- "https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/wms"
"Actueel_ortho25"

link = "https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wfs"
#link2 = "WFS:https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wfs"
link2 = "WFS:https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wfs"
link3 <- "WFS:https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wfs?request=GetCapabilities"
ogrListLayers(link3)

ogrInfo(link3, layer = "bestuurlijkegrenzen:gemeenten")
#ogrFIDs(link2, layer = "bestuurlijkegrenzen:gemeenten")

link4 <- "https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wfs?service=WFS&request=GetFeature&typeName=bestuurlijkegrenzen:gemeenten"
ogr2ogr(link4, "TEST/grenzen2.shp", layer = "gemeenten")
test <- readOGR("TEST/grenzen2.shp")


#link4 <- "https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wfs?service=WFS&request=GetFeature&typeName=bestuurlijkegrenzen:gemeenten&outputFormat=shp"

ogrInfo(link4)
test <- readOGR(link4)
readGDAL(link)

#werkt
leaflet() %>% addWMSTiles(link, layers = "gemeenten")

#werkt
leaflet() %>% addWMSTiles(baseUrl = "https://geodata.nationaalgeoregister.nl/bestuurlijkegrenzen/wms", layers = "gemeenten",
                          options = WMSTileOptions(format = "image/png", transparent = FALSE) )



# werkt
leaflet() %>% addTiles(urlTemplate = "http://geodata.nationaalgeoregister.nl/tms/1.0.0/brtachtergrondkaart/{z}/{x}/{y}.png",
                       options = tileOptions(tms = TRUE, noWrap = TRUE))

#werkt
lufo <-  "https://geodata.nationaalgeoregister.nl/luchtfoto/rgb/tms/1.0.0/Actueel_ortho25/EPSG:28992/{z}/{x}/{y}.png"
leaflet() %>% addTiles(urlTemplate = lufo,
                       options = tileOptions(tms = TRUE, noWrap = TRUE)) #%>% addCircleMarkers(data = mpdf)


#werktn niet
leaflet() %>% addWMSTiles(baseUrl = link, layers = "Actueel_ortho25",
                          options = WMSTileOptions(format = "image/png", transparent = FALSE) )
