#!/bin/env pwsh

# Run upgrade script with no PowerShell profile (might interfere in a bad way)
pwsh -NoProfile "$PSScriptRoot\_upgrade.ps1"
