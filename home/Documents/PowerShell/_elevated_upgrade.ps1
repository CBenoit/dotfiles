#!/bin/env pwsh

$ErrorActionPreference = "Stop"

try {
	Get-Command choco | Out-Null
} catch {
	throw 'Chocolatey not found. Read more at https://docs.chocolatey.org/en-us/choco/setup'
}

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

Push-Location -Path $PSScriptRoot

try {
	if (-Not $isAdmin) {
		throw "You need to run this script with administrator rights"
	}

	Write-Host '>>> Update Chocolatey packages'
	choco upgrade all --yes --no-progress

	Write-Host '>>> WinGet upgrade'
	winget upgrade --all
} catch {
	Write-Host -Foreground Red -Background Black 'An error occurred:' $_
	Write-Host -Foreground Red -Background Black $_.ScriptStackTrace

	Write-Host "Press any key to exit..."
	$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
} finally {
	Pop-Location
}

