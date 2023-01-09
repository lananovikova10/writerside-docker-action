# A github action for building a Writerside doc artifacts in a Docker container

This action creates a zip-archive with HTMLs from markdown or semantic markup topics.

## Environment variables

### `ARTIFACT`

The name of the archive is webHelpXX2-all.zip where XX gets replaced by the product id in caps.

### `PRODUCT`

The $PRODUCT should be name_of_module / product_id, for example sample_module/sd. No default value.

## Example usage with the build HTMLs only

```yml
```yml
name: Build docs

on:
  push:
    branches: ["main"]

  workflow_dispatch:

env:
  PRODUCT: module/instance-id
  ARTIFACT: webHelpXX2-all.zip

jobs:
  build-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      - name: Build Writerside docs with docker
        uses: lananovikova10/writerside-docker-action@v1.2
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
           name: artifact
           path: artifacts/${{ env.ARTIFACT }}
           retention-days: 7
```


## Example usage with build and publish to GitHub pages

```yml
name: Build docs

on:
  push:
    branches: ["main"]

  workflow_dispatch:
  
# Sets permissions of the GITHUB_TOKEN to allow deployment to GitHub Pages
permissions:
  contents: read
  pages: write
  id-token: write

env:
  PRODUCT: module/instance-id
  ARTIFACT: webHelpXX2-all.zip

jobs:
  build-job:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout repository
        uses: actions/checkout@v3
      - name: Build Writerside docs with docker
        uses: lananovikova10/writerside-docker-action@v1.2
      - name: Upload artifact
        uses: actions/upload-artifact@v3
        with:
           name: artifact
           path: artifacts/${{ env.ARTIFACT }}
           retention-days: 7

  deploy:
    environment:
        name: github-pages
        url: ${{ steps.deployment.outputs.page_url }}
    needs: build-job
    runs-on: ubuntu-latest
    steps:
      - name: Download artifact
        uses: actions/download-artifact@v3
        with:
          name: artifact
      - name: Unzip artifact
        uses: montudor/action-zip@v1
        with:
          args: unzip -qq ${{ env.ARTIFACT }} -d dir
      - name: Setup Pages
        uses: actions/configure-pages@v2
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v1
        with:
          path: dir
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v1
          
```
