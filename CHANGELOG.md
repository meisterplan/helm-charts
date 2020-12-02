# 2.0.0

- Secrets are now generated from ExternalSecrets. Fitted deployment.yaml and added pre-deploy/secret.yaml for this.
-- Secrets can be accessed via new `.env.fromSecret` map
- Converted `env.additional` secrets to map so that `env.additionalPerRegion` becomes (it is automatically merged, see test case)
- New option `env.springRabbitMQSecret` that can be set to true to reduce boilerplate when using RabbitMQ secrets
- Tag is now mandatory
- Repository is now mandatory
- New mandatory parameter: `clusterName`, necessary for secret access
- New mandatory parameter: `secretsRoleArn`, necessary for secret access
