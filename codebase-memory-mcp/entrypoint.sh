#!/bin/sh
set -e

CBM_BIN=/usr/local/bin/codebase-memory-mcp
CBM_UI_PORT=${CBM_UI_PORT:-9749}
PROXY_PORT=${PROXY_PORT:-8000}

echo "[entrypoint] codebase-memory-mcp container starting..."

# Clean up any stale sockets/locks left behind by prior crashes or reboot
rm -rf /tmp/cbm-daemon* /tmp/*.sock /tmp/*.lock 2>/dev/null || true

# Graceful shutdown handler
cleanup() {
    echo "[entrypoint] Stopping codebase-memory-mcp..."
    [ -n "$CBM_PID" ] && kill -TERM "$CBM_PID" 2>/dev/null || true
    [ -n "$SOCAT_PID" ] && kill -TERM "$SOCAT_PID" 2>/dev/null || true
    [ -n "$CBM_PID" ] && wait "$CBM_PID" 2>/dev/null || true
    rm -rf /tmp/cbm-daemon* /tmp/*.sock /tmp/*.lock 2>/dev/null || true
    exit 0
}
trap cleanup TERM INT

# 1. Configure CBM to expect host requests on port 9749
"$CBM_BIN" --ui=true --port="$CBM_UI_PORT" 2>/dev/null || true
"$CBM_BIN" config set auto_index true 2>/dev/null || true
"$CBM_BIN" config set auto_watch true 2>/dev/null || true

# 2. Proxy external 0.0.0.0:8000 -> 127.0.0.1:9749 so CBM receives Host: localhost:9749
(
    while true; do
        socat TCP-LISTEN:${PROXY_PORT},fork,reuseaddr TCP:127.0.0.1:${CBM_UI_PORT} 2>/dev/null || true
        sleep 1
    done
) &
SOCAT_PID=$!

# 3. Start CBM background daemon
INIT_MSG='{"jsonrpc":"2.0","id":1,"method":"initialize","params":{"protocolVersion":"2024-11-05","capabilities":{},"clientInfo":{"name":"cbm-init","version":"1.0.0"}}}'

(
    echo "$INIT_MSG"
    while true; do
        sleep 3600
    done
) | "$CBM_BIN" --ui=true --port="$CBM_UI_PORT" >/dev/null 2>&1 &

CBM_PID=$!

echo "[entrypoint] Container ready."
echo "[entrypoint]   MCP:  docker exec -i codebase-memory-mcp codebase-memory-mcp"
echo "[entrypoint]   UI:   http://localhost:9749"

wait $CBM_PID
