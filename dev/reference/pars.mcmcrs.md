# Parameter Names

Gets the parameter names.

## Usage

``` r
# S3 method for class 'mcmcrs'
pars(x, scalar = NULL, terms = FALSE, ...)
```

## Arguments

- x:

  An object.

- scalar:

  A logical scalar specifying whether to include all parameters (NULL),
  only scalars (TRUE) or all parameters except scalars (FALSE).

- terms:

  A logical scalar specifying whether to provide the parameters for each
  term.

- ...:

  Other arguments passed to methods.

## Value

A character vector of the names of the parameters.

## See also

Other parameters:
[`npars()`](https://poissonconsulting.github.io/universals/reference/npars.html),
[`set_pars()`](https://poissonconsulting.github.io/universals/reference/set_pars.html)
