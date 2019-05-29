![ceph-monitoring-mixin](http://devopy.io/wp-content/uploads/2019/02/ceph-monitoring-mixin-200.png)

# Ceph monitoring mixin

![Build Status](https://travis-ci.com/devopyio/ceph-monitoring-mixin.svg?branch=master)

A set of Grafana dashboards and Prometheus alerts for Ceph for use in Prometheus & Alertmanager.

## Relationship with ceph-mixins

We have contributed a lot of our alerting configuration to [ceph/ceph-mixins](https://github.com/ceph/ceph-mixins) repository.

But currently, the state of play there is that maintainers don't allow us adding `grafana_url` and `runbook` annotations as they wouldn't look good in Open Shift Container Platform UI and doesn't fit their needs. See the issue https://github.com/ceph/ceph-mixins/issues/54.

This repository adds an opinionated annotations to the alerting rules for running them in Prometheus and Alertmanager.

If you are looking to use it with Open Shift Container Platform UI, please use [ceph/ceph-mixins](https://github.com/ceph/ceph-mixins) directly.

## How to use

This mixin is designed to be vendored into the repo with your infrastructure config.
To do this, use [jsonnet-bundler](https://github.com/jsonnet-bundler/jsonnet-bundler):

Generate the config files and deploy them yourself

## Generate config files

You can manually generate the alerts files, but first you must install some tools:

```
$ make setup
```

Mac: 
```
$ brew install jsonnet
```

Linux:
```
sudo snap install jsonnet
```

Then, grab the mixin and its dependencies:

```
$ git clone https://github.com/devopyio/ceph-monitoring-mixin
$ cd ceph-monitoring-mixin
$ jb install
```

Finally, build the mixin:

```
$ make prometheus_alerts.yaml
```

The `prometheus_alerts.yaml` file then need to passed to your Prometheus server, 
The exact details will depending on how you deploy your Prometheus.

