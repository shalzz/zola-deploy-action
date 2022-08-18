deploy: check-env
	git tag $(TAG)
	git push && git push --tags
	gh release create $(TAG) --generate-notes

redeploy: check-env
	git tag -d $(TAG)
	git push origin :refs/tags/$(TAG)
	git tag $(TAG)
	git push && git push --tags

check-env:
ifndef TAG
	$(error TAG is undefined)
endif

