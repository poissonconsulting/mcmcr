# Parameter descriptions

Parameter descriptions

## Arguments

- x:

  An object.

- scalar:

  A logical scalar specifying whether to include all parameters (NULL),
  only scalars (TRUE) or all parameters except scalars (FALSE).

- terms:

  A logical scalar specifying whether to provide the parameters for each
  term.

- nas:

  A flag specifying whether to also fill missing values.

- nthin:

  A positive integer of the thinning rate.

- by:

  A string indicating whether to determine by "term", "parameter" or
  "all".

- as_df:

  A flag indicating whether to return the results as a data frame versus
  a named list.

- fun:

  A function that given a numeric vector returns a numeric scalar.

- bound:

  flag specifying whether to bind mcmcrs objects by their chains before
  calculating rhat.

- rhat:

  The maximum rhat value.

- esr:

  The minimum effective sampling rate.

- na_rm:

  A flag specifying whether to ignore missing values.

- parameters:

  A character vector (or NULL) of the parameters to subset by.

- iterations:

  An integer vector (or NULL) of the iterations to subset by.

- ...:

  Unused.

- x2:

  a second MCMC object.

- x_name:

  A string of the name of the object.

- error:

  A flag indicating whether to throw an informative error or immediately
  generate an informative message if the check fails.

- sorted:

  A flag specifying whether the parameters must be sorted.

- object:

  The MCMC object to get the coefficients for

- conf_level:

  A number specifying the confidence level. By default 0.95.

- estimate:

  The function to use to calculate the estimate.

- simplify:

  A flag specifying whether to return just the estimate, lower, upper
  and svalue.

- perm:

  A integer vector of the new order for the parameter dimensions.

- pars:

  A character vector (or NULL) of the pars to zero.

- name:

  A string specifying the parameter name.
