# my_c  - a clean_vector ####
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
my_c <- function(vector){
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
  values <- dplyr::select(df, items) %>% my_c()
  names(values) <- dplyr::select(df, names) %>% my_c()
  values
}




#   #####

#   #####

#   #####

#   #####



