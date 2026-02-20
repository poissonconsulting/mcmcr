# Convert to an mcmcr object

Converts an MCMC object to an
[`mcmcr-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md).

## Usage

``` r
as.mcmcr(x, ...)

# S3 method for class 'mcarray'
as.mcmcr(x, name = "par", ...)

# S3 method for class 'mcmcarray'
as.mcmcr(x, name = "par", ...)

# S3 method for class 'nlist'
as.mcmcr(x, ...)

# S3 method for class 'nlists'
as.mcmcr(x, ...)

# S3 method for class 'mcmc'
as.mcmcr(x, ...)

# S3 method for class 'mcmc.list'
as.mcmcr(x, ...)

# S3 method for class 'mcmcrs'
as.mcmcr(x, ...)
```

## Arguments

- x:

  An MCMC object.

- ...:

  Unused.

- name:

  A string specifying the parameter name.

## Value

An mcmcr object.

## Methods (by class)

- `as.mcmcr(mcarray)`: Convert an mcarray object to an mcmcr object

- `as.mcmcr(mcmcarray)`: Convert an
  [`mcmcarray-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md)
  to an mcmcr object

- `as.mcmcr(nlist)`: Convert an
  [`nlist::nlist-object()`](https://rdrr.io/pkg/nlist/man/nlist.html) to
  an mcmcr object

- `as.mcmcr(nlists)`: Convert an
  [`nlist::nlists-object()`](https://rdrr.io/pkg/nlist/man/nlists.html)
  to an mcmcr object

- `as.mcmcr(mcmc)`: Convert an
  [`coda::mcmc()`](https://rdrr.io/pkg/coda/man/mcmc.html) object to an
  mcmcr object

- `as.mcmcr(mcmc.list)`: Convert an
  [`coda::mcmc.list()`](https://rdrr.io/pkg/coda/man/mcmc.list.html)
  object to an mcmcr object

- `as.mcmcr(mcmcrs)`: Convert tan
  [`mcmcrs-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md)
  to an mcmcr object

## See also

Other coerce:
[`as.mcarray()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcarray.md),
[`as.mcmcarray()`](https://poissonconsulting.github.io/mcmcr/reference/as.mcmcarray.md),
[`mcmcrs()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs.md)

## Examples

``` r
mcmc.list <- coda::as.mcmc.list(mcmcr::mcmcr_example)
as.mcmcr(mcmc.list)
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
```
