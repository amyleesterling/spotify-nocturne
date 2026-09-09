# Quiet / Listening Room

## Current compatibility — September 9, 2026

**Do not apply with Spotify 1.2.99 and Spicetify 2.44.0.** A live Windows Microsoft Store installation opened to a blank window, including with optional Spicetify features disabled. The original Spotify files and configuration were restored. The theme is not currently active on that machine.

Spicetify 2.44.0 lists Windows and macOS compatibility through Spotify 1.2.96. Check the [current release notes](https://github.com/spicetify/cli/releases/latest) before installing. The Windows installer rejects this known incompatible version combination before modifying the theme. Mac installation remains unverified on a live Mac; verify both versions first.

The Store edition also needs a Spicetify launcher rather than its original Start menu tile. No custom launcher was created during the failed compatibility test. These files are ready for testing when a compatible Spicetify release is available.

Text and icons for Spotify on Windows and macOS. Warm serif headings, readable song lists, restrained music markers, and no visible album photography. Two palettes: **Nocturne** (deep green-black, ivory, jade) and **Linen** (warm paper, dark green).

## Before installing

Complete the official Spicetify setup for your platform: https://spicetify.app/docs/getting-started . Open Spotify and sign in first. Spicetify needs an initial Spotify backup before applying themes; follow its first-time `spicetify backup apply` instructions. These installers require an already working Spicetify installation; they do not download software or request administrator access.

## Windows

Download this repository as a ZIP and extract it (or clone it). Open PowerShell in the folder containing install-windows.ps1 and run:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\install-windows.ps1
```

The execution-policy option applies only to this process. For the light palette, append `-Palette Linen`.

## Mac

Download this repository as a ZIP and extract it (or clone it). Open Terminal, type `bash ` (including the space), drag install-mac.command into Terminal, and press Return. This works without changing the file's executable permission. For the light palette, add ` Linen` after the path before pressing Return.

The Mac version uses system sans-serif and Iowan Old Style/Palatino headings. Windows uses Segoe UI and Palatino Linotype/Georgia. Both contain the same portable theme and palettes; neither replaces native window controls.

## What the installer does

Finds Spicetify's active configuration using `spicetify -c`, creates a uniquely named quiet-backup folder beside it, saves the configuration and any existing Quiet theme, copies the two theme files, selects Quiet and the chosen palette, then runs `spicetify apply`. Spotify may restart. Failure stops the installer and preserves the backup. Its location is printed in the terminal.

## Change palettes

```text
spicetify config color_scheme Linen
spicetify apply
```

Use Nocturne instead of Linen to return to dark.

## Manual installation

Copy Quiet into your Spicetify Themes directory, then run:

```text
spicetify config current_theme Quiet color_scheme Nocturne inject_css 1 replace_colors 1
spicetify apply
```

Default directories: Windows `%APPDATA%\spicetify\Themes`; macOS `~/.config/spicetify/Themes`. Use `spicetify -c` to locate a non-default configuration.

Expand Spotify's library sidebar and select list view so playlists are identified by their names.

## Restore

Close Spotify. Copy config-xpui.ini from the printed quiet-backup folder back to the original configuration location. If the backup contains a Quiet folder, copy its contents back into Themes/Quiet too. Run `spicetify apply`. Restoring the configuration also restores other Spicetify settings as they were at installation time. Alternatively, choose another installed theme with `spicetify config current_theme THEME_NAME`, then apply.

To remove all Spicetify modifications, use `spicetify restore`.

## Preview and compatibility

The conversation preview is an interactive design study, not a connected Spotify player or a pixel-exact screenshot of the installed skin. Its listening-room arrangement illustrates the typography, spacing, and palettes. The CSS styles Spotify's existing layout; it does not add a new Listen page or change recommendations.

The skin has not been tested inside live Spotify on Windows or macOS. Spotify markup changes can require selector updates. Artwork and video frames are hidden visually; media downloads and audio/video mode are unchanged. Native SVG playback and navigation icons remain visible. The theme has no JavaScript, remote fonts, remote resources, or account access. The installers only copy local files and invoke Spicetify.

References: https://spicetify.app/docs/customization/themes and https://spicetify.app/docs/cli/commands .
