# mcmcderive

<details>

* Version: 0.1.0
* GitHub: https://github.com/poissonconsulting/mcmcderive
* Source code: https://github.com/cran/mcmcderive
* Date/Publication: 2020-07-16 21:30:02 UTC
* Number of recursive dependencies: 61

Run `revdep_details(, "mcmcderive")` for more info

</details>

## Newly broken

*   checking tests ...
    ```
     ERROR
    Running the tests in ‘tests/testthat.R’ failed.
    Last 13 lines of output:
      > library(testthat)
      > library(mcmcderive)
      > 
      > test_check("mcmcderive")
      ══ Failed tests ════════════════════════════════════════════════════════════════
      ── Failure (test-mcmc-derive.R:11:3): mcmc_derive.nlist ────────────────────────
      mcmc_derive(nlist, expr, silent = TRUE) not identical to structure(list(gamma = c(3, 4), z = 3L), class = "nlist").
      Objects equal but not identical
      ── Failure (test-mcmc-derive.R:28:3): mcmc_derive.nlists ───────────────────────
      mcmc_derive(nlist, expr, silent = TRUE) not identical to structure(...).
      Objects equal but not identical
      
      [ FAIL 2 | WARN 0 | SKIP 0 | PASS 30 ]
      Error: Test failures
      Execution halted
    ```

## In both

*   checking dependencies in R code ... NOTE
    ```
    Namespace in Imports field not imported from: ‘term’
      All declared Imports should be used.
    ```

