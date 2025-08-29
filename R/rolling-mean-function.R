##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##                                                                            --
##---------------- THIS SCRIPT CREATES MY 9 WEEK ROLLING MEAN-------------------
##                                                                            --
##~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#' Nine Week Rolling Mean 
#'
#' @param df The data frame used in the function
#'
#' @returns
#' @export
#'
#' @examples
#' rolling_mean(df)
#'
#' 
rolling_mean <- function(df){
  df %>%
  arrange(sample_date) %>% # need to sort in chronological order 
  na.omit() %>% 
  group_by(sample_id, nutrient) %>% # create means for each nutrient at each site
  mutate(roll_mean = slide_index_dbl(concentration, sample_date, # use rolling mean function
                                     .f = mean, na_rm = TRUE,
                                     .before = 31.5, .after = 31.5, #31 days before and after for 9 week span
                                     complete = FALSE))
}