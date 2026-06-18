# Number of Parameters

Gets the number of parameters of an object.

The default methods returns the length of
[`pars()`](https://poissonconsulting.github.io/universals/reference/pars.html)
if none are `NA`, otherwise it returns `NA`.

## Usage

``` r
# S3 method for class 'mcmcr'
npars(x, scalar = NULL, ...)
```

## Arguments

- x:

  An object.

- scalar:

  A logical scalar specifying whether to include all parameters (NULL),
  only scalars (TRUE) or all parameters except scalars (FALSE).

- ...:

  Other arguments passed to methods.

## Value

An integer scalar of the number of parameters.

## See also

[`pars()`](https://poissonconsulting.github.io/universals/reference/pars.html)

Other MCMC dimensions:
[`nchains()`](https://poissonconsulting.github.io/universals/reference/nchains.html),
[`niters()`](https://poissonconsulting.github.io/universals/reference/niters.html),
[`nsams()`](https://poissonconsulting.github.io/universals/reference/nsams.html),
[`nsims()`](https://poissonconsulting.github.io/universals/reference/nsims.html),
[`nterms()`](https://poissonconsulting.github.io/universals/reference/nterms.html)

Other parameters:
[`pars()`](https://poissonconsulting.github.io/universals/reference/pars.html),
[`set_pars()`](https://poissonconsulting.github.io/universals/reference/set_pars.html)
