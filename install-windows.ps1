param([ValidateSet('Nocturne','Linen')][string]$Palette = 'Nocturne')
$ErrorActionPreference = 'Stop'
if (-not (Get-Command spicetify -ErrorAction SilentlyContinue)) {
    throw 'Install Spicetify first: https://spicetify.app/docs/getting-started . Then reopen PowerShell and run this installer again.'
}
$quietConfig = (& spicetify -c | Out-String).Trim()
if ($LASTEXITCODE -ne 0 -or -not (Test-Path -LiteralPath $quietConfig -PathType Leaf)) {
    throw 'Spicetify configuration was not found. Complete Spicetify setup first.'
}
$quietRoot = Split-Path -Parent $quietConfig
$quietVersion = (& spicetify -v | Out-String).Trim().TrimStart('v')
$quietSpotifyLine = Get-Content -LiteralPath $quietConfig | Where-Object { $_ -match '^spotify_path\s*=' } | Select-Object -First 1
if ($quietVersion -eq '2.44.0' -and $quietSpotifyLine) {
    $quietSpotifyPath = ($quietSpotifyLine -split '=', 2)[1].Trim()
    $quietSpotifyExe = Join-Path $quietSpotifyPath 'Spotify.exe'
    if (Test-Path -LiteralPath $quietSpotifyExe -PathType Leaf) {
        $quietProductVersion = (Get-Item -LiteralPath $quietSpotifyExe).VersionInfo.ProductVersion
        if ($quietProductVersion -match '^(\d+\.\d+\.\d+)') {
            if ([version]$Matches[1] -gt [version]'1.2.96') {
                throw "Spotify $quietProductVersion is newer than Spicetify 2.44.0 supports (through 1.2.96). No theme changes were made. Check https://github.com/spicetify/cli/releases/latest before retrying."
            }
        }
    }
}
$quietDestination = Join-Path $quietRoot 'Themes\Quiet'
$quietStamp = Get-Date -Format 'yyyyMMdd-HHmmss-fff'
$quietBackup = Join-Path $quietRoot "quiet-backup-$quietStamp"
New-Item -ItemType Directory -Path $quietBackup | Out-Null
Copy-Item -LiteralPath $quietConfig -Destination (Join-Path $quietBackup 'config-xpui.ini')
if (Test-Path -LiteralPath $quietDestination) {
    Copy-Item -LiteralPath $quietDestination -Destination (Join-Path $quietBackup 'Quiet') -Recurse
}
New-Item -ItemType Directory -Path $quietDestination -Force | Out-Null
foreach ($quietFile in @('user.css', 'color.ini')) {
    Copy-Item -LiteralPath (Join-Path $PSScriptRoot "Quiet\$quietFile") -Destination (Join-Path $quietDestination $quietFile) -Force
}
& spicetify config current_theme Quiet color_scheme $Palette inject_css 1 replace_colors 1
if ($LASTEXITCODE -ne 0) { throw "Could not configure Quiet. Previous config: $quietBackup" }
& spicetify apply
if ($LASTEXITCODE -ne 0) { throw "Could not apply Quiet. Complete Spicetify setup; previous config is in $quietBackup" }
Write-Host "Quiet / $Palette applied. Previous configuration saved in $quietBackup"
