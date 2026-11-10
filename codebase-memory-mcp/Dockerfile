FROM ruanzx/codebase-memory-mcp:latest

USER root
# Match host UID/GID (1000:1000) so mounted files have full read/write permissions
RUN usermod -u 1000 cbm && groupmod -g 1000 cbm && chown -R cbm:cbm /home/cbm

# Copy local binary if present, or download latest release if absent
COPY codebase-memory-mcp* /tmp/
RUN if [ -f /tmp/codebase-memory-mcp ]; then \
        mv /tmp/codebase-memory-mcp /usr/local/bin/codebase-memory-mcp; \
    else \
        curl -fsSL -L -o /usr/local/bin/codebase-memory-mcp \
        https://github.com/DeusData/codebase-memory-mcp/releases/latest/download/codebase-memory-mcp-linux-x86_64; \
    fi && \
    chmod +x /usr/local/bin/codebase-memory-mcp

# Copy customized entrypoint
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER cbm
EXPOSE 8000
