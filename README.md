# Sample PlantUML Diagrams

This repository holds the basics to facilitate a seamless, command-line-based workflow to generate [PlantUML](https://plantuml.com) diagrams from source.
See my post [PlantUML Diagrams](https://danielwiese.com/posts/plantuml-diagrams/) for more information.

## Quickstart

```sh
# Generate PNGs
make png

# Generate PDFs
make pdf

# Generate output using the command in the Docker container
make RUN_IN_DOCKER=1 png

# Remove outputs
make clean

# List installed fonts
make fonts

# Display types, parameters, color keywords
make lang
```

## Basic Installation

To install:

* Copy the contents of `jars` to the appropriate place on your environment, e.g. `/Library/Java/Extensions` on MacOS.
* Install [Graphviz](https://graphviz.org), e.g. `brew install graphviz`
* Rename `sample.env` as `.env`, e.g. `cp sample.env .env` and set the variables appropriately

To generate `sample.png` from `sample.puml` use the following command

```zsh
# Generate sample.png from sample.puml
java -jar /Library/Java/Extensions/plantuml-1.2023.12.jar src/sample/sample.puml
```

## Using Docker

To build a Docker image to run PlantUML from, and generate a diagram from source, use the following commands.

```zsh
# Build the new image from the Dockerfile
docker build -t buster-slim-plantuml:1-2023.12 -f Dockerfile .

# Run a container from this newly created image
docker run --rm -v $PWD:/puml-diagrams buster-slim-plantuml:1-2023.12 java -jar /usr/share/java/plantuml-1.2023.12.jar -o /puml-diagrams/out /puml-diagrams/src/sample/sample-math.puml
```
