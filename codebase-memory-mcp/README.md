# Codebase Memory MCP

Knowledge graph code intelligence engine for AI agents (Antigravity, VS Code, Claude, etc.).

## Quick Start
```bash
docker compose up -d --build
```

To stop:
```bash
docker compose down
```

## Features
- **Version:** `0.12.1+` (Includes `check_index_coverage`, `compare_graphs`, `get_file_outline`)
- **Web UI:** http://localhost:9749
- **Host Storage:** `/home/eshan/docker-volumes/codebase-memory/cache`
- **Host Code Repos:** `/home/eshan/coding`

## MCP Client Configuration
In `~/.gemini/config/mcp_config.json` (or `~/.config/Code/User/mcp.json`):
```json
{
  "mcpServers": {
    "codebase-memory-mcp": {
      "command": "/home/eshan/.local/bin/codebase-memory-mcp",
      "args": []
    }
  }
}
```
*(Or directly using `docker exec`:)*
```json
{
  "mcpServers": {
    "codebase-memory-mcp": {
      "command": "docker",
      "args": ["exec", "-i", "codebase-memory-mcp", "codebase-memory-mcp"]
    }
  }
}
```
