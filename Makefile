test:
	$(MAKE) test-case CHART=spring-service CASE=simple-service

test-case:
	rm -rf .test-output && 	mkdir -p .test-output
	helm template --output-dir .test-output ./charts/$(CHART) -f tests/$(CHART)/$(CASE)/values.yaml
	diff -r tests/$(CHART)/$(CASE)/expected/ .test-output/
	@echo "Test passed for $(CHART) - $(CASE)"

release:
	$(MAKE) release-chart CHART=spring-service

release-chart: 
	rm -rf .gh-pages-branch
	git clone --branch gh-pages git@github.com:meisterplan/helm-charts .gh-pages-branch

	helm package charts/$(CHART) -d .gh-pages-branch/
	helm repo index .gh-pages-branch/

	cd .gh-pages-branch && \
		git add . && \
		git commit -m "New release of $(CHART) ($(shell cat charts/$(CHART)/Chart.yaml | grep version))" && \
		git push
