#!/bin/env pwsh

$ErrorActionPreference = "Stop"

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

Push-Location -Path $PSScriptRoot

try {
	Write-Host '>>> Run _elevated_upgrade.ps1'
	Start-Process -FilePath "pwsh" -Verb RunAs -Wait -ArgumentList "-NoProfile","-Command","$PSScriptRoot\_elevated_upgrade.ps1"

	Write-Host '>>> Update scoop packages'
	scoop update *

	Write-Host '>>> Update cargo packages'
	$Env:CARGO_INSTALL_OPTS = "--locked"
	cargo +stable install-update --all
} catch {
	Write-Host -Foreground Red -Background Black 'An error occurred:' $_
	Write-Host -Foreground Red -Background Black $_.ScriptStackTrace

	Write-Host "Press any key to exit..."
	$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
} finally {
	Pop-Location
}
