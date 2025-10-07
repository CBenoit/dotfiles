#!/bin/bash
cargo cache trim --limit 1G
cargo cache --autoclean-expensive
cargo sweep -t 10 -r

