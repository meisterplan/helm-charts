# spring-service

## 3.3.0

- Use PodDisruptionBudget to allow specifying desired disruption limits during voluntary cluster interactions

## 3.2.0

- Use future-proof Ingress API version (networking.k8s.io/v1) and add ingress class

## 3.1.3

- Switch to GitHub actions to release helm charts.

## 3.1.2

- Increase startupProbe time until a failure occurs to 2 minutes.

## 3.1.1

- Fix `env.springDatasourceFromSecretWithRLS` using wrong env for Flyway's user name

## 3.1.0

- Support for `env.springDatasourceFromSecretWithRLS` was introduced (exclusive alternative to `env.springDatasourceFromSecret`).

## 3.0.1

**Breaking Changes**

> Support for `alertingRules[].summary` was dropped in favor of `alertingRules[].description`. Although backwards-compatible this is silently breaking: Defined summaries will no longer be propagated.

## 3.0.0

**Breaking Changes**

> Support for `livenessProbe.delay` and `readinessProbe.delay` was dropped in favor of `startupProbe.periodSeconds` and `startupProbe.failAfterCount`

- Add `livenessProbe.failAfterCount` and `readinessProbe.failAfterCount` to control how many must fail before corrective action is taken

## 2.2.1

**Breaking changes**

> :warning: **WARNING**: The first time _2.2.1 or any version after_ is deployed when _any version before 2.2.1_ is running this causes a **nonzero downtime deployment** with a short 503 service disruption due to a [bug in the ingress controller](https://github.com/kubernetes/ingress-nginx/issues/6962).
>
> Please take appropriate measures (e.g. deploy this change in off-hours only).
>
> This only happens the first time, the deployments afterwards are not affected.

- Fix `.internalPorts` not working due to missing port names in service

## 2.2.0

- Add `.internalPorts` for additional interfaces inside cluster

## 2.1.1

- Add option to disable prometheusScraping

## 2.1.0

- Support `.timeouts` for overriding several deployment timeouts

## 2.0.5

- Add basicAuthSecretParameterName to ingress annotation methods

## 2.0.4

- Add more ingress annotation methods (proxy read timeout + body size)

## 2.0.3

- New mandatory parameter: `playbook_url`, necessary for alerting rules

## 2.0.2

- Fixed invalid secret names
- Fixed confusing default values for `.serviceName` and `.namespace` which have required Checks

## 2.0.1

- Fixed invalid YAML when `.env.additional` created multi-line strings

## 2.0.0

- Secrets are now generated from ExternalSecrets. Fitted deployment.yaml and added pre-deploy/secret.yaml for this.
  -- Secrets can be accessed via new `.env.fromSecret` map
- Converted `env.additional` secrets to map so that `env.additionalPerRegion` becomes superfluous (it is automatically merged, see test case)
- New option `env.springRabbitMQSecret` that can be set to true to reduce boilerplate when using RabbitMQ secrets
- Tag is now mandatory
- Repository is now mandatory
- New mandatory parameter: `clusterName`, necessary for secret access
- New mandatory parameter: `secretsRoleArn`, necessary for secret access

# cronjob

## 1.2.0

- Use future-proof CronJob API version (batch/v1), which is deprecated since 1.21 and will be removed in 1.25+

## 1.1.1

**Breaking Changes**

> Support for `alertingRules[].summary` was dropped in favor of `alertingRules[].description`. Although backwards-compatible this is silently breaking: Defined summaries will no longer be propagated.

## 1.1.0

- add alerting rules for Prometheus

## 1.0.2

- add `args` to allow passing arguments to the container's entrypoint

## 1.0.1

- Fix missing quoting in schedule (asterisk has special meaning in YAML)

## 1.0.0

- Initial release
