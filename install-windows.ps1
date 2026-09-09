param([ValidateSet('Nocturne','Linen')][string]$Palette = 'Nocturne')
& (Join-Path $PSScriptRoot 'install-v3-windows.ps1') -Palette $Palette
