#!/bin/env pwsh

# Run bootstrap script with no PowerShell profile (might interfere in a bad way).
pwsh -NoProfile "${Env:USERPROFILE}\Documents\PowerShell\_bootstrap.ps1"
