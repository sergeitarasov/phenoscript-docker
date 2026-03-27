FROM python:3.11-slim

RUN pip install --no-cache-dir phenospy==0.271

WORKDIR /app
COPY entrypoint.sh /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh

# Expected volume mounts at runtime:
#   /app/input    — project phenotypes/ dir (contains .phs/.yphs + phs-config.yaml)
#   /app/snippets — extension snippets/ dir (provides phs-snippets.json)
#   /app/output   — output/owl_init/ dir (receives .owl and .xml)

ENTRYPOINT ["/app/entrypoint.sh"]
