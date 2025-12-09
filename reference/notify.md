# Notify

Use `notify()` to insert interactive logging into a sequence of
functions chained by a base pipe (`|>`). Does not work with magrittr
`%>%`.

## Usage

``` r
notify(expr, msg)
```

## Arguments

- expr:

  The input expression

- msg:

  The logging message. If none is provided, it will try to provide a
  reasonable message.

## Value

The evaluated `expr`

## Examples

``` r
mtcars |>
  notify("Using mtcars") |>
  cov() |>
  notify("Got full covariance matrix") |>
  colMeans() |>
  notify("Calculated column means")
#> • Using mtcars
#> • Got full covariance matrix
#> • Calculated column means
#>         mpg         cyl        disp          hp        drat          wt 
#>  -84.045124   26.736038 1960.037688 1017.051402   -5.589250   13.459061 
#>        qsec          vs          am        gear        carb 
#>  -16.266687   -6.150309   -3.933568   -4.987325   14.498501 

# without explicit messages
mtcars |>
  notify() |>
  cov() |>
  notify() |>
  colMeans() |>
  notify()
#> • ~mtcars
#> • cov finished
#> • colMeans finished
#>         mpg         cyl        disp          hp        drat          wt 
#>  -84.045124   26.736038 1960.037688 1017.051402   -5.589250   13.459061 
#>        qsec          vs          am        gear        carb 
#>  -16.266687   -6.150309   -3.933568   -4.987325   14.498501 
```
