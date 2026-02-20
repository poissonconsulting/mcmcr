# Check MCMC objects

Checks class and structure of MCMC objects.

`chk_mcmcarray` checks if
[`mcmcarray-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcarray-object.md)
object using

`is.array(x) && is.numeric(x)`

`chk_mcmcr` checks if an
[`mcmcr-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcr-object.md).

`chk_mcmcrs` checks if an
[`mcmcrs-object()`](https://poissonconsulting.github.io/mcmcr/reference/mcmcrs-object.md).

## Usage

``` r
chk_mcmcarray(x, x_name = NULL)

chk_mcmcr(x, x_name = NULL)

chk_mcmcrs(x, x_name = NULL)
```

## Arguments

- x:

  The object to check.

- x_name:

  A string of the name of object x or NULL.

## Value

`NULL`, invisibly. Called for the side effect of throwing an error if
the condition is not met.

## Details

To just check class use
[`chk::chk_s3_class()`](https://poissonconsulting.github.io/chk/reference/chk_s3_class.html).

## Functions

- `chk_mcmcarray()`: Check mcmcarray Object

- `chk_mcmcr()`: Check mcmcr Object

- `chk_mcmcrs()`: Check mcmcrs Object

## See also

[`vld_mcmcr()`](https://poissonconsulting.github.io/mcmcr/reference/vld_mcmcr.md)

## Examples

``` r
# chk_mcmcarray
try(chk_mcmcarray(1))
#> Error in chk_mcmcarray(1) : `1` must inherit from S3 class 'mcmcarray'.

# chk_mcmcr
chk_mcmcr(as.mcmcr(list(x = 1)))
try(chk_mcmcr(1))
#> Error in chk_mcmcr(1) : `1` must inherit from S3 class 'mcmcr'.

# chk_mcmcrs
chk_mcmcrs(as.mcmcrs(as.mcmcr(list(x = 1))))
try(chk_mcmcrs(1))
#> Error in chk_mcmcrs(1) : `1` must inherit from S3 class 'mcmcrs'.
```
