test:
	$(MAKE) test-case CHART=spring-service CASE=simple-service
	$(MAKE) test-case CHART=spring-service CASE=simple-service-rls
	$(MAKE) test-case CHART=cronjob CASE=simple-cronjob

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
