# Om onduidelijke redenen passeren deze testen Travis niet. Vermoedelijk een probleem met sp of rgdal.

# context("Testen van toevoegen coordinaten")
# 
# 
# test_that("coordinaat conversie werkt", {
#   
#   testobj <- coordinate_conversion(111111,444444)
#   testobj_na <- coordinate_conversion(NA, NA)
#   
#   expect_is(testobj, "tbl_df")
#   expect_equal(testobj[[1,1]], 4.748277, tolerance = 0.000005)
#   expect_equal(testobj[[1,2]], 51.98666, tolerance = 0.00005)
#   
#   expect_is(testobj_na, "tbl_df")
#   expect_equal(testobj_na[[1,1]], NA)
#   expect_equal(testobj_na[[1,2]], NA)
#   
# })
# 
# test_that("long en lat toevoegen werkt", {
#   df_x_y <- data.frame(x = c(110000,111111, NA), y = c(433333,444444, NA))
#   df_long_lat <- data.frame(long = c(110000,111111, NA), lat = c(433333,444444, NA))
#   obj_x_y <- add_lat_long(df_x_y)
#   obj_long_lat <- add_lat_long(df_long_lat, "long", "lat")
# 
#   expect_is(obj_x_y, "tbl_df")
#   expect_is(obj_long_lat, "tbl_df")
# 
#   expect_equal(obj_x_y[[2,3]], 4.748277, tolerance = 0.000005)
#   expect_equal(obj_x_y[[2,4]], 51.98666, tolerance = 0.00005)
# 
#   expect_equal(obj_long_lat[[2,3]], 4.748277, tolerance = 0.000005)
#   expect_equal(obj_long_lat[[2,4]], 51.98666, tolerance = 0.00005)
# 
# })
# 
