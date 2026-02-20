# Convert to an mcmcrs object

Converts an MCMC object to an
[`mcmcrs-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md).

## Usage

``` r
as.mcmcrs(x, ...)

# S3 method for class 'list'
as.mcmcrs(x, ...)

# S3 method for class 'mcmcr'
as.mcmcrs(x, name = "mcmcr1", ...)
```

## Arguments

- x:

  An MCMC object.

- ...:

  Unused.

- name:

  A string specifying the element name.

## Value

An mcmcrs object.

## Methods (by class)

- `as.mcmcrs(list)`: Convert a list of `[mcmcr-object]s` to an mcmcrs
  object

- `as.mcmcrs(mcmcr)`: Convert an
  [`mcmcr-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md)
  to an mcmcrs object

## Examples

``` r
as.mcmcrs(mcmcr::mcmcr_example)
#> $mcmcr1
#> $alpha
#> [1] 3.718025 4.718025
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $beta
#>           [,1]     [,2]
#> [1,] 0.9716535 1.971654
#> [2,] 1.9716535 2.971654
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> $sigma
#> [1] 0.7911975
#> 
#> nchains:  2 
#> niters:  400 
#> 
#> 
#> attr(,"class")
#> [1] "mcmcrs"
```
