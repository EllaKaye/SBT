#' Convert wins code to counts
#'
#' Convert a three-column data frame in which the third column is a code representing whether the item in column 1 won, lost or (if applicable) drew over/with the item in column 2, to a dataframe with counts (suitable for use in \code{\link{btdata}})
#' 
#' @param df A three-column data frame. Each row represents a comparison between two items. The first and second columns are the names of the first and second players respectively. The third column gives a code for who won. See examples.
#' @param code A numeric vector or character vector, of length two or three (depending on whether there are ties.) The first and second element gives the codes used if the first or second item won respectively. If there are ties, the third element gives the code used in that case. See examples.
#' @return A four-column data frame where the first two columns are the name of the first and second item. The third and fourth column gives the wins count for the first and second item respectively: 1 for a win, 0 for a loss, and 0.5 each for a draw. This data frame is in the correct format to be passed to \code{\link{btdata}}
#' @examples 
#' first <- c("A", "A", "B", "A")
#' second <- c("B", "B", "C", "C")
#' df1 <- data.frame(player1 = first, player2 = second, result = c("W1", "W2", "D", "D"))
#' code_to_counts(df1, c("W1", "W2", "D"))
#' df2 <- data.frame(item1 = first, item2 = second, code = c(1, 0, 1, .5))
#' code_to_counts(df2, c(1, 0, .5))
#' df3 <- data.frame(player1 = first, player2 = second, which_won = c(1,2,2,1))
#' code_to_counts(df3, c(1,2))
#'
#' @export
code_to_counts <- function(df, code) {
  
  # check arguments
  if (!is.data.frame(df)) stop("df must be a data frame")
  if (ncol(df) != 3) stop("df must have three columns")
  if (!(is.numeric(code) | is.character(code))) stop("code must be a numeric or character vector")
  if (!(length(code) %in% 2:3)) stop("code must be a vector of length 2 or 3")
  
  # extract code elements
  W1 <- code[1]
  W2 <- code[2]
  if (length(code) == 3) D <- code[3]
  
  # check that codes match content in column three
  code_elements <- sort(unique(df[[3]]))
  if (is.character(code)) code <- as.factor(code)
  if (!(identical(sort(code), code_elements))) stop("The elements in code don't match the elements in the third column of df")
  
  
  # make col3 name consistent, so can use in mutate statements
  colnames(df)[3] <- "wins_code"
  
  # sort the data frame
  df <- dplyr::mutate(df, item1wins = dplyr::if_else(wins_code == W1, 1, 0))
  df <- dplyr::mutate(df, item2wins = dplyr::if_else(wins_code == W2, 1, 0))  
  
  if (length(code) == 3) {
    df <- dplyr::mutate(df, item1wins = dplyr::if_else(wins_code == D, 0.5, item1wins))
    df <- dplyr::mutate(df, item2wins = dplyr::if_else(wins_code == D, 0.5, item2wins))
  }
  
  df <- dplyr::select(df, c(1:2, 4:5))
  df
}