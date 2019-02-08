JSONNET_FMT := jsonnet fmt -n 2 --max-blank-lines 2 --string-style s --comment-style s

all: fmt prometheus_alerts.yaml lint yamlfmt test

setup:
	go get -u github.com/devopyio/yamlfmt
	go get -u github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb

fmt:
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | xargs -n 1 -- $(JSONNET_FMT) -i

prometheus_alerts.yaml: mixin.libsonnet lib/alerts.jsonnet alerts/*.libsonnet
	jsonnet -S lib/alerts.jsonnet > $@

lint: prometheus_alerts.yaml
	find . -name 'vendor' -prune -o -name '*.libsonnet' -print -o -name '*.jsonnet' -print | \
		while read f; do \
			$(JSONNET_FMT) "$$f" | diff -u "$$f" -; \
		done

	promtool check rules prometheus_alerts.yaml

clean:
	rm -rf prometheus_alerts.yaml

yamlfmt: 
	yamlfmt -filename prometheus_alerts.yaml

test: prometheus_alerts.yaml
	promtool test rules tests.yaml
