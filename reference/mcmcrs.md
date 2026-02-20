# Create mcmcrs

Creates an
[`mcmcrs-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md)
from multiple `link{mcmcr-object}`s.

## Usage

``` r
mcmcrs(...)
```

## Arguments

- ...:

  Objects of class mcmcr.

## Value

An object of class mcmcrs

## See also

Other coerce:
[`as.mcarray()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcarray.md),
[`as.mcmcarray()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcmcarray.md),
[`as.mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcmcr.md)

## Examples

``` r
mcmcrs(mcmcr_example, mcmcr_example)
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
#> $mcmcr2
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
