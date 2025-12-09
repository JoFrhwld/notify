#' Notify
#'
#' Use `notify()` to insert interactive logging into
#' a sequence of functions chained by a base pipe (`|>`).
#' Does not work with magrittr `%>%`.
#'
#' @param expr The input expression
#' @param msg The logging message. If none is provided,
#' it will try to provide a reasonable message.
#'
#' @returns
#' The evaluated `expr`
#'
#' @examples
#' mtcars |>
#'   notify("Using mtcars") |>
#'   cov() |>
#'   notify("Got full covariance matrix") |>
#'   colMeans() |>
#'   notify("Calculated column means")
#'
#' # without explicit messages
#' mtcars |>
#'   notify() |>
#'   cov() |>
#'   notify() |>
#'   colMeans() |>
#'   notify()
#'
#' @export
notify <- function(expr, msg){
  if(rlang::is_missing(msg)){
    input <- rlang::enquo(expr)
    if (rlang::is_call_simple(input)){
      msg = glue::glue("{rlang::call_name(input)} finished")
    } else {
      msg = rlang::expr_name(input)
    }
  }
  on.exit(cli::cli_inform(c("*" = msg), after = T))
  if (!rlang::is_missing(expr)) {
    return(expr)
  }
}
