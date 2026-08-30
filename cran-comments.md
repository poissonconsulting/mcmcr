# mcmcr 0.7.0

## Cran Repository Policy

- [x] Reviewed CRP last edited 2024-08-27.

## R CMD check results

- [x] Checked locally, R 4.6.1: 0 errors, 0 warnings, 0 notes.
- [x] Checked via GitHub Actions on Linux (release, devel, oldrel-1), macOS and
      Windows.
- [x] Checked on win-builder, R Under development (2026-08-27 r90452 ucrt):
      Status OK.
- [x] Checked on R-hub (linux, windows, macOS on R-devel)

## Current CRAN check results

- [x] The published 0.6.2 carries two NOTEs on r-devel, both fixed in this
      release:
      - "Found calls to structure() using deprecated special names" (`.Dim`,
        5 r-devel flavors), renamed to `dim` in the affected tests.
      - "Rd files without \usage: 'params.Rd'" (2 flavors). The shared
        parameter topic documents \arguments with no \usage, so it is now
        marked with \keyword{internal}, matching nlist.

## Reverse dependencies

- [x] `revdepcheck::revdep_check()` run against 0.7.0: 3 reverse dependencies
      (mcmcderive, missingHE, nlist), 0 new problems, 0 failures.

## Notes

- This release requires nlist (>= 0.5.0), which is now on CRAN.
