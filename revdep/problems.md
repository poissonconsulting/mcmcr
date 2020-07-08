# mcmcderive

<details>

* Version: 0.0.1
* Source code: https://github.com/cran/mcmcderive
* URL: https://github.com/poissonconsulting/mcmcderive
* BugReports: https://github.com/poissonconsulting/mcmcderive/issues
* Date/Publication: 2019-07-02 12:30:02 UTC
* Number of recursive dependencies: 48

Run `revdep_details(,"mcmcderive")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    [1,] 0.9716535 1.971654
    [2,] 1.9716535 2.971654
    
    nchains:  2 
    niters:  400 
    
    $sigma
    [1] 0.7911975
    
    nchains:  2 
    niters:  400 
    
    > 
    > expr <- "
    +  log(alpha2) <- alpha
    +  gamma <- sum(alpha) * sigma"
    > 
    > mcmc_derive(mcmcr::mcmcr_example, expr, silent = TRUE)
    Error in parameters(object) : could not find function "parameters"
    Calls: mcmc_derive -> mcmc_derive.mcmcr -> drop_absent_parameters
    Execution halted
    ```

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      [90m 7. [39mmcmcderive:::mcmc_derive.mcmcr(...)
      [90m 8. [39mmcmcderive:::drop_overridden_parameters(object, values, silent = silent)
      
      ══ testthat results  ═══════════════════════════════════════════════════════════
      [ OK: 15 | SKIPPED: 0 | WARNINGS: 0 | FAILED: 7 ]
      1. Error: mcmc_derive (@test-mcmc-derive.R#18) 
      2. Error: mcmc_derive.mcmc.list (@test-mcmc-derive.R#40) 
      3. Error: mcmc_derive.mcmcr (@test-mcmc-derive.R#53) 
      4. Error: mcmc_derive in parallel (@test-mcmc-derive.R#79) 
      5. Error: mcmc_derive matrix in values (@test-mcmc-derive.R#102) 
      6. Failure: mcmc_derive warnings and errors (@test-mcmc-derive.R#130) 
      7. Error: mcmc_derive warnings and errors (@test-mcmc-derive.R#134) 
      
      Error: testthat unit tests failed
      Execution halted
    ```

*   checking R code for possible problems ... NOTE
    ```
    bind_iterations_mcmcarrays: no visible global function definition for
      ‘dims’
    Undefined global functions or variables:
      dims
    ```

# missingHE

<details>

* Version: 1.4.1
* Source code: https://github.com/cran/missingHE
* Date/Publication: 2020-06-25 21:40:02 UTC
* Number of recursive dependencies: 128

Run `revdep_details(,"missingHE")` for more info

</details>

## Newly broken

*   checking examples ... ERROR
    ```
    ...
    
    > ## End(Don't show)
    > 
    > # Assess model convergence using graphical tools
    > # Produce histograms of the posterior samples for the mean effects
    > diag.hist <- diagnostic(model.hurdle, type = "histogram", param = "mu.e")
    Loading required namespace: ggmcmc
    Loading required namespace: mcmcplots
    Loading required namespace: ggthemes
    Loading required namespace: mcmcr
    Error: `...` must be unused.
    Backtrace:
    [90m    [39m█
    [90m 1. [39m└─missingHE::diagnostic(model.hurdle, type = "histogram", param = "mu.e")
    [90m 2. [39m  ├─base::subset(mcmc_object, parameters = parameters)
    [90m 3. [39m  └─mcmcr:::subset.mcmc.list(mcmc_object, parameters = parameters)
    [90m 4. [39m    └─chk::chk_unused(...)
    [90m 5. [39m      └─chk::abort_chk("`...` must be unused")
    [90m 6. [39m        └─chk::err(..., n = n, tidy = tidy, .subclass = "chk_error")
    [90m 7. [39m          └─rlang::exec(abort, msg, .subclass = .subclass, !!!args[named])
    Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘mcmcr’
      All declared Imports should be used.
    ```

