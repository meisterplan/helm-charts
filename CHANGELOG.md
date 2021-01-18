# spring-service

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

## 1.0.2

- add `args` to allow passing arguments to the container's entrypoint

## 1.0.1

- Fix missing quoting in schedule (asterisk has special meaning in YAML)

## 1.0.0

- Initial release
