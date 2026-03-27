# phenoscript-docker
Docker image for converting PhenoScript files (`.phs` / `.yphs`) to OWL using [phenospy](https://github.com/sergeitarasov/PhenoScript).

## Build

```bash
docker build -t phenoscript-docker .
```

## Publish to Docker Hub

```bash
docker tag phenoscript-docker sergeita/phenoscript-docker:latest
docker push sergeita/phenoscript-docker:latest
```

## Volume mounts (required at runtime)

| Mount | Host path | Description |
|-------|-----------|-------------|
| `/app/input` | `project/phenotypes/` | Contains `.phs`/`.yphs` file and `phs-config.yaml` |
| `/app/snippets` | `extension/snippets/` | Provides `phs-snippets.json` |
| `/app/output` | `project/output/owl_init/` | Receives `output.owl` and `output.xml` |

## Environment variables

| Variable | Description |
|----------|-------------|
| `PHS_FILE` | Basename of the input file, e.g. `my_species.yphs` |

## Manual run example

```bash
docker run --rm \
  -v "/path/to/project/phenotypes:/app/input" \
  -v "/path/to/extension/snippets:/app/snippets" \
  -v "/path/to/project/output/owl_init:/app/output" \
  -e PHS_FILE=my_species.yphs \
  phenoscript-docker
```

Normally launched automatically by the PhenoScript VS Code extension via the **Convert to OWL** button.

