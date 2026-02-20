# Fill All Values

Fills all of an object's (missing and non-missing) values while
preserving the object's dimensionality and class.

## Usage

``` r
# S3 method for class 'mcmcarray'
fill_all(x, value = 0, nas = TRUE, ...)
```

## Arguments

- x:

  An object.

- value:

  A scalar of the value to replace values with.

- nas:

  A flag specifying whether to also fill missing values.

- ...:

  Other arguments passed to methods.

## Value

The modified object.

## Details

It should only be defined for objects with values of consistent class ie
not standard data.frames.

## Methods (by class)

- `fill_all(logical)`: Fill All for logical Objects

- `fill_all(integer)`: Fill All for integer Objects

- `fill_all(numeric)`: Fill All for numeric Objects

- `fill_all(character)`: Fill All for character Objects

## See also

Other fill:
[`fill_na()`](https://poissonconsulting.github.io/extras/reference/fill_na.html)

## Examples

``` r
# logical
fill_all(c(TRUE, NA, FALSE))
#> [1] FALSE FALSE FALSE
fill_all(c(TRUE, NA, FALSE, nas = FALSE))
#>                     nas 
#> FALSE FALSE FALSE FALSE 
fill_all(c(TRUE, NA, FALSE, value = NA))
#>                   value 
#> FALSE FALSE FALSE FALSE 

# integer
fill_all(matrix(1:4, nrow = 2), value = -1)
#>      [,1] [,2]
#> [1,]   -1   -1
#> [2,]   -1   -1

# numeric
fill_all(c(1, 4, NA), value = TRUE)
#> [1] 1 1 1
fill_all(c(1, 4, NA), value = TRUE, nas = FALSE)
#> [1]  1  1 NA

# character
fill_all(c("some", "words"), value = TRUE)
#> [1] "TRUE" "TRUE"
```
