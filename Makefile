test:
	$(MAKE) test-case CHART=spring-service CASE=simple-service
	$(MAKE) test-case CHART=spring-service CASE=complex-service
	$(MAKE) test-case CHART=cronjob CASE=simple-cronjob
	$(MAKE) test-case CHART=cronjob CASE=service-account-cronjob
	$(MAKE) test-version-in-changelog CHART=spring-service
	$(MAKE) test-version-in-changelog CHART=cronjob

test-case:
	rm -rf .test-output && 	mkdir -p .test-output
	helm template --output-dir .test-output ./charts/$(CHART) -f tests/$(CHART)/$(CASE)/values.yaml -f tests/$(CHART)/$(CASE)/values.staging.yaml
	diff -r tests/$(CHART)/$(CASE)/expected/ .test-output/
	@echo "Test passed for $(CHART) - $(CASE)"

test-case-promote-to-expected:
	@test -n "$(CHART)" || (echo "Error: CHART must be set, e.g. spring-service."; exit 1)
	@test -n "$(CASE)" || (echo "Error: CASE must be set, e.g. simple-service."; exit 1)
	rm -rf tests/$(CHART)/$(CASE)/expected/*
	cp -r .test-output/* tests/$(CHART)/$(CASE)/expected/

test-version-in-changelog:
	@test -n "$(CHART)" || (echo "Error: CHART must be set, e.g. spring-service."; exit 1)
	$(eval CHART_VERSION=$(shell grep -Po '(?<=version: )[0-9.]+' charts/$(CHART)/Chart.yaml))
	sed -n '/^# $(CHART)/,/^# /p' CHANGELOG.md | grep '$(CHART_VERSION)' || (echo "Error: CHANGELOG.md does not mention $(CHART_VERSION) for $(CHART)."; exit 1)
