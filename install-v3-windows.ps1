param([ValidateSet('Nocturne','Linen')][string]$Palette = 'Nocturne')
$ErrorActionPreference = 'Stop'
$quietRoot = Join-Path $env:LOCALAPPDATA 'Spicetify'
$quietSpotify = Join-Path $env:APPDATA 'Spotify'
if (-not (Test-Path (Join-Path $quietSpotify 'Spotify.exe'))) {
    throw 'Install the desktop edition from spotify.com/download/windows and sign in first. The Microsoft Store edition is not supported by this installer.'
}
$quietBin = Join-Path $quietRoot 'bin'
$quietExe = Join-Path $quietBin 'spicetify.exe'
New-Item -ItemType Directory -Path $quietBin -Force | Out-Null
if (-not (Test-Path $quietExe)) {
    $quietZip = Join-Path ([IO.Path]::GetTempPath()) ('quiet-runtime-' + [guid]::NewGuid() + '.zip')
    Invoke-WebRequest 'https://github.com/spicetify/cli/releases/download/v3.0.0-beta.14/spicetify-3.0.0-beta.14-windows-x86_64.zip' -OutFile $quietZip
    if ((Get-FileHash $quietZip -Algorithm SHA256).Hash -ne 'DDA1877B5624B5DE48E51509632B4E306D98C4369EAA5B89C6E1F642DF06E67A') { throw 'Runtime checksum mismatch. Nothing was applied.' }
    Expand-Archive -LiteralPath $quietZip -DestinationPath $quietBin -Force
}
if ((& $quietExe --version | Out-String).Trim() -ne 'spicetify 3.0.0-beta.14') { throw 'This installer requires Spicetify 3.0.0-beta.14. Preserve your other runtime and use that version in %LOCALAPPDATA%\Spicetify\bin.' }
$quietConfig = Join-Path $quietRoot 'config.toml'
$quietBackup = Join-Path $quietRoot ('quiet-backup-' + (Get-Date -Format yyyyMMdd-HHmmss-fff))
New-Item -ItemType Directory -Path $quietBackup | Out-Null
if (Test-Path $quietConfig) { Copy-Item $quietConfig $quietBackup }
$quietDestination = Join-Path $quietRoot 'modules\quiet'
if (Test-Path $quietDestination) { Copy-Item $quietDestination (Join-Path $quietBackup 'quiet') -Recurse }
# Preserve unrelated settings. Explicit desktop paths avoid Store aliases.
$quietText = if (Test-Path $quietConfig) { Get-Content $quietConfig -Raw } else { '' }
$quietSettings = [ordered]@{mirror='false';daemon='false';spotify_data_dir="'$quietSpotify'";spotify_exec="'$quietSpotify\Spotify.exe'";offline_bnk_dir="'$env:LOCALAPPDATA\Spotify'"}
foreach ($quietKey in $quietSettings.Keys) {
    $quietLine = "$quietKey = $($quietSettings[$quietKey])"
    if ($quietText -match "(?m)^$quietKey\s*=") { $quietText = [regex]::Replace($quietText,"(?m)^$quietKey\s*=.*$",[System.Text.RegularExpressions.MatchEvaluator]{param($m) $quietLine}) }
    else { $quietText += "`n$quietLine`n" }
}
[IO.File]::WriteAllText($quietConfig,$quietText,[Text.UTF8Encoding]::new($false))
New-Item -ItemType Directory -Path $quietDestination -Force | Out-Null
Copy-Item (Join-Path $PSScriptRoot 'Quiet-v3\*') $quietDestination -Force
# Install only the requested scheme so a saved runtime preference cannot override it.
& {
    $quietIni = Get-Content (Join-Path $quietDestination 'color.ini') -Raw
    $quietSections = [regex]::Matches($quietIni,'(?ms)^\[([^\]]+)\].*?(?=^\[|\z)')
    $quietIni = ($quietSections | Where-Object {$_.Groups[1].Value -eq $Palette} | ForEach-Object {$_.Value.Trim()}) -join "`n`n"
    [IO.File]::WriteAllText((Join-Path $quietDestination 'color.ini'),$quietIni,[Text.UTF8Encoding]::new($false))
}
$env:RUST_LOG = 'info'
Write-Host "Backup: $quietBackup"
& $quietExe apply
if ($LASTEXITCODE -ne 0) { throw "Apply failed. Backup retained at $quietBackup. Restore stock Spotify with: & '$quietExe' restore" }
Write-Host "Quiet / $Palette installed. Open Spotify normally."
