#!/bin/env pwsh

$ErrorActionPreference = "Stop"

try {
	Get-Command choco | Out-Null
} catch {
	throw 'Chocolatey not found. Read more at https://docs.chocolatey.org/en-us/choco/setup'
}

try {
	Get-Command rustup | Out-Null
} catch {
	throw 'rustup not found. Read more at https://rustup.rs/'
}

try {
	Get-Command scoop | Out-Null
} catch {
	throw 'scoop not found. Read more at https://scoop.sh/'
}

gsudo choco upgrade all --yes --no-progress

gsudo winget upgrade --all

scoop update *

cargo install-update --all
