#' Stat - Packcircles
#' 
#' Met deze stat kan op basis van kwantitatieve waarden een circle-pack worden gemaakt.
#'
#' @param mapping The mapping of aesthetics to use for this stat. Inherits from \code{ggplot()}
#' @param data The data to use for this stat. Inherits from \code{ggplot()}
#' @param geom The geom to use. Defaults to polygon
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param na.rm If \code{FALSE}, the default, missing values are removed with a warning. 
#' If \code{TRUE}, missing values are silently removed.
#' @param show.legend logical. Should this layer be included in the legends? \code{NA}, the default, 
#' includes if any aesthetics are mapped. \code{FALSE} never includes, and \code{TRUE} always includes. 
#' It can also be a named logical vector to finely select the aesthetics to display.
#' @param inherit.aes If \code{FALSE}, overrides the default aesthetics, rather than combining with them. 
#' This is most useful for helper functions that define both data and aesthetics and shouldn't inherit 
#' behaviour from the default plot specification, e.g. \code{borders()}.
#' @param ... Other parameters to pass 
#'
#' @return Returns a layer with packed circles.
#' @export
#' 
#'
#' @examples
#' \dontrun{
#'  
#' ggplot(data, aes(y = mpg)) + stat_packcircles()
#' }
#' 
stat_packcircles <- function(mapping = NULL, data = NULL, geom = "polygon",
                             position = "identity", na.rm = FALSE, show.legend = NA, 
                             inherit.aes = TRUE, ...) {
  
  ggplot2::layer(
    stat = StatPackCircles, data = data, mapping = mapping, geom = geom, 
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' StatPackCircles
#' @export
StatPackCircles <- ggplot2::ggproto("StatPackCircles", ggplot2::Stat,
                           
                           compute_layer = function(data, scales, ...){
                             data$id <- row(data)[,1]
                             circles <- packcircles::circleLayoutVertices(packcircles::circleProgressiveLayout(data$y), 
                                                                          npoints = 100)
                             data$y <- NULL
                             data$group <- NULL
                             data <- merge(circles, data, by = "id", sort = FALSE)
                             names(data)[names(data) == "id"] <- "group"
                             data
                           },
                           
                           required_aes = c("y")
)


#' Stat - Packcircles Label
#' 
#' Met deze stat kunnen aan een circle-pack labels worden toegevoegd aan het centrum. See \code{pack_circles}
#'
#' @param mapping The mapping of aesthetics to use for this stat. Inherits from \code{ggplot()}
#' @param data The data to use for this stat. Inherits from \code{ggplot()}
#' @param geom The geom to use. Defaults to polygon
#' @param position Position adjustment, either as a string, or the result of a call to a position adjustment function.
#' @param na.rm If \code{FALSE}, the default, missing values are removed with a warning. 
#' If \code{TRUE}, missing values are silently removed.
#' @param show.legend logical. Should this layer be included in the legends? \code{NA}, the default, 
#' includes if any aesthetics are mapped. \code{FALSE} never includes, and \code{TRUE} always includes. 
#' It can also be a named logical vector to finely select the aesthetics to display.
#' @param inherit.aes If \code{FALSE}, overrides the default aesthetics, rather than combining with them. 
#' This is most useful for helper functions that define both data and aesthetics and shouldn't inherit 
#' behaviour from the default plot specification, e.g. \code{borders()}.
#' @param ... Other parameters to pass 
#'
#' @return Returns a layer with labels at the circle centers.
#' @export
#' 
#'
#' @examples
#' \dontrun{
#'  
#' ggplot(data, aes(y = mpg, label = name)) + stat_packcircles() + stat_packcircles_center
#' }
#' 
stat_packcircles_label <- function(mapping = NULL, data = NULL, geom = "text",
                                   position = "identity", na.rm = FALSE, show.legend = NA, 
                                   inherit.aes = TRUE, ...) {
  
  ggplot2::layer(
    stat = StatPackCirclesLabel, data = data, mapping = mapping, geom = geom, 
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}

#' StatPackCirclesLabel
#' @export
StatPackCirclesLabel <- ggplot2::ggproto("StatPackCirclesLabel", ggplot2::Stat,
                                         compute_layer = function(data, scales, ...){
                                           
                                           circle_centers <- packcircles::circleProgressiveLayout(data$y)
                                           data$y <- NULL
                                           data <- cbind(circle_centers,data)
                                           data
                                           
                                         },
                                         required_aes = c("y")
                                         
                                         
)