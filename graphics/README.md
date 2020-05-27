# Libre2Link-Nightscout/graphics: Some visualization tools

## Prerequisites:

- See `../README.md`.
- Have a `date` command that knows about `-d@...`.
- Install `gnuplot` and `feh` image viewer.

## How to do it:

- These utilities use the `data` collected by the tools in the parent directory.
- Optionally, run `fetch-mbg` to query Nightscout for the manual blood-glucose measurements.
- Run `show-libre-data` to create a PNG file, and view it in `feh`.

## Tested on:

- MacOSX 10.11.6 running a Debian Buster VM in VirtualBox
