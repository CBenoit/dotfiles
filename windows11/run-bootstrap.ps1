#!/bin/env pwsh

# Run bootstrap script with no PowerShell profile (might interfere in a bad way)
pwsh -NoProfile "$PSScriptRoot\_bootstrap.ps1"
