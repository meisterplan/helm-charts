# Meisterplan Helm Charts

This repository contains Helm charts that are used to deploy Meisterplan microservices.

## Development

Each helm chart can be built, tested and deployed independently.

### Testing Changes

Use `make test` to run all tests against your changes. This will also be done by the CI.

### Releasing a Chart

- Consider bumping the version of the chart before deploying it.
- Run the tests before releasing the chart!
- Run `make release-chart CHART=<chart-name>` to release the chart.
