#!/bin/env pwsh

# Inspiration: https://github.com/Devolutions/devolutions-labs/blob/da8b9a7baf053146f3dd48478bc4374f87753524/powershell/golden.ps1

Param(
    [string] $GitPath = "$HOME\git\"
)

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

$isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if (-Not $isAdmin) {
	throw "You need to run this script with administrator rights"
}

$GitPath = Resolve-Path $GitPath

Push-Location -Path $PSScriptRoot

$ChocoPackages = @(
	'git',
	'vlc',
	'7zip',
	'gsudo',
	'nssm',
	'firefox',
	'kdiff3',
	'wireshark',
	'sysinternals',
	'notepadplusplus',
	'starship',
	'delta',
	'just',
	'mdcat',
	'sharex',
	'nuget.commandline'
)

$CargoPackages = @(
	'diskonaut',
	'just',
	'typos-cli',
	'bacon',
	'cargo-update'
)

try {
	Write-Host '>>> Install Chocolatey packages'
	ForEach ($package in $ChocoPackages) {
		Write-Host ">> Installing $package"
		choco install -y --no-progress $package
	}

	Write-Host '>>> Install cargo packages'
	ForEach ($package in $CargoPackages) {
		Write-Host ">> Installing $package"
		cargo install --locked $package
	}

	Write-Host '>>> PowerShell profile'
	New-Item -ItemType SymbolicLink -Path $PROFILE.CurrentUserCurrentHost -Target $PSScriptRoot\powershell\.config\powershell\Microsoft.PowerShell_profile.ps1 -Force | Out-Null

	Write-Host '>>> Git profile'
	ForEach ($file in (Get-ChildItem -Path $PSScriptRoot\git)) {
		New-Item -ItemType SymbolicLink -Path "$HOME\$($file.Name)" -Target $file -Force | Out-Null
	}

	Write-Host '>>> Helix config'
	New-Item -ItemType SymbolicLink -Path $Env:AppData\helix\config.toml -Target $PSScriptRoot\helix\.config\helix\config.toml -Force | Out-Null

	Write-Host '>>> Install Helix from sources'
	Set-Location -Path $GitPath
	if (-Not (Test-Path .\helix\)) {
		git clone https://github.com/helix-editor/helix
	}
	Set-Location .\helix\
	cargo install --path helix-term
	New-Item -ItemType SymbolicLink -Path $Env:AppData\helix\runtime -Target $GitPath\helix\runtime -Force | Out-Null

	Write-Host '>>> Windows Subsystem for Linux'
	Write-Host '>> Read more at https://learn.microsoft.com/en-us/windows/wsl/install'
	wsl --install
}
catch {
	Write-Host 'An error occurred:'
	Write-Host $_.ScriptStackTrace
}
finally {
	Pop-Location
}
