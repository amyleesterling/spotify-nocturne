#!/bin/bash
set -euo pipefail
quiet_source="$(cd -- "$(dirname -- "$0")" && pwd)"
exec bash "$quiet_source/install-v3-mac.command" "${1:-Nocturne}"
