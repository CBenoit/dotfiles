#!/bin/env pwsh

#################################################
## This is intended to be run by bootstrap.ps1 ##
#################################################

$ErrorActionPreference = "Stop"

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

Push-Location -Path $PSScriptRoot

$WingetPackages = @(
	'LGUG2Z.komorebi'
)

$ChocoPackages = @(
	'git',
	'vlc',
	'7zip',
	'firefox',
	'kdiff3',
	'wireshark',
	'sysinternals',
	'notepadplusplus',
	'sharex',
	'nuget.commandline'
)

try {
	try {
		Get-Command choco | Out-Null
	} catch {
		throw 'Chocolatey not found. Read more at https://docs.chocolatey.org/en-us/choco/setup'
	}

	if (-Not $isAdmin) {
		throw "You need to run this script with administrator rights"
	}

	try {
		Set-ExecutionPolicy -Scope LocalMachine AllSigned
	} catch {}
	Set-ExecutionPolicy -Scope CurrentUser RemoteSigned

	Write-Host '>>> Install winget packages'
	ForEach ($package in $WingetPackages) {
		Write-Host ">> Installing $package"
		winget install --exact --id $package
	}

	Write-Host '>>> Install Chocolatey packages'
	ForEach ($package in $ChocoPackages) {
		Write-Host ">> Installing $package"
		choco install -y --no-progress $package
	}

	Write-Host '>>> Windows Subsystem for Linux'
	Write-Host '>> Read more at https://learn.microsoft.com/en-us/windows/wsl/install'
	wsl --install
} catch {
	Write-Host -Foreground Red -Background Black 'An error occurred:' $_
	Write-Host -Foreground Red -Background Black $_.ScriptStackTrace

	Write-Host "Press any key to exit..."
	$Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown") | Out-Null
} finally {
	Pop-Location
}
