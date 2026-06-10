test:
	$(MAKE) test-case-v2 CHART=cronjob 			   RELEASE_NAMESPACE=team-superpower RELEASE_NAME=simple-job-staging CASE=simple-cronjob
	$(MAKE) test-case-v2 CHART=cronjob 			   RELEASE_NAMESPACE=team-superpower RELEASE_NAME=simple-job-staging CASE=service-account-cronjob
	$(MAKE) test-case-v2 CHART=meisterplan-service RELEASE_NAMESPACE=team-supercool  RELEASE_NAME=myservice          CASE=simple-spring-service
	$(MAKE) test-case-v2 CHART=meisterplan-service RELEASE_NAMESPACE=team-supercool  RELEASE_NAME=myservice          CASE=complex-spring-service
	$(MAKE) test-case-v2 CHART=meisterplan-service RELEASE_NAMESPACE=team-supercool  RELEASE_NAME=myservice          CASE=simple-nodejs-service
	$(MAKE) test-case-v2 CHART=meisterplan-service RELEASE_NAMESPACE=team-supercool  RELEASE_NAME=myservice          CASE=simple-python-service
	$(MAKE) test-case-v2 CHART=meisterplan-service RELEASE_NAMESPACE=team-supercool  RELEASE_NAME=myservice          CASE=simple-nginx-service
	$(MAKE) test-version-in-changelog CHART=cronjob
	$(MAKE) test-version-in-changelog CHART=meisterplan-service

test-case:
	rm -rf .test-output && 	mkdir -p .test-output
	helm template --output-dir .test-output ./charts/$(CHART) -f tests/$(CHART)/$(CASE)/values.yaml -f tests/$(CHART)/$(CASE)/values.staging.yaml
	diff -r tests/$(CHART)/$(CASE)/expected/ .test-output/
	@echo "Test passed for $(CHART) - $(CASE)"

test-case-v2:
	@test -n "$(CHART)" || (echo "Error: CHART must be set, e.g. meisterplan-service."; exit 1)
	@test -n "$(CASE)" || (echo "Error: CASE must be set, e.g. simple-spring-service."; exit 1)
	@test -n "$(RELEASE_NAMESPACE)" || (echo "Error: RELEASE_NAMESPACE must be set, e.g. team-supercool."; exit 1)
	@test -n "$(RELEASE_NAME)" || (echo "Error: RELEASE_NAME must be set, e.g. myservice."; exit 1)
	rm -rf .test-output && 	mkdir -p .test-output
	helm template --namespace $(RELEASE_NAMESPACE) --output-dir .test-output $(RELEASE_NAME) ./charts/$(CHART) -f tests/$(CHART)/$(CASE)/values.yaml -f tests/$(CHART)/$(CASE)/values.staging.yaml
	diff -r tests/$(CHART)/$(CASE)/expected/ .test-output/
	@echo "Test passed for $(CHART) - $(CASE)"

test-case-promote-to-expected:
	@test -n "$(CHART)" || (echo "Error: CHART must be set, e.g. meisterplan-service."; exit 1)
	@test -n "$(CASE)" || (echo "Error: CASE must be set, e.g. simple-spring-service."; exit 1)
	rm -rf tests/$(CHART)/$(CASE)/expected/*
	cp -r .test-output/* tests/$(CHART)/$(CASE)/expected/

test-version-in-changelog:
	@test -n "$(CHART)" || (echo "Error: CHART must be set, e.g. meisterplan-service."; exit 1)
	$(eval CHART_VERSION=$(shell grep -Po '(?<=version: )[0-9.]+' charts/$(CHART)/Chart.yaml))
	sed -n '/^# $(CHART)/,/^# /p' CHANGELOG.md | grep '$(CHART_VERSION)' || (echo "Error: CHANGELOG.md does not mention $(CHART_VERSION) for $(CHART)."; exit 1)
