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

try {
	Get-Command scoop | Out-Null
} catch {
	throw 'scoop not found. Read more at https://scoop.sh/'
}

$GitPath = Resolve-Path $GitPath

$DotfilesPath = (Get-Item $PSScriptRoot).Parent.FullName

Push-Location -Path $PSScriptRoot

$ScoopPackages = @(
	'delta',
	'mdcat',
	'ripgrep',
	'rga',
	'zoxide',
	'starship',
	'nssm',
	'gsudo',
	'wabt'
)

$CargoPackages = @(
	'diskonaut',
	'just',
	'typos-cli',
	'bacon',
	'cargo-update'
)

# Create a new symlink without admin privileges
function New-Symlink {
	param(
		[Parameter(Mandatory)]
		[string] $Path,
		[Parameter(Mandatory)]
		[string] $Target
	)

	if (Test-Path $Path)
	{
		return
	}

    if (Test-Path $Target -PathType Container) {
		New-Item -ItemType Junction -Path $Path -Target $Target -Force | Out-Null
	} else {
		New-Item -ItemType HardLink -Path $Path -Target $Target -Force | Out-Null
	}
}

try {
	Write-Host '>>> Run _elevated_bootstrap.ps1'
	Start-Process -FilePath "pwsh" -Verb RunAs -Wait -ArgumentList "-NoProfile","-Command","$PSScriptRoot\_elevated_bootstrap.ps1"

	Write-Host '>>> Configure scoop'
	scoop bucket add extras

	Write-Host '>>> Install scoop packages'
	ForEach ($package in $ScoopPackages) {
		Write-Host ">> Installing $package"
		scoop install $package
	}

	Write-Host '>>> Install cargo packages'
	ForEach ($package in $CargoPackages) {
		Write-Host ">> Installing $package"
		cargo install --locked $package
	}

	Write-Host '>>> PowerShell profile'
	New-Symlink -Path $PROFILE.CurrentUserCurrentHost -Target $DotfilesPath\powershell\.config\powershell\Microsoft.PowerShell_profile.ps1

	Write-Host '>>> Git profile'
	ForEach ($file in (Get-ChildItem -Path $DotfilesPath\git)) {
		New-Symlink -Path "$HOME\$($file.Name)" -Target $file
	}

	Write-Host '>>> Helix config'
	New-Symlink -Path $Env:AppData\helix\config.toml -Target $DotfilesPath\helix\.config\helix\config.toml

	Write-Host '>>> Install Helix from sources'
	Set-Location -Path $GitPath
	if (-Not (Test-Path .\helix\)) {
		git clone https://github.com/helix-editor/helix
	}
	Set-Location .\helix\
	cargo install --path helix-term
	New-Symlink -Path $Env:AppData\helix\runtime -Target $GitPath\helix\runtime

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
