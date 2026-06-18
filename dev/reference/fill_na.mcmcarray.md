# Fill Missing Values

Fills all of an object's missing values while preserving the object's
dimensionality and class.

## Usage

``` r
# S3 method for class 'mcmcarray'
fill_na(x, value = 0, ...)
```

## Arguments

- x:

  An object.

- value:

  A scalar of the value to replace values with.

- ...:

  Other arguments passed to methods.

## Value

The modified object.

## Details

It should only be defined for objects with values of consistent class ie
not standard data.frames.

## Methods (by class)

- `fill_na(logical)`: Fill Missing Values for logical Objects

- `fill_na(integer)`: Fill Missing Values for integer Objects

- `fill_na(numeric)`: Fill Missing Values for numeric Objects

- `fill_na(character)`: Fill Missing Values for character Objects

## See also

Other fill:
[`fill_all()`](https://poissonconsulting.github.io/extras/reference/fill_all.html)

## Examples

``` r
# logical
fill_na(c(TRUE, NA))
#> [1]  TRUE FALSE

# integer
fill_na(c(1L, NA), 0)
#> [1] 1 0

# numeric
fill_na(c(1, NA), Inf)
#> [1]   1 Inf

# character
fill_na(c("text", NA))
#> [1] "text" "0"   
fill_na(matrix(c("text", NA)), value = Inf)
#>      [,1]  
#> [1,] "text"
#> [2,] "Inf" 
```
