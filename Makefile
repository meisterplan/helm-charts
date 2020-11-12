release: clone-gh-pages-branch package update-index push-gh-pages-branch
	
clone-gh-pages-branch: clone-gh-pages-branch
	rm -rf .gh-pages-branch
	git clone --branch gh-pages git@github.com:meisterplan/helm-charts .gh-pages-branch

push-gh-pages-branch:
	cd .gh-pages-branch && \
		git add . && \
		git commit -m "New release" && \
		git push

package:
	helm package charts/spring-service -d .gh-pages-branch/

update-index:
	helm repo index .gh-pages-branch/ 