# DrawDB MCP

Interactive database ER-diagram designer and schema visualizer with built-in MCP server.

## Quick Start
```bash
docker compose up -d
```

To stop:
```bash
docker compose down
```

## URLs
- **Web UI:** http://localhost:8080
- **MCP Endpoint:** http://127.0.0.1:3000/

## Antigravity MCP Config
In `~/.gemini/config/mcp_config.json`:
```json
{
  "mcpServers": {
    "drawdb": {
      "url": "http://127.0.0.1:3000/"
    }
  }
}
```
