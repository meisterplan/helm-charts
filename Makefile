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

release:
	$(MAKE) release-chart CHART=spring-service
	$(MAKE) release-chart CHART=cronjob

release-chart:
	rm -rf .gh-pages-branch
	git clone --branch gh-pages git@github.com:meisterplan/helm-charts .gh-pages-branch

	helm package charts/$(CHART) -d .gh-pages-branch/
	helm repo index .gh-pages-branch/

	cd .gh-pages-branch && \
		git add . && \
		git commit -m "New release of $(CHART) ($(shell cat charts/$(CHART)/Chart.yaml | grep version))" && \
		git push
