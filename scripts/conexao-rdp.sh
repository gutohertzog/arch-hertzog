#!/usr/bin/env bash
set -o pipefail

RDP_HOST="$1"
RDP_USER="${2:-augusto}"
shift $(( $# < 2 ? $# : 2 ))

if [[ -z "$RDP_HOST" ]]; then
    echo "Uso: $0 <host> [usuario] [outras opções xfreerdp3]" >&2
    exit 1
fi

LOG="$HOME/Documents/rdp-logs/xfreerdp-$RDP_HOST.log"
mkdir -p "$(dirname "$LOG")"

{
    echo ""
    echo "=== FreeRDP connection ==="
    echo "Host: $RDP_HOST"
    echo "User: $RDP_USER"
    echo "Start: $(date --iso-8601=seconds)"
    echo "==========================="
} | tee -a "$LOG"

xfreerdp3 \
    "/v:${RDP_HOST}" \
    "/u:${RDP_USER}" \
    /drive:LinuxHome,/home/guto/Windows \
    +dynamic-resolution \
    /f \
    +clipboard \
    "$@" \
    2>&1 | tee -a "$LOG"

STATUS=${PIPESTATUS[0]}
echo "End: $(date --iso-8601=seconds) (exit ${STATUS})" | tee -a "$LOG"
exit "$STATUS"

